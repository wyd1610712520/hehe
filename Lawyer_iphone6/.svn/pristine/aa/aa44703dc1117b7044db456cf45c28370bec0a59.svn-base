//
//  LogRightViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-5.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LogRightViewController.h"

#import "RootViewController.h"

#import "CommomClient.h"

#import "GeneralViewController.h"

#import "DateViewController.h"

@interface LogRightViewController ()<GeneralViewControllerDelegate,DateViewControllerDelegate,UITextFieldDelegate>{
    LogViewController *_logViewController;
    
    GeneralViewController *_caseTypeViewController;
    GeneralViewController *_hostViewController;
    
//    NSDictionary *_caseTypeDic;
//    NSDictionary *_hostDic;
    NSMutableDictionary *_caseTypeDic;
    NSMutableDictionary *_hostDic;
    
    DateViewController *_startPicker;
    DateViewController *_endPicker;
    
    UIButton *_currentButton;
    
    NSString *_status;
}

@end

@implementation LogRightViewController

@synthesize contentView = _contentView;
@synthesize scrollView = _scrollView;
@synthesize secondView = _secondView;

@synthesize delegate = _delegate;

@synthesize categoryButton = _categoryButton;
@synthesize chargeButton = _chargeButton;

@synthesize startTimeButton = _startTimeButton;
@synthesize endTimeButton = _endTimeButton;

@synthesize caseNameField = _caseNameField;
@synthesize caseIdField = _caseIdField;
@synthesize clientNameField = _clientNameField;

- (void)setLogView:(LogViewController*)logViewController{
    _logViewController = logViewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    _logViewController.navigationController.view.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    _logViewController.navigationController.view.hidden = YES;
}

- (IBAction)touchCloseEvent:(id)sender{
//    if ([_delegate respondsToSelector:@selector(logRightViewController:param:)]) {
//        [_delegate logRightViewController:self param:nil];
//        [self.revealContainer clickBlackLayer];
//    }
    
    if ([_delegate respondsToSelector:@selector(returnLogData:caseID:clientName:caseCategory:caseCharge:startTime:endTime:status:)]) {
        [_delegate returnLogData:@"" caseID:@"" clientName:@"" caseCategory:@"" caseCharge:@"" startTime:@"" endTime:@"" status:@""];
        [self.revealContainer clickBlackLayer];
    }
    [_caseIdField resignFirstResponder];
    [_caseNameField resignFirstResponder];
    [_clientNameField resignFirstResponder];
    
}

- (IBAction)touchNEvent:(id)sender{
    _status = @"N";
//    if ([_delegate respondsToSelector:@selector(logRightViewController:param:)]) {
//        [_delegate logRightViewController:self param:[self myParam:@"N"]];
//        
//        [self.revealContainer clickBlackLayer];
//    }
    self.green1.hidden = NO;
    self.green2.hidden = YES;
    self.green3.hidden = YES;
    self.img1.hidden = YES;
    self.img2.hidden = NO;
    self.img3.hidden = NO;
    [self loadToLogVCStatus:_status];
}

- (IBAction)touchAEvent:(id)sender{
    _status = @"A";
//    if ([_delegate respondsToSelector:@selector(logRightViewController:param:)]) {
//        [_delegate logRightViewController:self param:[self myParam:@"A"]];
//        [self.revealContainer clickBlackLayer];
//    }
    self.green1.hidden = YES;
    self.green2.hidden = NO;
    self.green3.hidden = YES;
    self.img2.hidden = YES;
    self.img1.hidden = NO;
    self.img3.hidden = NO;
    [self loadToLogVCStatus:_status];
}

- (IBAction)touchRejectEvent:(id)sender{
    _status = @"B";
//    if ([_delegate respondsToSelector:@selector(logRightViewController:param:)]) {
//        [_delegate logRightViewController:self param:[self myParam:@"B"]];
//        [self.revealContainer clickBlackLayer];
//    }

    self.green1.hidden = YES;
    self.green2.hidden = YES;
    self.green3.hidden = NO;
    self.img2.hidden = NO;
    self.img1.hidden = NO;
    self.img3.hidden = YES;
    [self loadToLogVCStatus:_status];
}

- (void)loadToLogVCStatus:(NSString*)status
{
    if ([_delegate respondsToSelector:@selector(returnLogData:caseID:clientName:caseCategory:caseCharge:startTime:endTime:status:)]) {
        [_delegate returnLogData:_caseNameField.text caseID:_caseIdField.text clientName:_clientNameField.text caseCategory:[_caseTypeDic objectForKey:@"gc_id"] caseCharge:[_hostDic objectForKey:@"gc_id"] startTime:_startTimeButton.titleLabel.text endTime:_endTimeButton.titleLabel.text status:_status];
        
        [self.revealContainer clickBlackLayer];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = _contentView.frame;
    frame.origin.x = vectorx + 20;
    frame.origin.y = 20;
    frame.size.height = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
    _contentView.frame = frame;
    [self.view addSubview:_contentView];
    _scrollView.frame = _contentView.frame;
    _secondView.frame = _scrollView.frame;
    _scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
    
    
    _caseTypeViewController = [[GeneralViewController alloc] init];
    _caseTypeViewController.delegate = self;
    
    _hostViewController = [[GeneralViewController alloc] init];
    _hostViewController.delegate = self;
    
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.dateformatter = @"yyyy-MM-dd";
    
    
    _endPicker = [[DateViewController alloc] init];
    _endPicker.delegate = self;
    _endPicker.dateformatter = @"yyyy-MM-dd";
    

}

- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    if (dateViewController == _startPicker) {
        [_startTimeButton setTitle:date forState:UIControlStateNormal];
        
    }
    else if (dateViewController == _endPicker){
        [_endTimeButton setTitle:date forState:UIControlStateNormal];
        
    }
}

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    if (generalViewController == _hostViewController) {
        _hostDic = [NSMutableDictionary dictionaryWithDictionary:data];

        [_chargeButton setTitle:[_hostDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_chargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _caseTypeViewController){
        _caseTypeDic = [NSMutableDictionary dictionaryWithDictionary:data];
        [_categoryButton setTitle:[_caseTypeDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_categoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)toucHTimeEvent:(UIButton*)sender{
    if (sender.tag == 0) {
        CGRect frame = _startPicker.view.frame;
        frame.origin.x = vectorx;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
        _startPicker.view.frame = frame;
        
        
        [self.view addSubview:_startPicker.view];
    }
    else if (sender.tag == 1){
        CGRect frame = _endPicker.view.frame;
        frame.origin.x = vectorx;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
        _endPicker.view.frame = frame;
        [self.view addSubview:_endPicker.view];
    }
}

- (IBAction)touchCategoryEvent:(UIButton*)sender{
    _currentButton = sender;
    _caseTypeViewController.commomCode = @"CACT";
    [self.navigationController pushViewController:_caseTypeViewController animated:YES];
}

- (IBAction)touchChargeEvent:(UIButton*)sender{
    _currentButton = sender;
    _hostViewController.commomCode = @"SYSEMPL";
    [self.navigationController pushViewController:_hostViewController animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//
//- (NSDictionary*)listParam:(NSString*)previewType{
//    NSString *category = @"";
//    NSString *charge = @"";
//    
//    NSString *startTime = @"";
//    NSString *endTime = @"";
//    
//    if (![_categoryButton.titleLabel.text isEqualToString:@"请选择案件类别"]) {
//        
//        
//        if (_categoryButton.titleLabel.text.length > 0) {
//            category = _categoryButton.titleLabel.text;
//        }
//        else{
//            category = @"";
//        }
//    }
//    
//    if (![_chargeButton.titleLabel.text isEqualToString:@"请选择案件负责人"]) {
//        
//        if (_chargeButton.titleLabel.text.length > 0) {
//            charge = _chargeButton.titleLabel.text;
//        }
//        else{
//            charge = @"";
//        }
//    }
//    
//    if (![_startTimeButton.titleLabel.text isEqualToString:@""]) {
//        
//        if (_startTimeButton.titleLabel.text.length > 0) {
//            startTime = _startTimeButton.titleLabel.text;
//        }
//        else{
//            startTime = @"";
//        }
//    }
//    
//    if (![_endTimeButton.titleLabel.text isEqualToString:@""]) {
//        
//        if (_endTimeButton.titleLabel.text.length > 0) {
//            endTime = _endTimeButton.titleLabel.text;
//        }
//        else{
//            endTime = @"";
//        }
//    }
//
//    
//    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"cl_client_id",
//                            _caseIdField.text,@"ca_case_id",
//                            _clientNameField.text,@"cl_client_name",
//                            _caseNameField.text,@"ca_case_name",
//                            charge,@"wl_empl_id",
//                            startTime,@"wl_start_date_b",
//                            endTime,@"wl_start_date_e",
//                            [[CommomClient sharedInstance] getAccount],@"userID",
//                            @"",@"wl_status",
//                            previewType,@"previewType",nil];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"workLoggetList",@"requestKey",
//                           @"1",@"currentPage",
//                           @"500",@"pageSize",
//                           fields,@"fields",nil];
//    return param;
//}

- (IBAction)touchSureEvent:(id)sender{
//    if ([_delegate respondsToSelector:@selector(logRightViewController:param:)]) {
//        [_delegate logRightViewController:self param:[self listParam:@""]];
//        [self.revealContainer clickBlackLayer];
//    }
    
     if ([_delegate respondsToSelector:@selector(returnLogData:caseID:clientName:caseCategory:caseCharge:startTime:endTime:status:)]) {
        [_delegate returnLogData:_caseNameField.text caseID:_caseIdField.text clientName:_clientNameField.text caseCategory:[_caseTypeDic objectForKey:@"gc_id"] caseCharge:[_hostDic objectForKey:@"gc_id"] startTime:_startTimeButton.titleLabel.text endTime:_endTimeButton.titleLabel.text status:_status];
         
        [self.revealContainer clickBlackLayer];
    }
}

- (IBAction)touchClearEvent:(id)sender{
    _caseNameField.text = @"";
    _caseIdField.text = @"";
    _clientNameField.text = @"";
    [_categoryButton setTitle:@"请选择案件类别" forState:UIControlStateNormal];
    [_chargeButton setTitle:@"请选择案件负责人" forState:UIControlStateNormal];
    [_startTimeButton setTitle:@"" forState:UIControlStateNormal];
    [_endTimeButton setTitle:@"" forState:UIControlStateNormal];
    
//    [_delegate logRightViewController:self param:[self myParam:@""]];
    
    _status = @"";

    [_caseTypeDic removeAllObjects];
    [_hostDic removeAllObjects];

    if ([_delegate respondsToSelector:@selector(returnLogData:caseID:clientName:caseCategory:caseCharge:startTime:endTime:status:)]) {
        [_delegate returnLogData:_caseNameField.text caseID:_caseIdField.text clientName:_clientNameField.text caseCategory:[_caseTypeDic objectForKey:@"gc_id"] caseCharge:[_hostDic objectForKey:@"gc_id"] startTime:_startTimeButton.titleLabel.text endTime:_endTimeButton.titleLabel.text status:_status];
    }
    
    self.green1.hidden = YES;
    self.green2.hidden = YES;
    self.green3.hidden = YES;
    self.img1.hidden = NO;
    self.img2.hidden = NO;
    self.img3.hidden = NO;
}

@end
