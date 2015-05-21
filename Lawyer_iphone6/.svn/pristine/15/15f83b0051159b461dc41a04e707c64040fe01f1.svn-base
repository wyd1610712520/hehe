//
//  ProcessDetailViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProcessDetailViewController.h"

#import "ProcessDetailRightViewController.h"

#import "HttpClient.h"
#import "RevealViewController.h"
#import "CommomClient.h"
#import "NSString+Utility.h"

#import "ProcessCommentViewController.h"

#import "ProcessFragmentViewController.h"

#import "UIView+SubviewHunting.h"

#import "ProcessDetailCell.h"

#import "RootViewController.h"

#import "ProcessFragmentNewViewController.h"

#import "EditableTableController.h"

@interface ProcessDetailViewController ()<UITableViewDataSource,UIAlertViewDelegate,EditableTableControllerDelegate,ProcessDetailCellDelegate,UITableViewDelegate,RequestManagerDelegate>{
    ProcessDetailRightViewController *_processDetailRightViewController;
    
    HttpClient *_httpClient;
    HttpClient *_moveHttpClient;
    
    ProcessCommentViewController *_processCommentViewController;
    
    HttpClient *_deleteHttpClient;
    
    NSInteger _curDeleteTag;
    
    NSDictionary *_record;
    
    NSMutableArray *_indexs;
    RootViewController *_rootViewController;
    
    ProcessFragmentViewController *_processFragmentViewController;
    ProcessFragmentNewViewController *_processFragmentNewViewController;
    
    EditableTableController *_editableTableController;
    
    NSDictionary *moveItem;
    NSDictionary *_placeholderItem;
}

@end

@implementation ProcessDetailViewController

@synthesize headerView = _headerView;
@synthesize processDetailCell = _processDetailCell;
@synthesize processDetail = _processDetail;
@synthesize caseID = _caseID;

- (void)popSelf{
    [super popSelf];
}

- (void)dismiss{
    [super dismiss];
    if (_ispop) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"backpop" object:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self showTable];
    //self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //self.tableView.frame = self.view.bounds;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 215.0f;
    self.tableView.tableHeaderView = _headerView;
    
    self.tableView.backgroundColor = [@"#F9F9F9" colorValue];
    
    
    
    
    [_headerView setBackgroundColor:[@"#F9F9F9" colorValue]];
    
    UINib *cellNib = [UINib nibWithNibName:@"ProcessDetailCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ProcessDetailCell"];
    
    [self setDismissButton];
    

    if (_processDetail == ProcessDetailNormal) {
        [self setTitle:[Utility localizedStringWithTitle:@"client_process_detail_nav_title"] color:nil];
        _deleteHttpClient = [[HttpClient alloc] init];
        _deleteHttpClient.delegate = self;
        
        [_httpClient startRequest:[self detailParam]];
        _processCommentViewController = [[ProcessCommentViewController alloc] init];
        
        NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_add_btn.png"],@"image",nil,@"selectedImage", nil];
        NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
        NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
        [self setNavigationSegmentWithImages:images target:self action:@selector(touchRightEvent:)];

    }
    else if (_processDetail == ProcessDetailEdit){
        [self setTitle:@"模板预览" color:nil];
        
        //_caseID = [_record objectForKey:@"ca_case_id"];
       
    }
    self.tableView.estimatedRowHeight = 200;
    _editableTableController = [[EditableTableController alloc] initWithTableView:self.tableView];
    _editableTableController.delegate = self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesUpProcess) name:@"receivesUpProcess" object:nil];

    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;

    
    _placeholderItem = [[NSDictionary alloc] init];
    _moveHttpClient = [[HttpClient alloc] init];
    _moveHttpClient.delegate = self;
}


- (void)receivesUpProcess{
    [_httpClient startRequest:[self detailParam]];
    _isScrollBottom = YES;
}

- (NSDictionary*)detailParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_caseID,@"caseID",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"caseProcessView",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_processDetailRightViewController.view removeFromSuperview];
}

- (void)touchRightEvent:(UIButton*)sender{
  //  [self showRight];
    if (sender.tag == 0) {
        _processFragmentNewViewController = [[ProcessFragmentNewViewController alloc] init];
        _processFragmentNewViewController.caseID = _caseID;
        [self.navigationController pushViewController:_processFragmentNewViewController animated:YES];
    }
    else{
        _rootViewController.processDetailRightViewController.caseID = _caseID;
        _rootViewController.processDetailRightViewController.record = _record;;
        _rootViewController.processDetailRightViewController.clientID = [_record objectForKey:@"cl_client_id"];
        [self.revealContainer showRight];
    }
    
}

- (void)setRootView:(RootViewController*)rootViewController{
    _rootViewController = rootViewController;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleNone;
//}
//
//-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return NO;
//}

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
//    [self.tableDatas exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
//    for (NSDictionary *item in self.tableDatas) {
//        //NSLog(@"ywcp_sort_order=2=%@",[item objectForKey:@"ywcp_sort_order"]);
//    }
//}

//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    return [ProcessDetailCell heightForHeight:[item objectForKey:@"ywcp_detail"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProcessDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProcessDetailCell"];
//    if (!cell) {
//        [[NSBundle mainBundle] loadNibNamed:@"ProcessDetailCell" owner:self options:nil];
//        cell = _processDetailCell;
//    }
    
    cell.delegate = self;
    cell.tag = indexPath.row;
    
    [cell setBackgroundColor:[@"#F9F9F9" colorValue]];
    [cell.contentView setBackgroundColor:[@"#F9F9F9" colorValue]];
    
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    cell.tittleLabel.text = [item objectForKey:@"ywcp_title"];
    cell.nameLabel.text = [item objectForKey:@"ywcp_creator"];
    cell.dateLabel.text = [item objectForKey:@"ywcp_create_date"];
    
    if ([[item objectForKey:@"ywcp_detail"] length] > 0) {
        cell.contentLabel.text = [item objectForKey:@"ywcp_detail"];
    }
    else{
        cell.contentLabel.text = @"未设置";
    }
    
    if ([[item objectForKey:@"ywcp_date"] length] > 0 && [item objectForKey:@"ywcp_end_date"] > 0) {
        cell.timeLabel.text = [NSString stringWithFormat:@"进程日期：%@ 至 %@",[item objectForKey:@"ywcp_date"],[item objectForKey:@"ywcp_end_date"]];
    }
    else{
        cell.timeLabel.text = [NSString stringWithFormat:@"进程日期：未设置 至 未设置"];
    }
    
    if ([[item objectForKey:@"ywcp_detail"] length] > 0) {
        cell.managerLabel.text = [NSString stringWithFormat:@"负责人：%@",[item objectForKey:@"ywcp_emp_name"]];
    }
    else{
        cell.managerLabel.text = [NSString stringWithFormat:@"负责人：未设置"];
    }
    
    
    if ([item objectForKey:@"ywcp_replyCnt"] && [item objectForKey:@"ywcp_newreplyCnt"]) {
        NSString *comment = [NSString stringWithFormat:@"回复数：%@(%@)",[item objectForKey:@"ywcp_replyCnt"],[item objectForKey:@"ywcp_newreplyCnt"]];
        NSRange range = [comment rangeOfString:[item objectForKey:@"ywcp_newreplyCnt"] options:NSBackwardsSearch];
        NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:comment];
        [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        cell.commentLabel.attributedText = commentString;
    }
    
   

    [cell setStateFlag:[item objectForKey:@"ywcp_typename"]];
    
    
    cell.processView.layer.borderColor = [@"#EC1C24" colorValue].CGColor;
    cell.processView.layer.borderWidth = 0.5f;
    
    NSString *progress = [item objectForKey:@"ywcp_complete"];
    
    if (progress.length == 0) {
        progress = @"0";
    }
    
    cell.processLabel.text = [NSString stringWithFormat:@"%@%@",progress,@"%"];
    
    for (NSLayoutConstraint *layout in cell.processImageView.constraints) {
        layout.constant = progress.integerValue*0.4;
    }
    
    if ([[item objectForKey:@"ywcp_isread"] isEqualToString:@"0"]) {
        //未读
        cell.readImageVIew.hidden = NO;
    }
    else{
        cell.readImageVIew.hidden = YES;
    }
    if ([[item objectForKey:@"ywcp_right"] isEqualToString:@"0"]) {
        //无权
        _editableTableController.enabled = NO;
    }
    else{
        
    }
    
    
    return cell;
}

//- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UIView* reorderControl = [cell huntedSubviewWithClassName:@"UITableViewCellReorderControl"];
//    
//    
//    
//    UIView* resizedGripView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(reorderControl.frame), CGRectGetMaxY(reorderControl.frame))];
//    [resizedGripView addSubview:reorderControl];
//
//    [cell addSubview:resizedGripView];
//    
//    CGSize sizeDifference = CGSizeMake(resizedGripView.frame.size.width - reorderControl.frame.size.width, resizedGripView.frame.size.height - reorderControl.frame.size.height);
//    CGSize transformRatio = CGSizeMake(resizedGripView.frame.size.width / reorderControl.frame.size.width, resizedGripView.frame.size.height / reorderControl.frame.size.height);
//    
//    [reorderControl setBackgroundColor:[UIColor clearColor]];
//    
//    //	Original transform
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    
//    //	Scale custom view so grip will fill entire cell
//    transform = CGAffineTransformScale(transform, transformRatio.width, transformRatio.height);
//    
//    //	Move custom view so the grip's top left aligns with the cell's top left
//    transform = CGAffineTransformTranslate(transform, -sizeDifference.width / 2.0, -sizeDifference.height / 2.0);
//    
//    [resizedGripView setTransform:transform];
//    
//    reorderControl.hidden =YES;
//    
//    for(UIImageView* cellGrip in reorderControl.subviews)
//    {
//        if([cellGrip isKindOfClass:[UIImageView class]]){
//           // [cellGrip setImage:nil];
//            
//        }
//        
//
//        
//    }
//
//    
//    //UITableViewCellReorderControl
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    NSString *ywcp = [item objectForKey:@"ywcp_id"];
    
    _processFragmentViewController = [[ProcessFragmentViewController alloc] init];
    _processFragmentViewController.caseID = _caseID;
    _processFragmentViewController.ywcpID = ywcp;
    [self.navigationController pushViewController:_processFragmentViewController animated:YES];
}

- (void)processDetailCell:(ProcessDetailCell*)processDetailCell didTouchComment:(NSInteger)tag{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:tag];
    [self.navigationController pushViewController:_processCommentViewController animated:YES];
    _processCommentViewController.caseID = _caseID;
    _processCommentViewController.caseName = _caseNameLabel.text;
    _processCommentViewController.ywcpID = [item objectForKey:@"ywcp_id"];
}

- (void)processDetailCell:(ProcessDetailCell *)processDetailCell didTouchDelegate:(NSInteger)tag{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    [alertView show];
    _curDeleteTag = tag;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:_curDeleteTag];
        [_deleteHttpClient startRequest:[self deleteParam:_caseID ywcpID:[item objectForKey:@"ywcp_id"]]];

    }
}



- (void)processDetailCell:(ProcessDetailCell*)processDetailCell didTouchMove:(UIButton*)sender{
    
}

- (void)processDetailCell:(ProcessDetailCell*)processDetailCell didTouchCancel:(UIButton*)sender{
  //  [self.tableView setEditing:NO animated:NO];
    _editableTableController.enabled = NO;
}

- (void)processDetailCell:(ProcessDetailCell*)processDetailCell didTouchDown:(UIButton*)sender{
    //[self.tableView setEditing:YES animated:NO];
    _editableTableController.enabled = YES;
    
}

- (NSDictionary*)deleteParam:(NSString*)caseID ywcpID:(NSString*)ywcpID{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:caseID,@"caseID",ywcpID,@"ywcpID",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *parm = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"1",@"currentPage",@"10",@"pageSize",@"caseProcessItemDelete",@"requestKey", nil];
    return parm;
}



#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    
    _indexs = [[NSMutableArray alloc] init];
    _record= dic;
    int i = 0;
    
    if (request == _httpClient) {
        [self clearTableData];
        for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
            [self.tableDatas addObject:item];
            [_indexs insertObject:[item objectForKey:@"ywcp_sort_order"] atIndex:i];
            i++;
        }
        _caseID = [dic objectForKey:@"ca_case_id"];
        
        _caseNameLabel.text = [dic objectForKey:@"ca_case_name"];
        _caseIdLabel.text = [NSString stringWithFormat:@"案件编号：%@",[dic objectForKey:@"ca_case_id"]];
        _clientNameLabel.text = [NSString stringWithFormat:@"客户：%@",[dic objectForKey:@"cl_client_name"]];
        _caseTypeLabel.text = [NSString stringWithFormat:@"案件类别：%@",[dic objectForKey:@"ca_category"]];
        _manageLabel.text = [NSString stringWithFormat:@"负责人：%@",[dic objectForKey:@"ca_manager"]];
        _caseDateLabel.text = [NSString stringWithFormat:@"立案日期：%@",[dic objectForKey:@"ca_case_date"]];
        
        [self.tableView reloadData];
        
        if (_isScrollBottom) {
            int ta = self.tableDatas.count -1;
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:ta inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            _isScrollBottom = NO;
        }

    }
    else if (request == _deleteHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"删除成功"];
//            [self.tableView beginUpdates];
//            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:_curDeleteTag inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
//            
//            [self.tableView endUpdates];
            [self.tableDatas removeObjectAtIndex:_curDeleteTag];
            [self.tableView reloadData];
        }
        else{
            [self showHUDWithTextOnly:@"删除失败"];
        }
        
    }
    else if (request == _moveHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"调序成功"];
            
            [_httpClient startRequest:[self detailParam]];
        }
        else{
            [self showHUDWithTextOnly:@"调序失败"];
        }
        
    }

    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

#pragma mark - EditableTableViewDelegate

- (void)editableTableController:(EditableTableController *)controller willBeginMovingCellAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    [self.tableView beginUpdates];
    
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    moveItem = [self.tableDatas objectAtIndex:indexPath.row];
    [self.tableDatas replaceObjectAtIndex:indexPath.row withObject:_placeholderItem];
    
    [self.tableView endUpdates];
}

- (void)editableTableController:(EditableTableController *)controller movedCellWithInitialIndexPath:(NSIndexPath *)initialIndexPath fromAboveIndexPath:(NSIndexPath *)fromIndexPath toAboveIndexPath:(NSIndexPath *)toIndexPath
{
    [self.tableView beginUpdates];
    
    [self.tableView moveRowAtIndexPath:toIndexPath toIndexPath:fromIndexPath];
    
    NSString *item = [self.tableDatas objectAtIndex:toIndexPath.row];
    [self.tableDatas removeObjectAtIndex:toIndexPath.row];
    
    if (fromIndexPath.row == [self.tableDatas count])
    {
        [self.tableDatas addObject:item];
    }
    else
    {
        [self.tableDatas insertObject:item atIndex:fromIndexPath.row];
    }
    
    [self.tableView endUpdates];
}

- (BOOL)editableTableController:(EditableTableController *)controller shouldMoveCellFromInitialIndexPath:(NSIndexPath *)initialIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath withSuperviewLocation:(CGPoint)location
{
    
    CGRect exampleRect = (CGRect){0, 0, self.view.bounds.size.width, 44.0f};
    if (CGRectContainsPoint(exampleRect, location))
    {
        [self.tableView beginUpdates];
        
        [self.tableView deleteRowsAtIndexPaths:@[proposedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [self.tableDatas removeObjectAtIndex:proposedIndexPath.row];
        
        [self.tableView endUpdates];
        
        moveItem = nil;
        
        return NO;
    }
    
//    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:initialIndexPath.row];
//    if ([[item objectForKey:@"ywcp_right"] isEqualToString:@"0"]) {
//        //无权
//        return NO;
//    }
//    else{
//        return YES;
//    }
    
    return YES;
}

- (void)editableTableController:(EditableTableController *)controller didMoveCellFromInitialIndexPath:(NSIndexPath *)initialIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
    [self.tableDatas replaceObjectAtIndex:toIndexPath.row withObject:moveItem];
    
    [self.tableView reloadRowsAtIndexPaths:@[toIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    
    
    
    [_moveHttpClient startRequest:[self moveParam]];
    moveItem = nil;
}

- (NSDictionary*)moveParam{
    NSString *order = @"";
    for (NSDictionary *item in self.tableDatas) {
        order = [order stringByAppendingFormat:@"%@,",[item objectForKey:@"ywcp_id"]];

    }
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_caseID,@"caseID",order,@"ywcpOrder",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"caseprocessitemorder",@"requestKey",fields,@"fields", nil];
    return param;
}

@end
