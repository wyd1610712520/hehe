//
//  LogDetailViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-24.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LogDetailViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"

#import "LogCreateViewController.h"

#import "RootViewController.h"

#import "AlertView.h"

#import "LogAdviceViewController.h"

@interface LogDetailViewController ()<RequestManagerDelegate,UITextFieldDelegate,UIAlertViewDelegate,AlertViewDelegate>{
    HttpClient *_httpClient;
    
    LogCreateViewController *_logCreateViewController;
    
    NSDictionary *_editData;
    
    HttpClient *_auditHttpClient;
    
    RootViewController *_rootViewController;
    
    NSString *_status;
    
    NSString *_checkInfo;
        
    AlertView *_alertView;
    
    LogAdviceViewController *_logAdviceViewController;
    UINavigationController *_logAdviceNav;

    NSString *_infoText;
}

@end

@implementation LogDetailViewController

@synthesize logId = _logId;

 
@synthesize contentView = _contentView;

@synthesize statusLabel = _statusLabel;
@synthesize caseNameButton = _caseNameButton;
@synthesize caseIdField = _caseIdField;
@synthesize clientNameField = _clientNameField;
@synthesize clientIdField = _clientIdField;
@synthesize lawyerField = _lawyerField;
@synthesize logTypeButton = _logTypeButton;
@synthesize timeField = _timeField;
@synthesize contentLabel = _contentLabel;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     
    [_httpClient startRequest:[self requestParam]];
}

- (IBAction)touchCaseNameEvent:(id)sender
{
    _rootViewController = [[RootViewController alloc] init];
    [self presentViewController:_rootViewController animated:NO completion:nil];

    [_rootViewController showInCaseDetail];
    [_rootViewController.caseDetatilViewController setCaseId:_editData[@"wl_case_id"]];
}

- (IBAction)touchSureEvent:(id)sender{
    _status = @"A";
    
    if (_logAudtiState == LogAudtiStateAudit && !_isDone) {
        if (![_zhangdanLabel hasText]) {
            [self showHUDWithTextOnly:@"请填写账单小时"];
            return;
        }
        
        if (![_yewuLabel hasText]) {
            [self showHUDWithTextOnly:@"请填写业务小时"];
            return;
        }
        
        if ([_zhangdanLabel hasText] && [_yewuLabel hasText])
        {
            
            _alertView = [[AlertView alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 155)];
            _alertView.delegate = self;
            [_alertView showTextView:@""];
            
            _alertView.alertButtonType = AlertButtonTwo;
            
            [self.view addSubview:_alertView];
            
        }
    }
    
   
}

// 退回点击
- (IBAction)touchRejectEvent:(id)sender
{
    _status = @"B";
    
    _alertView = [[AlertView alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 155)];
    _alertView.delegate = self;
    [_alertView showTextView:@""];
    
    _alertView.tipLabel.text = @"请输入退回意见";
    
    _alertView.alertButtonType = AlertButtonTwo;
    
    [self.view addSubview:_alertView];

}



// 审核演示点击
- (IBAction)touchAuditDemoEvent:(id)sender
{
    _logAdviceViewController = [[LogAdviceViewController alloc] init];
    
    _logAdviceViewController.auditStatusStr = [_editData objectForKey:@"wl_status"];
    _logAdviceViewController.yewuHourStr = [_editData objectForKey:@"wl_check_hours"];
    _logAdviceViewController.zhangdanHourStr = [_editData objectForKey:@"wl_bill_hours"];
    _logAdviceViewController.auditPersonStr = [_editData objectForKey:@"wl_checkor_name"];
    _logAdviceViewController.auditAdviceStr = [_editData objectForKey:@"wl_check_info"];
    
    _logAdviceNav = [[UINavigationController alloc] initWithRootViewController:_logAdviceViewController];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:_logAdviceNav animated:NO completion:nil];
 
}

- (NSDictionary*)param{
    NSString *yewu = @"";
    if ([_yewuLabel hasText]) {
        yewu = _yewuLabel.text;
    }
    
    NSString *zhangdan = @"";
    if ([_zhangdanLabel hasText]) {
        zhangdan = _zhangdanLabel.text;
    }
    
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_logId,@"worklogID",
                            yewu,@"wl_check_hours",
                            zhangdan,@"wl_bill_hours",
                            [[CommomClient sharedInstance] getAccount],@"userID", _status,@"wl_status", _infoText,@"wl_check_info", nil];

    NSArray *list = [NSArray arrayWithObjects:fields, nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"workLogCheck",@"requestKey",list,@"fields_list", nil];

    return param;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (NSDictionary*)requestParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_logId,@"worklogID",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"workLoggetDetail",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _auditHttpClient = [[HttpClient alloc] init];
    _auditHttpClient.delegate = self;
    [self setTitle:@"日志详情" color:nil];

    if (_logAudtiState == LogAudtiStateNormal) {
        
        if ([_auditStatus isEqualToString:@"N"])
        {
            _auditDemoButton.hidden = YES;
        }
        
        _fristImageView.hidden = YES;
        _secondImageView.hidden = YES;
        
        _auditView.hidden = NO;
        _sureView.hidden = YES;
        for (NSLayoutConstraint *layout in _contentView.constraints) {
            if (layout.firstItem == _miaoshuLabel && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 1;
            }
        }
        [self setRightButton:[UIImage imageNamed:@"blut_edit_logo.png"] title:nil target:self action:@selector(touchEditEvent)];

    }
    else if (_logAudtiState == LogAudtiStateAudit) {
        
        _auditDemoButton.hidden = YES;
        
        _sureView.hidden = NO;
        _auditView.hidden = NO;
        _yewuLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _yewuLabel.layer.borderWidth = 0.5f;
        
        _fristImageView.hidden = YES;
        _secondImageView.hidden = YES;
        
        _zhangdanLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _zhangdanLabel.layer.borderWidth = 0.5f;
        
        _zhangdanLabel.enabled = YES;
        _yewuLabel.enabled = YES;
        
        if (_isDone) {
            _zhangdanLabel.enabled = NO;
            _yewuLabel.enabled = NO;
        }
        
        
        for (NSLayoutConstraint *layout in _contentView.constraints) {
            if (layout.firstItem == _miaoshuLabel && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 94;
            }
        }
        
        _topMar.constant = 0;
    }
    
}


- (void)alertView:(AlertView *)alertView field:(NSString *)text{
    _infoText = text;
    if (text.length <= 100)
    {
        if ([_status isEqualToString:@"B"] && text.length > 0)
        {
            [_auditHttpClient startRequest:[self param]];
        }
        if ([_status isEqualToString:@"B"] && text.length == 0)
        {
            [self showHUDWithTextOnly:@"请输入退回意见"];
        }
        
        if ([_status isEqualToString:@"A"])
        {
            [_auditHttpClient startRequest:[self param]];
        }
    }
    else
    {
        if ([_status isEqualToString:@"A"])
        {
            [self showHUDWithTextOnly:@"审核意见不得超过100字"];
        }
        else if ([_status isEqualToString:@"B"])
        {
            [self showHUDWithTextOnly:@"退回意见不得超过100字"];
        }
    }
}

- (void)touchEditEvent{
    _logCreateViewController = [[LogCreateViewController alloc] init];
    _logCreateViewController.logType = LogTypeEdit;
    _logCreateViewController.editData = _editData;
    _logCreateViewController.logID = _logId;
    [self.navigationController pushViewController:_logCreateViewController animated:YES];
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    
    if (request == _httpClient) {
        NSDictionary *item = [dic objectForKey:@"record"];
        
        _editData = item;
        
        if ([[item objectForKey:@"wl_status"] isEqualToString:@"N"]) {
            _statusLabel.text = @"未审核";
            [_statusLabel setTextColor:[UIColor redColor]];
            
            if (_logAudtiState == LogAudtiStateNormal) {
               
                [self setRightButton:[UIImage imageNamed:@"blut_edit_logo.png"] title:nil target:self action:@selector(touchEditEvent)];
                
            }
            
            _yewuLabel.text = @"";
            _zhangdanLabel.text = @"";
            
        }
        else{
            
            if (_logAudtiState == LogAudtiStateAudit) {
                
                _sureView.hidden = YES;
                _yewuLabel.layer.borderColor = [UIColor clearColor].CGColor;
                _yewuLabel.layer.borderWidth = 0.0f;
                
                _zhangdanLabel.layer.borderColor = [UIColor clearColor].CGColor;
                _zhangdanLabel.layer.borderWidth = 0.0f;

            }
            
            _yewuLabel.text = [item objectForKey:@"wl_check_hours"];
            _zhangdanLabel.text = [item objectForKey:@"wl_bill_hours"];

            if ([[item objectForKey:@"wl_status"] isEqualToString:@"A"]){
                _statusLabel.text = @"已审核";
                [_statusLabel setTextColor:[UIColor blackColor]];
            }
            
            if ([[item objectForKey:@"wl_status"] isEqualToString:@"B"]){
                _statusLabel.text = @"被退回";
                [_statusLabel setTextColor:[UIColor redColor]];
            }
            
            [self setRightButton:nil title:nil target:self action:@selector(touchEditEvent)];
            
        }
        
        
        [_caseNameButton setTitle:[item objectForKey:@"ca_case_name"] forState:UIControlStateNormal];
        _caseIdField.text = [item objectForKey:@"wl_case_id"];
        _clientNameField.text = [item objectForKey:@"cl_client_name"];
        _clientIdField.text = [item objectForKey:@"cl_client_id"];
        _lawyerField.text = [item objectForKey:@"empName"];
        
        [_logTypeButton setTitle:[item objectForKey:@"wl_workType_name"] forState:UIControlStateNormal];
        _timeField.text = [item objectForKey:@"wl_own_hours"];
        _contentLabel.text = [item objectForKey:@"wl_description"];
         [_contentLabel sizeToFit];
        
        _logCateLabel.text = [item objectForKey:@"wl_category_name"];
        
        _workTimeField.text = [NSString stringWithFormat:@"%@ - %@，%@",[self getDate:[item objectForKey:@"start_time"]],[self getDate:[item objectForKey:@"end_time"]],[item objectForKey:@"wl_start_date"]];
        
        [_caseNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_logTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        for (NSLayoutConstraint *layout in _contentView.constraints) {
            if (layout.firstItem == _contentView && layout.firstAttribute == NSLayoutAttributeHeight) {
                layout.constant = 900;
            }
        }

    }
    else if (request == _auditHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            if ([_status isEqualToString:@"A"])
            {
                [self showHUDWithTextOnly:@"审核成功"];
            }
            else if ([_status isEqualToString:@"B"])
            {
                [self showHUDWithTextOnly:@"日志退回成功"];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"审核失败"];
        }
    }
    
}


- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

- (NSString*)getDate:(NSString*)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:string];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *time = [dateFormatter stringFromDate:date];
    return time;
    
}

@end
