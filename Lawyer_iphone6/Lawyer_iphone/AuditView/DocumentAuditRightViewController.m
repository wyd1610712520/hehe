//
//  DocumentAuditRightViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "DocumentAuditRightViewController.h"
#import "RevealViewController.h"

#import "GeneralViewController.h"

#import "DateViewController.h"
#import "DocumentAuditViewController.h"

@interface DocumentAuditRightViewController ()<GeneralViewControllerDelegate,DateViewControllerDelegate,UITextFieldDelegate>{
    DocumentAuditViewController *_documentAuditViewController;
    
    GeneralViewController *_generalViewController;
    
    DateViewController *_startPicker;
    DateViewController *_endPicker;
    
    NSDictionary *_personDic;
}

@end

@implementation DocumentAuditRightViewController

- (void)setDocumentAuditView:(DocumentAuditViewController*)documentAuditViewController{
    _documentAuditViewController = documentAuditViewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    _documentAuditViewController.navigationController.view.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    _documentAuditViewController.navigationController.view.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    _documentAuditViewController.navigationController.view.hidden = NO;
    
    CGRect frame = _contentView.frame;
    frame.origin.x = vectorx+20;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height * 0.04;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
    frame.size.height = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    _contentView.frame = frame;
    
    [self.view addSubview:_contentView];
    
    _generalViewController = [[GeneralViewController alloc] init];
    _generalViewController.delegate = self;
    
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.dateformatter = @"yyyy-MM-dd";
    
    
    
    _endPicker = [[DateViewController alloc] init];
    _endPicker.delegate = self;
    _endPicker.dateformatter = @"yyyy-MM-dd";
}

- (IBAction)touchCloseEvent:(id)sender{
    [self.revealContainer clickBlackLayer];
}

- (IBAction)touchPersonEvent:(id)sender{
    [self hideKeyboard];
    _generalViewController.commomCode = @"SYSEMPL";
    [self.navigationController pushViewController:_generalViewController animated:YES];

}

- (IBAction)touchStartEvent:(id)sender{
    [self hideKeyboard];
    CGRect frame = _startPicker.view.frame;
    frame.origin.x = vectorx;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
    _startPicker.view.frame = frame;
    
    
    [self.view addSubview:_startPicker.view];
    

}

- (IBAction)touchEndEvent:(id)sender{
    [self hideKeyboard];
    CGRect frame = _endPicker.view.frame;
    frame.origin.x = vectorx;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
    _endPicker.view.frame = frame;
    [self.view addSubview:_endPicker.view];
}


- (IBAction)touchCleartEvent:(id)sender{
    _fileNameField.text = @"";
    _caseIdField.text = @"";
    _caseNameField.text = @"";
    
    [_startButton setTitle:@"" forState:UIControlStateNormal];
    [_endButton setTitle:@"" forState:UIControlStateNormal];
    [_personButton setTitle:@"请选择申请人" forState:UIControlStateNormal];
    [_personButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    _personDic = nil;
    
    _startButton.titleLabel.text = @"";
    _endButton.titleLabel.text = @"";

}

- (IBAction)touchSureEvent:(id)sender{
    if ([_delegate respondsToSelector:@selector(returnLogDocuData:caseId:caseName:startTime:endTime:lawyer:)]) {
        [_delegate returnLogDocuData:_fileNameField.text caseId:_caseIdField.text caseName:_caseNameField.text startTime:_startButton.titleLabel.text endTime:_endButton.titleLabel.text lawyer:[_personDic objectForKey:@"gc_id"]];
        [self.revealContainer clickBlackLayer];
    }
}

- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    if (dateViewController == _startPicker) {
        [_startButton setTitle:date forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (dateViewController == _endPicker){
        [_endButton setTitle:date forState:UIControlStateNormal];
        [_endButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    if (generalViewController == _generalViewController) {
        _personDic = data;
        [_personButton setTitle:[_personDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_personButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

- (void)hideKeyboard{
    [_caseNameField resignFirstResponder];
    [_caseIdField resignFirstResponder];
    [_fileNameField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
