//
//  CommentViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-9.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommentViewController.h"

#import "CommentCell.h"

#import "NSString+Utility.h"

#import "HttpClient.h"

#import "UIButton+AFNetworking.h"
#import "CustomTextField.h"

#import "CommomClient.h"

@interface CommentViewController ()<UITableViewDataSource,UITextViewDelegate,UITableViewDelegate,SegmentViewDelegate,RequestManagerDelegate,PullToRefreshDelegate,CommentCellDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    int currentPage;
    
    HttpClient *_httpClient;
    CGFloat _keyHeight;
    HttpClient *_sendHttpClient;
    HttpClient *_deleteHttpClient;
    
    HttpClient *_publicHttpClient;
    
    NSString *_public;
    BOOL isEdit;
    NSString *_rid_id;
    
    NSNotification *_notification;
    NSInteger _tag;
    
    UIView *_closeView;
}

@end

@implementation CommentViewController

@synthesize cooperationID = _cooperationID;

@synthesize commentView = _commentView;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self clearTableData];
    [_httpClient startRequest:[self requestParam:@"desc"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardDidHideNotification object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:[NSArray arrayWithObjects:@"最新回复",@"最早回复", nil]];
    self.titleSegment.delegate = self;
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [@"#F9F9F9" colorValue];
    self.tableView.rowHeight = 108;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    CGRect frame = self.tableView.frame;
    frame.size.height = self.view.frame.size.height -50;
    self.tableView.frame = frame;
    
    
    _sendHttpClient = [[HttpClient alloc] init];
    _sendHttpClient.delegate = self;
    _sendHttpClient.isChange = YES;
    _public = @"1";
    
    UINib *cellNib = [UINib nibWithNibName:@"CommentCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CommentCell"];
    
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    self.bottomRefreshIndicator.pullToRefreshDelegate = self;
    
    [self.view bringSubviewToFront:_commentView];
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    _httpClient.isChange = YES;
    
    _deleteHttpClient = [[HttpClient alloc] init];
    _deleteHttpClient.delegate = self;
    _deleteHttpClient.isChange = YES;
    
    _publicHttpClient = [[HttpClient alloc] init];
    _publicHttpClient.delegate = self;
    _publicHttpClient.isChange = YES;
    
    _closeView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _closeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
}

- (NSDictionary*)requestParam:(NSString*)sortType{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_cooperationID,@"rdi_id",sortType,@"sortType", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"cooperationreplylist",@"requestKey",[NSString stringWithFormat:@"%d",currentPage],@"currentPage",@"20",@"pageSize", nil];
    return param;
}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    [self clearTableData];
    if (button.tag == 0) {
        [_httpClient startRequest:[self requestParam:@"desc"]];
    }
    else if (button.tag == 1){
        [_httpClient startRequest:[self requestParam:@"asc"]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    NSString *path = [item objectForKey:@"rdr_creator_photo"];
    [cell.avatorButton setDownloadImage:path];
    cell.avatorButton.layer.borderColor = [UIColor clearColor].CGColor;
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ | %@",[item objectForKey:@"rdr_creator_name"],[item objectForKey:@"rdr_creator_office"]];
    cell.dateLabel.text = [item objectForKey:@"rdr_create_date"];
    
    cell.delegate = self;
    cell.tag = indexPath.row;
    
    NSString *is_public = [item objectForKey:@"rdr_is_public"];
    if ([is_public isEqualToString:@"0"]) {
        NSString *id1 = [item objectForKey:@"rdr_creator"];
        NSString *id2 = [[CommomClient sharedInstance] getValueFromUserInfo:@"userKey"];
        if (![id1 isEqualToString:id2]) {
            
            if (![id2 isEqualToString:_rdi_creator]) {
                cell.contentLabel.text = @"该回复为私密回复，您没有权限查看";
                cell.contentLabel.textColor = [UIColor lightGrayColor];
                [cell isShowButton:YES];
                cell.nameLabel.text = @"匿名";
                [cell.avatorButton setBackgroundImage:[UIImage imageNamed:@"avator.png"] forState:UIControlStateNormal];
            }
            else{
                NSString *name = [NSString stringWithFormat:@"[私密]%@",[item objectForKey:@"rdr_content"]];
                NSRange range = [name rangeOfString:@"[私密]"];
                if (range.location != NSNotFound) {
                    NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:name];
                    [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
                    cell.contentLabel.attributedText = caseString;
                    cell.publicButton.hidden = YES;
                    cell.deleteButton.hidden = YES;
                }

            }
            
        }
        else{
            cell.contentLabel.text = [item objectForKey:@"rdr_content"];
            cell.contentLabel.textColor = [UIColor blackColor];
            [cell isShowButton:NO];
            [cell.publicButton setTitle:@"设置为公开" forState:UIControlStateNormal];
            
            NSString *name = [NSString stringWithFormat:@"[私密]%@",[item objectForKey:@"rdr_content"]];
            NSRange range = [name rangeOfString:@"[私密]"];
            if (range.location != NSNotFound) {
                NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:name];
                [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
                cell.contentLabel.attributedText = caseString;
            }
            
            
            
        }
        
    }
    else{
        NSString *id1 = [item objectForKey:@"rdr_creator"];
        NSString *id2 = [[CommomClient sharedInstance] getValueFromUserInfo:@"userKey"];
        if (![id1 isEqualToString:id2]) {
            cell.contentLabel.text = [item objectForKey:@"rdr_content"];
            cell.contentLabel.textColor = [UIColor blackColor];
            [cell isShowButton:YES];
        }
        else{
            cell.contentLabel.text = [item objectForKey:@"rdr_content"];
            cell.contentLabel.textColor = [UIColor blackColor];
            [cell isShowButton:NO];
            [cell.publicButton setTitle:@"设置为私密" forState:UIControlStateNormal];
        }
        
        
    }
    
    return cell;
}

- (void)publicCommentCell:(CommentCell *)commentCell tag:(NSInteger)tag{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:tag];
    _rid_id = [item objectForKey:@"rdr_id"];
    _textView.text = [item objectForKey:@"rdr_content"];
    isEdit = YES;
    
    if ([[item objectForKey:@"rdr_is_public"] isEqualToString:@"0"]) {
        _public = @"1";
        //[commentCell.publicButton setTitle:@"设置为公开" forState:UIControlStateNormal];
    }
    else{
        _public = @"0";
       // [commentCell.publicButton setTitle:@"设置为公开" forState:UIControlStateNormal];
    }

    //[self keyboarShow:_notification];
    [self touchSureEvent:nil];
    _tag = tag;
}

- (void)deleteCommentCell:(CommentCell *)commentCell tag:(NSInteger)tag{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:tag];
    _rid_id = [item objectForKey:@"rdr_id"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    [alertView show];
    
    _tag = tag;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [_deleteHttpClient startRequest:[self deleteParam]];
    }
}


- (NSDictionary*)deleteParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_rid_id,@"rdr_id",_cooperationID,@"rdi_id",@"delete",@"action_type",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"cooperationreplyaction",@"requestKey", nil];
    return param;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    NSString *is_public = [item objectForKey:@"rdr_is_public"];
    BOOL show;
    if ([is_public isEqualToString:@"0"]) {
        
        NSString *id1 = [item objectForKey:@"rdr_creator"];
        NSString *id2 = [[CommomClient sharedInstance] getValueFromUserInfo:@"userKey"];
        if (![id1 isEqualToString:id2]) {
            show = YES;
        }
        else{
            show = NO;
        }
    }
    else{
        show = NO;
    }
    CGFloat height = [CommentCell heightForRow:[item objectForKey:@"rdr_content"] show:show];
   
    return height+5;
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    if (request == _httpClient) {
        
        for (NSDictionary *item in [result objectForKey:@"record_list"]) {
            if (![self.indexSet containsObject:[item objectForKey:@"rdr_id"]]) {
                [self.indexSet addObject:[item objectForKey:@"rdr_id"]];
                [self.tableDatas addObject:item];
            }
        }
        [self.topRefreshIndicator didLoadComplete:nil];
        [self.bottomRefreshIndicator didLoadComplete:nil];
        [self.tableView reloadData];
    }
    else if (request == _sendHttpClient){
 
        [self clearTableData];
        [_httpClient startRequest:[self requestParam:@"desc"]];
        [self keyBoardHide];
    }
    else if (request == _deleteHttpClient){
        if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
            //[self showHUDWithTextOnly:@"删除成功"];
            [self clearTableData];
            [_httpClient startRequest:[self requestParam:@"desc"]];
        }
        else{
            [self showHUDWithTextOnly:@"删除失败"];
        }
       
    }
    
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
    
    [_httpClient startRequest:[self requestParam:@"desc"]];
   
}

-(void)keyboarShow:(NSNotification *) notif
{
    [self.view insertSubview:_closeView atIndex:2];
    _notification = notif;
    _commentView.hidden = NO;
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    _keyHeight = keyboardSize.height;
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _commentView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = _keyHeight-50;
        }
        
    }
    
    [_textView becomeFirstResponder];
}



-(void)keyBoardHide
{
    
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _commentView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = 0;
        }
        
    }
    [_closeView removeFromSuperview];
    _commentView.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}



- (IBAction)touchCloseButton:(id)sender {
    [_textView resignFirstResponder];
    [_closeView removeFromSuperview];
    [_commentField resignFirstResponder];
    [self keyBoardHide];
}

- (IBAction)touchSureEvent:(id)sender {
    if (![_textView hasText]) {
        [self showHUDWithTextOnly:@"请输入评论"];
        return;
    }
    
    if (isEdit) {
        [_sendHttpClient startRequest:[self commentParam:_rid_id content:_textView.text public:_public]];
    }
    else{
        [_sendHttpClient startRequest:[self commentParam:@"" content:_textView.text public:_public]];
    }
    _textView.text = @"";
    
    
    [_textView resignFirstResponder];
}

- (NSDictionary*)commentParam:(NSString*)rdr_id content:(NSString*)content public:(NSString*)public{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_cooperationID,@"rdi_id",rdr_id,@"rdr_id",content,@"rdr_content",public,@"rdr_is_public", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"cooperationreplyedit",@"requestKey",fields,@"fields", nil];
    return param;
}

- (IBAction)touchSwitchEvent:(UISwitch*)sender {
    if (sender.on) {
        _public = @"0";
    }
    else{
        _public = @"1";
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    isEdit = NO;
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _commentView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = _keyHeight-50;
        }
        
    }
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self keyBoardHide];
        return NO;
    }
    return YES;
}

@end
