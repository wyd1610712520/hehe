//
//  LogCreateViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LogCreateViewController.h"

#import "GeneralViewController.h"
#import "DateViewController.h"

#import "RootViewController.h"

#import "HttpClient.h"
#import "CommomClient.h"

#import "AlertView.h"

#import "LogDetailViewController.h"

#import "RootViewController.h"
#import "AppDelegate.h"

@interface LogCreateViewController ()<GeneralViewControllerDelegate,UIScrollViewDelegate,DateViewControllerDelegate,CaseViewControllerDelegate,RequestManagerDelegate,AlertViewDelegate>{
    GeneralViewController *_logJobViewController;
    GeneralViewController *_logTypeViewController;
    GeneralViewController *_lawTypeViewController;
    
    AlertView *_alertView;
    
    NSDictionary *_logJobDic;
    NSDictionary *_logTypeDic;
    
    RootViewController *_rootViewController;
    
    DateViewController *_jobTimeViewController;
    
    DateViewController *_startPicker;
    DateViewController *_endPicker;
    
    NSString *_startTime;
    NSString *_endTime;
    
    NSString *_schem_id;
    
    HttpClient *_httpClient;
    HttpClient *_deleteHttpClient;
    
    CGFloat _curY;
    
    NSNotification *_notification;
    
    
    NSDictionary *_lawTypeDic;

    LogDetailViewController *_logDetailViewController;
    
    RootViewController *_schemaRootViewController;
}



@end

@implementation LogCreateViewController

@synthesize logType = _logType;

@synthesize currentView = _currentView;
@synthesize contentView = _contentView;

@synthesize scrollView = _scrollView;
@synthesize sureView = _sureView;

@synthesize record = _record;

@synthesize editData = _editData;

@synthesize caseView = _caseView;
@synthesize logJobType = _logJobType;
@synthesize caseNameButton = _caseNameButton;
@synthesize caseIdField = _caseIdField;
@synthesize clientIdField = _clientIdField;
@synthesize clientNameField = _clientNameField;
@synthesize logTypeButton = _logTypeButton;
@synthesize jobTimeButton = _jobTimeButton;
@synthesize startButton = _startButton;
@synthesize endButton = _endButton;
@synthesize numLabel = _numLabel;
@synthesize describeTextView = _describeTextView;
@synthesize logID = _logID;

@synthesize clientField = _clientField;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_logType == LogTypeAdd) {
        [self setTitle:@"创建工作日志" color:nil];
        [self setRightButton:[UIImage imageNamed:@"nav_calendar_btn.png"] title:nil target:self action:@selector(touchCalendarEvent)];
    }

}

- (void)touchDeleteEvent{
    _deleteHttpClient = [[HttpClient alloc] init];
    _deleteHttpClient.delegate = self;
    [_deleteHttpClient startRequest:[self deleteParam]];
}

- (NSDictionary*)deleteParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_logID,@"worklogID", nil];
    NSArray *arr = [NSArray arrayWithObjects:fields, nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"worklogdeleteRecord",@"requestKey",arr,@"fields_list", nil];
    return param;
}

- (void)touchCalendarEvent{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    delegate.isShowInSchema=YES;
    

    
    _schemaRootViewController = [[RootViewController alloc] init];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:_schemaRootViewController animated:NO completion:nil];
    [_schemaRootViewController showInSchema];
}

- (IBAction)touchLogJobEvent:(id)sender{
    _logJobViewController.commomCode = @"WLGZ";
    [self.navigationController pushViewController:_logJobViewController animated:YES];
}

- (IBAction)touchCaseEvent:(id)sender{
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController showInCase];
    _rootViewController.caseViewController.delegate = self;
    _rootViewController.caseViewController.caseStatuts = CaseStatutsSelectable;
}

- (IBAction)touchJobTypeEvent:(id)sender{
    _logTypeViewController.commomCode = @"WLCT";
    [self.navigationController pushViewController:_logTypeViewController animated:YES];
}

- (IBAction)touchLawEvent:(id)sender{
    _lawTypeViewController.commomCode = @"WLSW";
    [self.navigationController pushViewController:_lawTypeViewController animated:YES];
}

- (IBAction)touchDateEvent:(id)sender{
    [_describeTextView resignFirstResponder];
    CGRect frame = _jobTimeViewController.view.frame;
    frame.origin.x = 0;
    frame.size.width = self.view.frame.size.width;
    _jobTimeViewController.view.frame = frame;
    [self.view addSubview:_jobTimeViewController.view];
}

- (IBAction)touchTimeEvent:(UIButton*)sender{
    [_describeTextView resignFirstResponder];
    if (sender.tag == 0) {
        CGRect frame = _startPicker.view.frame;
        frame.origin.x = 0;
        frame.size.width = self.view.frame.size.width - frame.origin.x;
        _startPicker.view.frame = frame;

        [self.view addSubview:_startPicker.view];
    }
    else if (sender.tag == 1){
        CGRect frame = _endPicker.view.frame;
        frame.origin.x = 0;
        frame.size.width = self.view.frame.size.width - frame.origin.x;
        _endPicker.view.frame = frame;
        [self.view addSubview:_endPicker.view];
    }
}

- (NSDictionary*)saveparam:(NSString*)logId{
    NSString *time =  _jobTimeField.text;
    NSRange range = [time rangeOfString:@"小时"];
    if (range.location != NSNotFound) {
        time = [time substringToIndex:range.location];
    }
    NSString *worktype = @"";
    if ([[_logTypeDic objectForKey:@"gc_id"] length] > 0) {
        worktype = [_logTypeDic objectForKey:@"gc_id"];
    }
    else if ([[_editData objectForKey:@"wl_work_type"] length] > 0){
        worktype = [_editData objectForKey:@"wl_work_type"];
    }
    if (_logSourece == LogSoureceSchema) {
        worktype = [_record objectForKey:@"sc_work_type"];
    }
    
    NSString *clientId = @"";
    if ([_clientIdField hasText]) {
        clientId = _clientIdField.text;
    }
    
    NSString *clientName = @"";
    if ([_clientNameField hasText]) {
        clientName = _clientNameField.text;
    }
    
    NSString *caseID = @"";
    if ([_caseIdField hasText]) {
        caseID = _caseIdField.text;
    }
    
    NSString *descri = @"";
    if ([_describeTextView hasText]) {
        descri = _describeTextView.text;
    }
    
    NSString *logcategory = @"";
    if (_logJobDic) {
        logcategory = [_logJobDic objectForKey:@"gc_id"];
    }
    
    NSString *startTime = @"00:00";
    
    if (_startButton.titleLabel.text.length != 0) {
        startTime = _startButton.titleLabel.text;
    }
    
    NSString *endTime = @"00:00";
    
    if (_endButton.titleLabel.text.length != 0) {
        endTime = _endButton.titleLabel.text;
    }
    
    NSString *userKey = [[CommomClient sharedInstance] getValueFromUserInfo:@"userKey"];
    if (!_schem_id) {
        _schem_id = @"";
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         clientId,@"cl_client_id",
                         clientName,@"cl_client_name",
                         logId,@"worklogID",
                         caseID,@"wl_case_id",
                         _caseNameButton.titleLabel.text,@"ca_case_name",
                         _jobTimeButton.titleLabel.text,@"wl_start_date",
                         startTime,@"start_time",
                         endTime,@"end_time",
                         worktype,@"wl_work_type",
                         time,@"wl_own_hours",
                         descri,@"wl_description",
                         userKey,@"wl_empl_id",
                         logcategory,@"wl_category",
                         _schem_id,@"wl_schedule_id",
                         nil];
    NSDictionary *dictField = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"workLogregister", @"requestKey",
                               dic, @"fields", nil];
    return dictField;
}

- (NSDictionary*)lawparam:(NSString*)logId{
    NSString *time =  _jobTimeField.text;
    NSRange range = [time rangeOfString:@"小时"];
    if (range.location != NSNotFound) {
        time = [time substringToIndex:range.location];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"000000",@"cl_client_id",
                         @"",@"cl_client_name",
                         logId,@"worklogID",
                         [_lawTypeDic objectForKey:@"gc_id"],@"wl_case_id",
                         [_lawTypeDic objectForKey:@"gc_name"],@"ca_case_name",
                         _jobTimeButton.titleLabel.text,@"wl_start_date",
                         _startButton.titleLabel.text,@"start_time",
                         _endButton.titleLabel.text,@"end_time",
                         [_logJobDic objectForKey:@"gc_id"],@"wl_work_type",
                         time,@"wl_own_hours",
                         _describeTextView.text,@"wl_description",
                         [[CommomClient sharedInstance] getValueFromUserInfo:@"userKey"],@"wl_empl_id",
                         [_logJobDic objectForKey:@"gc_id"],@"wl_category",
                         _schem_id,@"wl_schedule_id",
                         nil];
    NSDictionary *dictField = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"workLogregister", @"requestKey",
                               dic, @"fields", nil];
    return dictField;
}

- (NSDictionary*)clientparam:(NSString*)logId{
    NSString *time =  _jobTimeField.text;
    NSRange range = [time rangeOfString:@"小时"];
    if (range.location != NSNotFound) {
        time = [time substringToIndex:range.location];
    }
    
    NSString *type = @"";
    if (_logTypeDic) {
        type = [_logTypeDic objectForKey:@"gc_id"];
    }
    else{
        type = [_record objectForKey:@"sc_work_type"];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"",@"cl_client_id",
                         _clientField.text,@"cl_client_name",
                         logId,@"worklogID",
                         @"",@"wl_case_id",
                         @"",@"ca_case_name",
                         _jobTimeButton.titleLabel.text,@"wl_start_date",
                         _startButton.titleLabel.text,@"start_time",
                         _endButton.titleLabel.text,@"end_time",
                         type,@"wl_work_type",
                         time,@"wl_own_hours",
                         _describeTextView.text,@"wl_description",
                         [[CommomClient sharedInstance] getValueFromUserInfo:@"userKey"],@"wl_empl_id",
                         [_logJobDic objectForKey:@"gc_id"],@"wl_category",
                         _schem_id,@"wl_schedule_id",
                         nil];
    NSDictionary *dictField = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"workLogregister", @"requestKey",
                               dic, @"fields", nil];
    return dictField;
}

- (IBAction)touchSureEvent:(id)sender{
    
//    
    
//
    
    
    if (!_logTypeDic && [_logTypeButton.titleLabel.text isEqualToString:@"请选择日志类型"]) {
        [self showHUDWithTextOnly:@"请选择日志类型"];
        return;
    }
    
    
    if (![_describeTextView hasText]) {
        [self showHUDWithTextOnly:@"请填写日志描述"];
        return;
    }
    
    if (_startButton.titleLabel.text == 0 || _endButton.titleLabel.text == 0) {
        [self showHUDWithTextOnly:@"请选择工作时间"];
        return;
    }
    
    if (_jobTimeButton.titleLabel.text == 0) {
        [self showHUDWithTextOnly:@"请选择工作日期"];
        return;
    }
    
    if (_logType == LogTypeAdd) {
        
        
        if ([[_logJobDic objectForKey:@"gc_name"] isEqualToString:@"业务工作日志"]) {
            if ([_caseNameButton.titleLabel.text isEqualToString:@"请选择案件"] || _caseNameButton.titleLabel.text.length == 0) {
                [self showHUDWithTextOnly:@"请选择案件"];
                return;
            }
            
            [_httpClient startRequest:[self saveparam:@""]];
        }
        else if ([[_logJobDic objectForKey:@"gc_name"] isEqualToString:@"所务工作日志"]) {
            if ([_lawButton.titleLabel.text isEqualToString:@"请选择所务类别"] || _lawButton.titleLabel.text.length == 0) {
                [self showHUDWithTextOnly:@"请选择所务类别"];
                return;
            }
            [_httpClient startRequest:[self lawparam:@""]];
        }
        else if ([[_logJobDic objectForKey:@"gc_name"] isEqualToString:@"客户开发"]) {
            [_httpClient startRequest:[self clientparam:@""]];
        }
    }
    else if (_logType == LogTypeEdit){
        

        
        if ([[_logJobDic objectForKey:@"gc_name"] isEqualToString:@"业务工作日志"]) {
            if ([_caseNameButton.titleLabel.text isEqualToString:@"请选择案件"] || _caseNameButton.titleLabel.text.length == 0) {
                [self showHUDWithTextOnly:@"请选择案件"];
                return;
            }
            [_httpClient startRequest:[self saveparam:_logID]];
        }
        else if ([[_logJobDic objectForKey:@"gc_name"] isEqualToString:@"所务工作日志"]) {
            if ([_lawButton.titleLabel.text isEqualToString:@"请选择所务类别"] || _lawButton.titleLabel.text.length == 0) {
                [self showHUDWithTextOnly:@"请选择所务类别"];
                return;
            }
            [_httpClient startRequest:[self lawparam:_logID]];
        }
        else if ([[_logJobDic objectForKey:@"gc_name"] isEqualToString:@"客户开发"]) {
            [_httpClient startRequest:[self clientparam:_logID]];
        }
    }
}

- (void)receivesSchema:(NSNotification*)notification{
    NSDictionary *record = (NSDictionary*)[notification object];
    if (record > 0) {
        [_schemaRootViewController dismissViewControllerAnimated:YES completion:nil];
        [_caseNameButton setTitle:[record objectForKey:@"sc_case_name"] forState:UIControlStateNormal];
        _caseIdField.text = [record objectForKey:@"sc_case_id"];
        _clientNameField.text = [record objectForKey:@"sc_client_name"];
        _clientIdField.text = [record objectForKey:@"sc_client_id"];
        [_logTypeButton setTitle:[record objectForKey:@"sc_work_typeName"] forState:UIControlStateNormal];
        [_jobTimeButton setTitle:[self.view getPerTime:[record objectForKey:@"sc_start_date"]] forState:UIControlStateNormal];
        [_startButton setTitle:[self.view getLastTime:[record objectForKey:@"sc_start_date"]] forState:UIControlStateNormal];
        [_endButton setTitle:[self.view getLastTime:[record objectForKey:@"sc_end_date"]] forState:UIControlStateNormal];
        _jobTimeField.text = [record objectForKey:@"sc_attation_days"];
        _describeTextView.text = [record objectForKey:@"sc_description"];
        [_caseNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

/*
 {
 "sc_address" = "";
 "sc_attation_days" = 5;
 "sc_attation_days_name" = "5\U5206\U949f";
 "sc_case_id" = FG2015BJ006;
 "sc_case_name" = "ghj\U6848\U4ef6";
 "sc_client_id" = 0236;
 "sc_client_name" = "\U4e0a\U6d77\U623f\U5730\U4ea7\U4e2d\U4ecb";
 "sc_description" = "\U4f55\U5fc5\U6177\U6168\U89e3\U56ca\U5427";
 "sc_end_date" = "2015-03-22 11:37";
 "sc_isConvert" = 0;
 "sc_is_private" = 1;
 "sc_schedule_id" = SC0001334;
 "sc_start_date" = "2015-03-22 11:37";
 "sc_title" = "\U54c8\U54c8\U80fd\U4e0d\U80fd\U5462";
 "sc_work_type" = 01;
 "sc_work_typeName" = "\U5ba2\U6237\U4ea4\U6d41";
 }
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesSchema:) name:@"schemToLog" object:nil];
    
    if (_logType == LogTypeEdit){
        [self setTitle:@"编辑工作日志" color:nil];
        
        [self setRightButton:[UIImage imageNamed:@"delete_btn.png"] title:nil target:self action:@selector(touchDeleteEvent)];
        if (_record) {
            [_caseNameButton setTitle:[_record objectForKey:@"sc_case_name"] forState:UIControlStateNormal];
            _caseIdField.text = [_record objectForKey:@"sc_case_id"];
            _clientNameField.text = [_record objectForKey:@"sc_client_name"];
            _clientIdField.text = [_record objectForKey:@"sc_client_id"];
            
            _schem_id = [_record objectForKey:@"sc_schedule_id"];
            
            [_logTypeButton setTitle:[_record objectForKey:@"sc_work_typeName"] forState:UIControlStateNormal];
            [_logTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            [_describeTextView setText:[_record objectForKey:@"sc_description"]];
            [_logJobType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_caseNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_jobTimeButton setTitle:[self.view getPerTime:[_record objectForKey:@"sc_start_date"]] forState:UIControlStateNormal];
            if (_logSourece == LogSoureceSchema) {
                [self setRightButton:nil title:nil target:self action:nil];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                
                NSString *startString = [_record objectForKey:@"sc_start_date"];
                NSString *endString = [_record objectForKey:@"sc_end_date"];
                
                startString = [self.view getPerTime:startString];
                endString = [self.view getPerTime:endString];
                
                [formatter setDateFormat:@"yyyy-MM-dd"];
                
                NSDate *startDate = [formatter dateFromString:startString];
                NSDate *endData = [formatter dateFromString:endString];
                
             
                
                
                if ([startDate isEqualToDate:endData]) {
                    [_startButton setTitle:[self.view getLastTime:[_record objectForKey:@"sc_start_date"]] forState:UIControlStateNormal];
                    [_endButton setTitle:[self.view getLastTime:[_record objectForKey:@"sc_end_date"]] forState:UIControlStateNormal];
                    
                    _startTime = [self.view getLastTime:[_record objectForKey:@"sc_start_date"]];
                    _endTime = [self.view getLastTime:[_record objectForKey:@"sc_end_date"]];
                    
                    _jobTimeField.text =  [self intervalFromLastDate:[self.view getLastTime:[_record objectForKey:@"sc_start_date"]] toTheDate:[self.view getLastTime:[_record objectForKey:@"sc_end_date"]]];
                }
                else{
                    [_startButton setTitle:[self.view getLastTime:[_record objectForKey:@"sc_start_date"]] forState:UIControlStateNormal];
                    _startTime = [self.view getLastTime:[_record objectForKey:@"sc_start_date"]];
                }
            }
            else{
                
            }

            
        }
        else{
            [_caseNameButton setTitle:[_editData objectForKey:@"ca_case_name"] forState:UIControlStateNormal];
            _caseIdField.text = [_editData objectForKey:@"wl_case_id"];
            _clientNameField.text = [_editData objectForKey:@"cl_client_name"];
            _clientIdField.text = [_editData objectForKey:@"cl_client_id"];
            [_logTypeButton setTitle:[_editData objectForKey:@"wl_workType_name"] forState:UIControlStateNormal];
            [_jobTimeButton setTitle:[_editData objectForKey:@"wl_start_date"] forState:UIControlStateNormal];
            _jobTimeField.text = [_editData objectForKey:@"wl_own_hours"];
            
            NSString *startTime = [_editData objectForKey:@"start_time"];
            NSRange startRange = [startTime rangeOfString:@":00" options:NSBackwardsSearch];
            startTime = [startTime substringToIndex:startRange.location];
            
            _startTime = startTime;
            
            [_startButton setTitle:startTime forState:UIControlStateNormal];
            
            NSString *endTime = [_editData objectForKey:@"end_time"];
            NSRange endRange = [endTime rangeOfString:@":00" options:NSBackwardsSearch];
            endTime = [endTime substringToIndex:endRange.location];
            
            _endTime = endTime;
            
            [_endButton setTitle:endTime forState:UIControlStateNormal];
            [_describeTextView setText:[_editData objectForKey:@"wl_description"]];
        }
        
        
    }
    
    _rootViewController = [[RootViewController alloc] init];
    _describeTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _describeTextView.layer.borderWidth = 0.5f;
    
    _logJobViewController = [[GeneralViewController alloc] init];
    _logJobViewController.delegate = self;
    
    _lawTypeViewController = [[GeneralViewController alloc] init];
    _lawTypeViewController.delegate = self;
    
    _logTypeViewController = [[GeneralViewController alloc] init];
    _logTypeViewController.delegate = self;
    
    _jobTimeViewController = [[DateViewController alloc] init];
    _jobTimeViewController.delegate = self;
    _jobTimeViewController.dateformatter = @"yyyy-MM-dd";
    
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.dateformatter = @"HH:mm";
    _startPicker.datePicker.datePickerMode = UIDatePickerModeTime;
    
    _endPicker = [[DateViewController alloc] init];
    _endPicker.delegate = self;
    _endPicker.dateformatter = @"HH:mm";
    _endPicker.datePicker.datePickerMode = UIDatePickerModeTime;
    
  
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _logJobDic = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"gc_id",@"业务工作日志",@"gc_name", nil];
    [self switchView:_caseView];
    
    [_logJobType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    if (generalViewController == _logJobViewController) {
        _logJobDic = data;
        [_logJobType setTitle:[_logJobDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_logJobType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if ([[_logJobDic objectForKey:@"gc_name"] isEqualToString:@"业务工作日志"]) {
            [self switchView:_caseView];
        }
        else if ([[_logJobDic objectForKey:@"gc_name"] isEqualToString:@"所务工作日志"]) {
            [self switchView:_lawView];
        }
        else if ([[_logJobDic objectForKey:@"gc_name"] isEqualToString:@"客户开发"]) {
            [self switchView:_clientView];
        }
        
    }
    else if (generalViewController == _logTypeViewController){
        _logTypeDic = data;
        [_logTypeButton setTitle:[_logTypeDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_logTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _lawTypeViewController){
        _lawTypeDic = data;
        [_lawButton setTitle:[_lawTypeDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_lawButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
}

- (void)switchView:(UIView*)contentView{
    for (UIView *view in _currentView.subviews) {
        [view removeFromSuperview];
    }
    CGRect frame = contentView.frame;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    contentView.frame = frame;
    
    [_currentView addSubview:contentView];
    
    for (NSLayoutConstraint *layout in _currentView.constraints) {
        layout.constant = contentView.frame.size.height;
    }

}

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    if (request == _httpClient) {
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            
            
            
            if (_logSourece == LogSoureceSchema) {
                [self showHUDWithTextOnly:@"转化成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"logrefresh" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"log_create" object:nil];
                [self showHUDWithTextOnly:@"保存成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            
            //        _alertView = [[AlertView alloc] initWithFrame:CGRectMake(15, 120, self.view.frame.size.width-30, 125)];
            //        [self.view addSubview:_alertView];
            //        _alertView.delegate = self;
            //        [_alertView setAlertButtonType:AlertButtonTwo];
            //        [_alertView.tipLabel setText:@"是否查看或继续添加"];
            //        [_alertView.sureButton setTitle:@"查看" forState:UIControlStateNormal];
            //        [self.view bringSubviewToFront:_alertView];
        }
        else{
            [self showHUDWithTextOnly:@"保存失败"];
        }
    }
    else if (request == _deleteHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"删除成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"删除失败"];
        }
    }
    
    
}

- (void)alertView:(AlertView*)AlertView field:(NSString*)text{
    if (AlertView == _alertView) {
        _logDetailViewController = [[LogDetailViewController alloc] init];
    }
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}


- (void)returnDataToProcess:(NSDictionary*)item{
    [_caseNameButton setTitle:[item objectForKey:@"ca_case_name"] forState:UIControlStateNormal];
    [_caseNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _caseIdField.text = [item objectForKey:@"ca_case_id"];
    _clientNameField.text = [item objectForKey:@"cl_client_name"];
    _clientIdField.text = [item objectForKey:@"cl_client_id"];
}

- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    if (dateViewController == _jobTimeViewController) {
        [_jobTimeButton setTitle:date forState:UIControlStateNormal];
        [_jobTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (dateViewController == _startPicker) {
        _startTime = date;
        [_startButton setTitle:date forState:UIControlStateNormal];
    }
    else if (dateViewController == _endPicker){
        _endTime = date;
        [_endButton setTitle:date forState:UIControlStateNormal];
    }
    
    if (_startTime.length > 0 && _endTime.length > 0) {
        if ([self isSelectDate:_startTime str2:_endTime]) {
            _jobTimeField.text = [self intervalFromLastDate:_startTime toTheDate:_endTime];
        }
    }
}

- (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"HH:mm"];
    
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    
    
    NSTimeInterval cha=late2-late1;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    sen = [NSString stringWithFormat:@"%02d", (int)cha%60];
    //        min = [min substringToIndex:min.length-7];
    //    秒
    sen=[NSString stringWithFormat:@"%@", sen];
    
    
    
    min = [NSString stringWithFormat:@"%02d", (int)cha/60%60];
    //        min = [min substringToIndex:min.length-7];
    //    分
    min=[NSString stringWithFormat:@"%@", min];
    
    
    //    小时
    house = [NSString stringWithFormat:@"%.2f", cha/3600.0];
    //        house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];
    
    
    timeString=[NSString stringWithFormat:@"%@",house];
    
    
    return timeString;
}


- (BOOL)isSelectDate:(NSString*)str1 str2:(NSString*)str2{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSDate *date1 = [dateFormatter dateFromString:str1];
    NSDate *date2 = [dateFormatter dateFromString:str2];
    if ([date2 laterDate:date1]) {
        return YES;
    }
    return NO;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _curY = 0;
    [textField resignFirstResponder];
    
    [self keyBoardHide];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _curY = 0;
    
    [self keyboarShow:_notification];
    
    return YES;
}


-(void)keyboarShow:(NSNotification *) notif
{
    
    
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    _notification = notif;
//    CGRect frame = _contentView.frame;
//    
//    frame.origin.y = 0;
//    
//    
//    _contentView.frame = frame;
    
    
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _sureView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = keyboardSize.height;
        }
        
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    CGRect frame = _contentView.frame;
//    
//    frame.origin.y = 0;
//    
//    
//    _contentView.frame = frame;
    
   // [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1000)];
}

-(void)keyBoardHide
{
    //_contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _sureView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = 5;
        }
        
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //[_scrollView scrollRectToVisible:CGRectMake(0, _describeTextView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self keyBoardHide];
//       [_scrollView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
        return NO;
    }
        return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView{
    NSInteger max = 500;
    if (textView.text.length >= max)
    {
        textView.text = [textView.text substringToIndex:max];
    }
    NSInteger number = [textView.text length];
    _numLabel.text = [NSString stringWithFormat:@"您还可以输入%ld个字",max-number];
    
}


@end
