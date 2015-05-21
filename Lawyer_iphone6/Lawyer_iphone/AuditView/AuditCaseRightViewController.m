//
//  AuditCaseRightViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "AuditCaseRightViewController.h"

#import "RevealViewController.h"
#import "AuditCaseViewController.h"

#import "GeneralViewController.h"

#import "DateViewController.h"

@interface AuditCaseRightViewController ()<UITextFieldDelegate,GeneralViewControllerDelegate,DateViewControllerDelegate>{
    AuditCaseViewController *_auditCaseViewController;
    
    GeneralViewController *_caseTypeViewController;
    GeneralViewController *_hostViewController;
    
    NSDictionary *_caseTypeDic;
    NSDictionary *_hostDic;
    
    DateViewController *_startPicker;
    DateViewController *_endPicker;
}

@end

@implementation AuditCaseRightViewController

@synthesize contentView = _contentView;
@synthesize  scrollView = _scrollView;
@synthesize caseRightView = _caseRightView;

- (void)setAuditCaseView:(AuditCaseViewController*)auditCaseViewController{
    _auditCaseViewController = auditCaseViewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    _auditCaseViewController.navigationController.view.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    _auditCaseViewController.navigationController.view.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    _auditCaseViewController.navigationController.view.hidden = NO;
    
    CGRect frame = _contentView.frame;
    frame.origin.x = vectorx+20;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height * 0.04;
    frame.size.height = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
    _contentView.frame = frame;
    [self.view addSubview:_contentView];
    _scrollView.frame = _contentView.frame;
    _scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
    
    CGRect _caseframe = _caseRightView.frame;
    _caseframe.size.width = _scrollView.frame.size.width;
    _caseRightView.frame = _caseframe;
    [_scrollView addSubview:_caseRightView];
    
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

- (IBAction)touchCategoryEvent:(UIButton*)sender{
    [self hideKeyboard];
    _caseTypeViewController.commomCode = @"CACT";
    [self.navigationController pushViewController:_caseTypeViewController animated:YES];

}

- (IBAction)touchChargeEvent:(UIButton*)sender{
    [self hideKeyboard];
    _hostViewController.commomCode = @"SYSEMPL";
    [self.navigationController pushViewController:_hostViewController animated:YES];

}

- (IBAction)toucHTimeEvent:(UIButton*)sender{
    [self hideKeyboard];
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

- (IBAction)touchClearEvent:(id)sender{
    _caseNameField.text = @"";
    _caseIdField.text = @"";
    _clientNameField.text = @"";
    [_categoryButton setTitle:@"请选择案件类别" forState:UIControlStateNormal];
    [_chargeButton setTitle:@"请选择案件负责人" forState:UIControlStateNormal];
    [_categoryButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [_chargeButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [_startTimeButton setTitle:@"" forState:UIControlStateNormal];
    [_endTimeButton setTitle:@"" forState:UIControlStateNormal];
    
    _caseTypeDic = nil;
    _hostDic = nil;
    
    _startTimeButton.titleLabel.text = @"";
    _endTimeButton.titleLabel.text = @"";

}

- (IBAction)touchSureEvent:(id)sender{
    if ([_delegate respondsToSelector:@selector(returnData:caseId:clientName:caseCategory:caseCharge:startTime:endTime:)]) {
        [_delegate returnData:_caseNameField.text caseId:_caseIdField.text clientName:_clientNameField.text caseCategory:[_caseTypeDic objectForKey:@"gc_id"] caseCharge:[_hostDic objectForKey:@"gc_id"] startTime:_startTimeButton.titleLabel.text endTime:_endTimeButton.titleLabel.text];
        [self.revealContainer clickBlackLayer];
        
        NSString *category = @"";
        if (_caseTypeDic.count > 0) {
            category = _categoryButton.titleLabel.text;
        }
        
        NSString *charge = @"";
        if (_hostDic.count > 0) {
            charge = _chargeButton.titleLabel.text;
        }
        
        [_delegate returnRedData:_caseNameField.text caseId:_caseIdField.text clientName:_clientNameField.text category:category charge:charge];
    }
}

- (void)hideKeyboard{
    [_caseIdField resignFirstResponder];
    [_caseNameField resignFirstResponder];
    [_clientNameField resignFirstResponder];
}

- (IBAction)touchCloseEvent:(id)sender{
    [_caseIdField resignFirstResponder];
    [_caseNameField resignFirstResponder];
    [_clientNameField resignFirstResponder];

    [self.revealContainer clickBlackLayer];
}


- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    if (dateViewController == _startPicker) {
        [_startTimeButton setTitle:date forState:UIControlStateNormal];
        [_startTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (dateViewController == _endPicker){
        [_endTimeButton setTitle:date forState:UIControlStateNormal];
        [_endTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    if (generalViewController == _hostViewController) {
        _hostDic = data;
        [_chargeButton setTitle:[_hostDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_chargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _caseTypeViewController){
        _caseTypeDic = data;
        [_categoryButton setTitle:[_caseTypeDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_categoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

@end
