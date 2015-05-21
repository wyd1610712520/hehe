//
//  PasswordViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-23.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "PasswordViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"

@interface PasswordViewController ()<RequestManagerDelegate,UITextFieldDelegate>{
    HttpClient *_httpClient;
    
    CommomClient *_commomClient;
}


@end

@implementation PasswordViewController

@synthesize oldWordField = _oldWordField;
@synthesize wordField = _wordField;
@synthesize sureNewField = _sureNewField;

@synthesize sureButton = _sureButton;
@synthesize tintLabel = _tintLabel;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:[Utility localizedStringWithTitle:@"password_nav_title"] color:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    
    self.isSet = YES;
    
    _commomClient = [CommomClient sharedInstance];

    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
}

- (NSDictionary*)param{
    NSDictionary *fileds = [NSDictionary dictionaryWithObjectsAndKeys:[_commomClient getValueFromUserInfo:@"userKey"],@"us_user_key",_oldWordField.text,@"us_old_password",_wordField.text,@"us_password",[[CommomClient sharedInstance] getAccount],@"userID",[_commomClient getValueFromUserInfo:@"_loginSubMapping"],@"user_officeID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"userpasswordmodify",@"requestKey",fileds,@"fields", nil];
    return param;
}

- (IBAction)touchSureEvent:(id)sender{
    if (![_wordField.text isEqualToString:_sureNewField.text]) {
        [self showProgressHUD:@"密码输入不一致"];
        return;
    }
    
    [_httpClient startRequest:[self param]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
        [self showHUDWithTextOnly:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self showHUDWithTextOnly:@"修改失败"];
    }
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}



@end
