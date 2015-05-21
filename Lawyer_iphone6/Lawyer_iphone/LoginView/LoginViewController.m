//
//  LoginViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-5.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "LoginViewController.h"

#import "CommomClient.h"

#import "HttpClient.h"

#import "RootViewController.h"

@interface LoginViewController ()<RequestManagerDelegate,UITextFieldDelegate>{
    NSString *_username;
    NSString *_password;
    NSString *userSMSID;
    
    BOOL isRemember;
    HttpClient *_authHttpClient;
    HttpClient *_loginHttpClient;
    
    RootViewController *_rootViewController;
    
    BOOL isNeedAuth;
    
    NSTimer *_timer;
    NSInteger time;
    
    NSInteger _count;
}

@end

@implementation LoginViewController

@synthesize contentView = _contentView;

@synthesize userNameField = _userNameField;
@synthesize passwordField = _passwordField;
@synthesize loginView = _loginView;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _rootViewController = [RootViewController sharedInstance];
    _rootViewController.isChangeStatusBar = YES;
    
    BOOL rem = [[[NSUserDefaults standardUserDefaults] valueForKey:@"rem"] boolValue];
    
    if (rem) {
        //_username = [[CommomClient sharedInstance] getAccount];
        isRemember = YES;
        _rememberButton.selected = YES;
        _passwordField.text = @"";

    }
    else{
        [[CommomClient sharedInstance] removeAccount];
        isRemember = NO;
        _rememberButton.selected = NO;
        _userNameField.text = @"";
        _passwordField.text = @"";
    }
    [self isAuth:NO];
    
    _count = 0;
   
}



- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"rem"];
    
    _loginHttpClient = [[HttpClient alloc] init];
    _loginHttpClient.delegate = self;

    

    
    
    
    _authHttpClient = [[HttpClient alloc] init];
    _authHttpClient.delegate = self;
    _authHttpClient.isChange = YES;
}


- (NSDictionary*)loginParams:(NSString*)SMSID SMSCode:(NSString*)SMSCode {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _username,@"userID",
                         _password,@"password",
                         @"",@"imei",
                         @"",@"imsi",
                         SMSID,@"userSMSID",
                         SMSCode,@"userSMSCode",
                         nil];
    NSDictionary *fieldsDic = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"login",@"requestKey",
                               dic,@"fields",
                               nil];
    
    
    return fieldsDic;
}


- (IBAction)touchRememberEvent:(UIButton*)sender{
    if (sender.selected) {
        isRemember = NO;
        sender.selected = NO;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"rem"];
    }
    else{
        sender.selected = YES;
        isRemember = YES;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"rem"];
    }
}

- (IBAction)touchLoginEvent:(id)sender{

    
    _username = _userNameField.text;
    _password = _passwordField.text;

// 如果用户名改变，清理缓存
    if (![[[CommomClient sharedInstance] getAccount] isEqualToString:_userNameField.text])
    {
        [[CommomClient sharedInstance] removeAccount];
    }
    
    if (_username.length == 0) {
        [self showHUDWithTextOnly:@"请输入用户名"];
        return;
    }
    
    if (_password.length == 0) {
        [self showHUDWithTextOnly:@"请输入密码"];
        return;
    }
    if (isNeedAuth) {
        [_loginHttpClient startRequest:[self loginParams:userSMSID SMSCode:_authField.text]];
    }
    else{
        
        [_loginHttpClient startRequest:[self loginParams:@"" SMSCode:@""]];
    }
    
    
}

#pragma mark -- RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    
    NSString *mgid = [result objectForKey:@"mgid"];
    NSString *massage = [result objectForKey:@"msg"];
    
    
    if (request== _loginHttpClient) {
        if ([mgid isEqualToString:@"true"]) {
            [[CommomClient sharedInstance] saveAccount:_username];
            [[CommomClient sharedInstance] saveUserInfo:[result objectForKey:@"record"]];
            
            NSString *userUrl = [[result objectForKey:@"record"] objectForKey:@"userUrl"];
//            if (![userUrl containsString:@"http://www.elinklaw.com"] && _count == 0) {
            
            if ([userUrl rangeOfString:@"http://www.elinklaw.com"].location == NSNotFound && _count == 0) {
                
                [self touchLoginEvent:nil];
                _count++;
                
                
            }
            else{
                if (_count < 2) {
                    
                    
                    [self presentViewController:_rootViewController animated:YES completion:nil];
                    [_rootViewController showInHome];
                }
            }
            
            
            
            
            
        }
        else{
            if ([massage isEqualToString:@"need to sms authentication"]) {
                [self showHUDWithTextOnly:@"需要短信验证"];
                isNeedAuth = YES;
                [self isAuth:YES];
            }
            else{
                [self showHUDWithTextOnly:@"登录出错"];
            }
        }
    }
    else if (request == _authHttpClient){
        userSMSID = massage;
    }

    
// 获取短信验证返回数据判断
    if (request== _authHttpClient) {
        if ([mgid isEqualToString:@"true"])
        {
            [self showHUDWithTextOnly:[NSString stringWithFormat:@"验证码发送成功，验证序号：%@",massage]];
            time = 60;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calculate) userInfo:nil repeats:YES];
        }
        else
        {
            [self showHUDWithTextOnly:massage];
        }
    }
}

- (IBAction)touchAuthEvent:(id)sender{
    
    [_authHttpClient startRequest:[self authParam]];
    
//    time = 60;
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calculate) userInfo:nil repeats:YES];

}

- (NSDictionary*)authParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_username,@"userID",_password,@"password",@"ios",@"device_system", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"sendsmsverification",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)calculate{
    time -= 1;
    if (time == 0) {
        [_timer invalidate];
        [_authButton setTitle:@"获取" forState:UIControlStateNormal];
        _authButton.enabled = YES;
    }
    else{
        _authButton.enabled = YES;
        NSString *title = [NSString stringWithFormat:@"%ld",(long)time];
        [_authButton setTitle:title forState:UIControlStateNormal];
        _authButton.enabled = NO;
    }
}


- (void)isAuth:(BOOL)isAuth{
    if (isAuth) {
        _marginTop.constant = 50;
        _authView.hidden = NO;
    }
    else{
        _marginTop.constant = 0;
        _authView.hidden = YES;
    }
}


- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
    [self showHUDWithTextOnly:@"登录失败"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _passwordField) {
        if (isNeedAuth) {
            [_authField becomeFirstResponder];
        }
        else{
            [self touchLoginEvent:nil];
        }
        
    }
    else if (textField == _authField){
        [self touchLoginEvent:nil];
    }
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
