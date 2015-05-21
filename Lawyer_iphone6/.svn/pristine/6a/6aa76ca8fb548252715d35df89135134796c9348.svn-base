//
//  ProcessFragmentViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-10.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProcessFragmentViewController.h"

#import "HttpClient.h"

#import "ClientDocCell.h"

#import "DocumentViewController.h"
#import "NSString+Utility.h"
#import "RevealViewController.h"

#import "ProcessCommentViewController.h"
#import "AttachViewController.h"
#import "CommentEditViewController.h"
#import "ProcessFragmentNewViewController.h"

@interface ProcessFragmentViewController ()<RequestManagerDelegate,ClientDocCellDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    
    HttpClient *_commentHttpClient;
    
    NSDictionary *_record;
    
    UITableView *_tableview;
    
    ClientDocCell *_clientDocCell;
    
    DocumentViewController *documentViewController;
    
    ProcessCommentViewController *_processCommentViewController;
    
    CommentEditViewController *_commentEditViewController;
    
    ProcessFragmentNewViewController *_processFragmentNewViewController;
}

@end

@implementation ProcessFragmentViewController

@synthesize contentView = _contentView;

@synthesize titleLabel = _titleLabel;
@synthesize nameLabel = _nameLabel;
@synthesize dateLabel = _dateLabel;
@synthesize stateLabel = _stateLabel;

@synthesize processView = _processView;
@synthesize processImageView = _processImageView;
@synthesize processLabel = _processLabel;

@synthesize contentLabel = _contentLabel;

@synthesize timeLabel = _timeLabel;

@synthesize managerLabel = _managerLabel;
@synthesize memberLabel = _memberLabel;

@synthesize attachLabel = _attachLabel;

@synthesize commentButton = _commentButton;

@synthesize caseID = _caseID;
@synthesize ywcpID = _ywcpID;

UIImage *_planImage;
UIImage *_doneImage;
UIImage *_doingImage;
UIImage *_undoneImage;

+ (void)initialize{
    _planImage = [UIImage imageNamed:@"process_plan_logo.png"];
    _doneImage = [UIImage imageNamed:@"process_done_logo.png"];
    _doingImage = [UIImage imageNamed:@"process_doing_logo.png"];
    _undoneImage = [UIImage imageNamed:@"process_undone_logo.png"];
}

- (void)touchRightEvent:(UIButton*)button{
    if (button.tag == 0) {
        _processFragmentNewViewController = [[ProcessFragmentNewViewController alloc] init];
        _processFragmentNewViewController.record = _record;
        _processFragmentNewViewController.caseID = _caseID;
        _processFragmentNewViewController.ywcpID = _ywcpID;
        _processFragmentNewViewController.proceeFragment = ProceeFragmentEdit;
        [self.navigationController pushViewController:_processFragmentNewViewController animated:YES];
    }
    else if (button.tag == 1){
        [self.revealContainer showRight];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    [_httpClient startRequest:[self requestParam]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"进程阶段详情" color:nil];
 
    
    NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"blut_edit_logo.png"],@"image",nil,@"selectedImage", nil];
    NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
    NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
    [self setNavigationSegmentWithImages:images target:self action:@selector(touchRightEvent:)];
    
    _processImageView.layer.borderColor = [@"#EC1C24" colorValue].CGColor;
    _processImageView.layer.borderWidth = 0.5f;
    
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarShow:) name:UIKeyboardDidShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardDidHideNotification object:nil];
    
    _commentEditViewController = [[CommentEditViewController alloc] init];
}

- (NSDictionary*)requestParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_ywcpID,@"ywcpID",_caseID,@"caseID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"caseprocessdetail",@"requestKey",fields,@"fields", nil];
    return param;
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;

    if (request == _httpClient) {
        _record = [dic objectForKey:@"record"];
        
        _titleLabel.text = [_record objectForKey:@"ywcp_title"];
        _nameLabel.text = [_record objectForKey:@"ywcp_creator"];
        _dateLabel.text = [_record objectForKey:@"ywcp_create_date"];
        _stateLabel.text = [_record objectForKey:@"ywcp_typename"];
        [self setStateFlag:[_record objectForKey:@"ywcp_typename"]];
        
        if ([[_record objectForKey:@"ywcp_detail"] length] == 0) {
            _contentLabel.text = @"未设置";
        }
        else{
            _contentLabel.text = [_record objectForKey:@"ywcp_detail"];
            [_contentLabel sizeToFit];
        }
        if ([[_record objectForKey:@"ywcp_date"] length] > 0 && [_record objectForKey:@"ywcp_end_date"] > 0) {
            _timeLabel.text = [NSString stringWithFormat:@"进程日期：%@ 至 %@",[_record objectForKey:@"ywcp_date"],[_record objectForKey:@"ywcp_end_date"]];
        }
        else{
            _timeLabel.text = [NSString stringWithFormat:@"进程日期：未设置 至 未设置"];
        }
        
       
        
        NSString *progress = [_record objectForKey:@"ywcp_complete"];
        
        if (progress.length == 0) {
            progress = @"0";
        }
        
        _processLabel.text = [NSString stringWithFormat:@"%@%@",progress,@"%"];
        _processView.layer.borderColor = [@"#EC1C24" colorValue].CGColor;
        _processView.layer.borderWidth = 0.5f;

        
        for (NSLayoutConstraint *layout in _processImageView.constraints) {
            layout.constant = progress.integerValue*0.4;
        }
        
        
        
        _managerLabel.text= [_record objectForKey:@"ywcp_emp_name"];
        
        
        
        NSMutableString *memberStr = [[NSMutableString alloc] init];
        
        for (NSDictionary *item in [_record objectForKey:@"group_list"]) {
            NSString *name = [NSString stringWithFormat:@"%@  ",[item objectForKey:@"ywcp_group_name"]];
            [memberStr appendString:name];
        }
        _memberLabel.text = memberStr;
        
         
        NSArray *files = [_record objectForKey:@"file_list"];
        
//        for (NSLayoutConstraint *layout in _contentView.constraints) {
//            if (layout.firstItem == _contentView && layout.firstAttribute == NSLayoutAttributeHeight) {
//                layout.constant = 400+_tableview.frame.size.height+_contentLabel.frame.size.height;
//            }
//        }
        
        if ([files count] > 0) {
            _attachLabel.text = [NSString stringWithFormat:@"附件(%lu)",(unsigned long)[files count]];
            
            _clientDocCell = [[ClientDocCell alloc] init];
           
            [_tableview reloadData];
            
             _topMargin.constant = files.count *70;

            _viewheight.constant = 420+files.count*70+_contentLabel.frame.size.height;
        }
        else{
            _attachLabel.text = @"附件";
        }
        
        
       
        
        
        NSString *comment = [NSString stringWithFormat:@"%@(%@)",[_record objectForKey:@"ywcp_replyCnt"],[_record objectForKey:@"ywcp_newreplyCnt"]];
        [_commentButton setTitle:comment forState:UIControlStateNormal];
    }
    else if (request == _commentHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"评论成功"];
        }
        else{
            [self showHUDWithTextOnly:@"评论失败"];
        };
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_record objectForKey:@"file_list"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClientDocCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientDocCell"];
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:@"ClientDocCell" owner:self options:nil];
        cell = _clientDocCell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    cell.delegte =self;
    NSArray *datas = (NSArray*)[_record objectForKey:@"file_list"];//zhuancun.png
    NSDictionary *mapping =  (NSDictionary*)[datas objectAtIndex:indexPath.row];
    if ([[mapping objectForKey:@"cpa_document_id"] length] > 0) {
        cell.button.hidden = YES;
    }
    else{
        cell.button.hidden = NO;
    }
    
    cell.titleLabel.text = [mapping objectForKey:@"cpa_file_name"];
    cell.nameLabel.text = [mapping objectForKey:@"cpa_creator_name"];
    cell.dateLabel.text = [mapping objectForKey:@"cpa_create_date"];
    cell.logoImageView.image = [self.view checkResourceType:[mapping objectForKey:@"cpa_file_type"]];
    return cell;

}

- (void)didTouchZhuanEvent:(NSInteger)tag{
    NSArray *datas = (NSArray*)[_record objectForKey:@"file_list"];//zhuancun.png
    NSDictionary *mapping =  (NSDictionary*)[datas objectAtIndex:tag];
    
    AttachViewController* attachViewController = [[AttachViewController alloc] init];
    attachViewController.caseID = _caseID;
    attachViewController.item = mapping;
    attachViewController.caseName = [_record objectForKey:@"ca_case_name"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:attachViewController];
    [self presentViewController:nav animated:YES completion:nil];

    
}
/*
 
 {
 "cpa_create_date" = "2015-03-14";
 "cpa_creator_name" = "\U9093\U5929\U7136";
 "cpa_doc_dir" = "";
 "cpa_document_id" = "";
 "cpa_file_length" = 0;
 "cpa_file_name" = "201503141028.txt";
 "cpa_file_type" = txt;
 "cpa_file_url" = "http://test.elinklaw.com/system/downloadfile.aspx?DownType=processattachment&DocumentID=CPA00000509";
 "cpa_id" = CPA00000509;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *datas = (NSArray*)[_record objectForKey:@"file_list"];
    if (_record.count > 0) {
        NSDictionary *mapping =  (NSDictionary*)[datas objectAtIndex:indexPath.row];
        
        documentViewController = [[DocumentViewController alloc] init];
        
        documentViewController.pathString = [mapping objectForKey:@"cpa_file_url"];
        documentViewController.type = [mapping objectForKey:@"cpa_file_type"];
        documentViewController.name = [mapping objectForKey:@"cpa_file_name"];
        [self.navigationController pushViewController:documentViewController animated:YES];
    }
    
    
}

- (IBAction)touchCommentEvent:(id)sender{
    _processCommentViewController = [[ProcessCommentViewController alloc] init];
    _processCommentViewController.caseID = _caseID;
    _processCommentViewController.caseName = [_record objectForKey:@"ca_case_name"];
    _processCommentViewController.ywcpID = _ywcpID;
    [self.navigationController pushViewController:_processCommentViewController animated:YES];
}

- (void)setStateFlag:(NSString*)flag{
    if ([flag isEqualToString:@"未设置"]) {
        _stateLabel.textColor = [@"#E88D0A" colorValue];
    }
    else if ([flag isEqualToString:@"正在进行"]) {
       
        _stateLabel.textColor = [@"#72BE4F" colorValue];
    }
    else if ([flag isEqualToString:@"计划中"]) {
       
        _stateLabel.textColor = [@"#00ADEE" colorValue];
    }
    else if ([flag isEqualToString:@"已完成"]) {
       
        _stateLabel.textColor = [@"#ED3B75" colorValue];
    }
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
    [self showHUDWithTextOnly:@"加载错误"];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _commentEditViewController = [[CommentEditViewController alloc] init];
    _commentEditViewController.caseID = _caseID;
    _commentEditViewController.ywcpID = _ywcpID;
    [self.navigationController pushViewController:_commentEditViewController animated:YES];
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
//    if ([textField hasText]) {
//        _commentHttpClient = [[HttpClient alloc] init];
//        _commentHttpClient.delegate = self;
//        [_commentHttpClient startRequest:[self commentParam]];
//    }
    
    return YES;
}

//- (NSDictionary*)commentParam{
//    NSString *content = @"";
//    if ([_commentField hasText] && _commentField.text.length > 0) {
//        content = _commentField.text;
//    }
//    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_caseID,@"caseID",_ywcpID,@"ywcpID",@"",@"cpr_files",content,@"cpr_detail", nil];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"caseprocssitemreply",@"requestKey", nil];
//    return param;
//}
//
//-(void)keyboarShow:(NSNotification *) notif
//{
//    
//    
//    NSDictionary *info = [notif userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
//    
//    for (NSLayoutConstraint *layout in self.view.constraints) {
//        if (layout.secondItem == _commentView && layout.secondAttribute == NSLayoutAttributeBottom) {
//            layout.constant = keyboardSize.height;
//        }
//        
//    }
//    
//}
//
//-(void)keyBoardHide
//{
//    
//    for (NSLayoutConstraint *layout in self.view.constraints) {
//        if (layout.secondItem == _commentView && layout.secondAttribute == NSLayoutAttributeBottom) {
//            layout.constant = 0;
//        }
//        
//    }
//}


@end
