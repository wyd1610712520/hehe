//
//  ProcessCommentViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 15-1-2.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ProcessCommentViewController.h"

#import "ProcessCommentCell.h"

#import "HttpClient.h"
#import "NSString+Utility.h"
#import "CommomClient.h"
#import "CommentMenuViewController.h"
#import "DocumentViewController.h"
#import "CommentEditViewController.h"

#import "AttachViewController.h"

@interface ProcessCommentViewController ()<SegmentViewDelegate,PullToRefreshDelegate,UITableViewDataSource,RequestManagerDelegate,UITableViewDelegate,UITextViewDelegate>{
    NSInteger curTag;
    
    HttpClient *_httpClient;
    HttpClient *_deleteClient;
    
    CommentMenuViewController *_commentMenuViewController;
    
    CommentEditViewController *_commentEditViewController;
    
    int currentPage;
    
    NSMutableSet *_readSet;
    NSMutableArray *_readArr;
    
    HttpClient *_readHttpClient;
    
    NSInteger _curDeleteIndex;
    float _topmaigin;
    
    UIButton *_curbutton;
    
    NSMutableArray *_indesArr;
}


@end

@implementation ProcessCommentViewController


@synthesize caseID= _caseID;
@synthesize ywcpID = _ywcpID;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    if (curTag == 0) {
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"desc"]];
    }
    else if (curTag == 1){
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"asc"]];
    }
    
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(showOperationView:) name:@"touch" object:nil];
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(touchOperationView:) name:@"touchce" object:nil];
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(receivesOperation) name:@"zhuancun" object:nil];
    
// 回复删除
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchDelete:) name:@"touchDelete" object:nil];
}

// 回复删除
//- (void)touchDelete:(id)sender {
//    
//    UITableViewCell * cell = (UITableViewCell *)[[[sender object]superview] superview];
//    
//    NSIndexPath * path = [self.tableView indexPathForCell:cell];
//    
//    NSLog(@"%ld", (long)[path row]);
//
//    [_deleteClient startRequest:[self deleteParam:(long)[path row]]];
//    
//    if (curTag == 0) {
//        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"desc"]];
//    }
//    else if (curTag == 1){
//        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"asc"]];
//    }
//
//    NSLog(@"%ld",self.tableDatas.count);
//}
// 删除请求
//- (NSDictionary*)deleteParam:(NSInteger)pathRow{
//    
//    NSString *idString = [[self.tableDatas objectAtIndex:pathRow] objectForKey:@"cpr_id"];
//
//    NSLog(@"%ld",self.tableDatas.count);
//
//    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:idString,@"cprID",_ywcpID,@"ywcpID",[[CommomClient sharedInstance] getAccount],@"userID", nil];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"caseprocessreplyDelete",@"requestKey", nil];
//    return param;
//}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _commentEditViewController = [[CommentEditViewController alloc] init];
    _commentEditViewController.caseID = _caseID;
    _commentEditViewController.ywcpID = _ywcpID;
    [self.navigationController pushViewController:_commentEditViewController animated:YES];
    return NO;
}

- (NSDictionary*)requestParam:(NSString*)caseID ywcpID:(NSString*)ywcpID sortType:(NSString*)sortType{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:caseID,@"caseID",ywcpID,@"ywcpID",sortType,@"sortType", nil];
    NSDictionary *parm = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",[NSString stringWithFormat:@"%d",currentPage],@"currentPage",@"30",@"pageSize",@"caseprocessitemreplylist",@"requestKey", nil];
    return parm;
}


- (void)sendCompelte{
    [self clearTableData];
    if (curTag == 0) {
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"desc"]];
    }
    else if (curTag == 1){
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"asc"]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setTitleView:[NSArray arrayWithObjects:@"最新回复",@"最早回复", nil]];
    self.titleSegment.delegate = self;
    
    _indesArr = [[NSMutableArray alloc] init];
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [@"#F9F9F9" colorValue];
    self.tableView.rowHeight = 60;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    UINib *cellNib = [UINib nibWithNibName:@"ProcessCommentCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ProcessCommentCell"];
    
    
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(sendCompelte) name:@"sendCompelte" object:nil];
    
  
    
    
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    self.bottomRefreshIndicator.pullToRefreshDelegate = self;

    _readArr = [[NSMutableArray alloc] init];
    _readSet = [[NSMutableSet alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesNotice) name:@"process_comment_read" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesDelete) name:@"deleteattach" object:nil];

    CGRect frame = self.tableView.frame;
    frame.origin.y = 0;
    frame.size.height = frame.size.height-5;
    self.tableView.frame = frame;
    
    _readHttpClient = [[HttpClient alloc] init];
    _readHttpClient.delegate = self;
    
    _deleteClient = [[HttpClient alloc] init];
    _deleteClient.delegate = self;
    
     self.navigationController.navigationBar.translucent = NO;
}


- (void)receivesNotice{
    [self.view bringSubviewToFront:_commentMenuViewController.view];
    _commentMenuViewController.topMargin.constant = _topmaigin;
}

- (void)receivesDelete{
    [self clearTableData];
    if (curTag == 0) {
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"desc"]];
    }
    else if (curTag == 1){
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"asc"]];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_readHttpClient startRequest:[self readParam]];
    [_commentMenuViewController.view removeFromSuperview];
    _commentMenuViewController = nil;
    _commentMenuViewController.view = nil;
    
}

- (NSDictionary*)readParam{
    NSMutableString *idString = [[NSMutableString alloc] initWithFormat:@""];
    for (NSDictionary *item in _readArr) {
        [idString appendFormat:@"%@,",[item objectForKey:@"cpr_id"]];
    }

    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:idString,@"cprID",_ywcpID,@"ywcpID",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"caseprocessreplyread",@"requestKey", nil];
    return param;
}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    [self clearTableData];
    curTag = button.tag;
    currentPage = 1;
    
    [_commentMenuViewController.view removeFromSuperview];
    if (button.tag == 0) {
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"desc"]];
    }
    else if (button.tag == 1){
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"asc"]];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (self.tableDatas.count > 0) {
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        if (![_readSet containsObject:[item objectForKey:@"cpr_id"]]) {
            [_readSet addObject:[item objectForKey:@"cpr_id"]];
            [_readArr addObject:item];
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProcessCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProcessCommentCell"];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"ProcessCommentCell" owner:self options:nil] lastObject];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    [cell.avatorButton setDownloadImage:[item objectForKey:@"cpr_creator_photo"]];
    cell.nameLabel.text = [item objectForKey:@"cpr_creator_name"];
    cell.timeLabel.text = [item objectForKey:@"cpr_create_date"];
    
    
    if ([[item objectForKey:@"cpr_isread"] isEqualToString:@"0"]) {
        cell.readImageView.hidden = NO;
        for (NSDictionary *record in _readArr) {
            NSString *readID = [record objectForKey:@"cpr_create_date"];
            if ([readID isEqualToString:[item objectForKey:@"cpr_create_date"]]) {
                cell.readImageView.hidden = YES;
            }
            
        }
        
        
    }
    else{
        cell.readImageView.hidden = YES;
    }
    
    NSString *right = [item objectForKey:@"cpr_canset"];
    if ([right isEqualToString:@"0"]) {
        cell.isAllRight = NO;
    }
    else{
        cell.isAllRight = YES;
    }
    
    cell.tag = indexPath.row;
    [cell setContent:[item objectForKey:@"cpr_detail"] files:[item objectForKey:@"file_list"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    return [ProcessCommentCell heightForRow:[item objectForKey:@"cpr_detail"] files:[item objectForKey:@"file_list"]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    if ([[item objectForKey:@"cpr_canset"] isEqualToString:@"1"]) {
        //删除
        return YES;
    }
    return NO;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        [self.tableDatas removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_deleteClient startRequest:[self deleteP:[item objectForKey:@"cpr_id"]]];
    }
    
}

- (NSDictionary*)deleteP:(NSString*)cprID{
    NSDictionary *field =[NSDictionary dictionaryWithObjectsAndKeys:cprID,@"cprID",_ywcpID,@"ywcpID",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"caseprocessreplyDelete",@"requestKey",field,@"fields", nil];
    return param;
}

- (void)showOperationView:(NSNotification*) notification{
    UIButton *commentFileView = (UIButton*)[notification object];
    ProcessCommentCell *cell = (ProcessCommentCell*)commentFileView.superview.superview;

    
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:cell.tag];
    
    if ([[item objectForKey:@"file_list"] count] > 0) {
        NSArray *files = [item objectForKey:@"file_list"];

        NSDictionary* record = [files objectAtIndex:commentFileView.tag];
        
        AttachViewController* _attachViewController = [[AttachViewController alloc] init];
        _attachViewController.caseID = _caseID;
        _attachViewController.item = record;
        _attachViewController.caseName = _caseName;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_attachViewController];
        [self presentViewController:nav animated:YES completion:nil];

    }
}

- (void)receivesOperation{
    [self clearTableData];
     currentPage = 1;
    
    [_commentMenuViewController.view removeFromSuperview];
    if (curTag == 0) {
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"desc"]];
    }
    else if (curTag == 1){
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"asc"]];
    }
}

- (void)touchOperationView:(NSNotification*)notificaiton{
    UIButton *commentFileView = (UIButton*)[notificaiton object];
    ProcessCommentCell *cell = (ProcessCommentCell*)commentFileView.superview.superview;
    
     NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:cell.tag];
    
    if ([[item objectForKey:@"file_list"] count] > 0) {
        NSArray *files = [item objectForKey:@"file_list"];
        
        
        DocumentViewController *documentViewController = [[DocumentViewController alloc] init];
        NSDictionary* record = [files objectAtIndex:commentFileView.tag];
        
        documentViewController.pathString = [record objectForKey:@"cpa_file_url"];
        documentViewController.type = [record objectForKey:@"cpa_file_type"];
        documentViewController.name = [record objectForKey:@"cpa_file_name"];
        documentViewController.view.tag = 100;
        [self presentViewController:documentViewController animated:YES completion:nil];
        
    }
}


#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    
    if (request == _httpClient){
        [self showProgressHUD:@""];
    }
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    
    if (request == _readHttpClient) {
        
    }
    else if (request == _httpClient){
        NSDictionary *dic = (NSDictionary*)responseObject;
        for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
            if (![self.indexSet containsObject:[item objectForKey:@"cpr_id"]]) {
                [self.indexSet addObject:[item objectForKey:@"cpr_id"]];
                [self.tableDatas addObject:item];
            }
            
        }
        
        [self.topRefreshIndicator didLoadComplete:nil];
        [self.bottomRefreshIndicator didLoadComplete:nil];
        
    }
    else if (request == _deleteClient){
        NSDictionary *dic = (NSDictionary*)responseObject;
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"删除成功"];
        }
        else{
            [self showHUDWithTextOnly:@"删除失败"];
        }
    }
    
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

#pragma mark - PullToRefreshDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.topRefreshIndicator didPull];
    if (self.tableDatas.count == 0) {
        return;
    }
    
    
    [self.bottomRefreshIndicator didPull];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.topRefreshIndicator didPullReleased];
    if (self.tableDatas.count == 0) {
        return;
    }
    [self.bottomRefreshIndicator didPullReleased];
}

- (void)didStartLoading:(PullToRefreshIndicator*)indicator{
    if (indicator == self.topRefreshIndicator) {
        currentPage = 1;
    }
    else{
        currentPage = 1 + currentPage;
    }
    
    
    
    
    if (curTag == 0) {
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"desc"]];
    }
    else if (curTag == 1){
        [_httpClient startRequest:[self requestParam:_caseID ywcpID:_ywcpID sortType:@"asc"]];
    }
}


@end
