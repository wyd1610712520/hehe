//
//  ContactDetailViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ContactDetailViewController.h"

#import "HttpClient.h"
#import "CommomClient.h"

#import "ZCAddressBook.h"

@interface ContactDetailViewController ()<RequestManagerDelegate,UIAlertViewDelegate,ABNewPersonViewControllerDelegate>{
    NSString *_user_id;
    
    HttpClient *_httpClient;
    
    NSDictionary *_contactMapping;
    
    NSString *path;
}


@end

@implementation ContactDetailViewController

@synthesize nameLabel = _nameLabel;
@synthesize dutyLabel = _dutyLabel;
@synthesize areaLabel = _areaLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize mobileLabel = _mobileLabel;
@synthesize emailLabel = _emailLabel;

@synthesize detailType = _detailType;



@synthesize contactClientSubMapping = _contactClientSubMapping;
@synthesize departPersonMapping = _departPersonMapping;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:[Utility localizedStringWithTitle:@"contact_detail_nav_title"] color:nil];
    
    if (_contactClientSubMapping) {
        _nameLabel.text = [_contactClientSubMapping objectForKey:@"clr_name"];
        _dutyLabel.text = [_contactClientSubMapping objectForKey:@"clr_duty"];
        _phoneLabel.text = [_contactClientSubMapping objectForKey:@"clr_telephone"];
        _mobileLabel.text = [_contactClientSubMapping objectForKey:@"clr_phone"];
        _emailLabel.text = [_contactClientSubMapping objectForKey:@"clr_email"];
    }
    
    if (_departPersonMapping) {
        _user_id = [_departPersonMapping objectForKey:@"user_id"];
        
//        _httpClient = [[HttpClient alloc] init];
//        _httpClient.delegate = self;
//        [_httpClient startRequest:[self departParam]];
        
        _nameLabel.text = [_departPersonMapping objectForKey:@"user_name"];
        _dutyLabel.text = [_departPersonMapping objectForKey:@"user_dept_name"];
        _phoneLabel.text = [_departPersonMapping objectForKey:@"user_telephone"];
        _emailLabel.text = [_departPersonMapping objectForKey:@"user_email"];
        _areaLabel.text = [_departPersonMapping objectForKey:@"user_office_name"];
        _mobileLabel.text = [_departPersonMapping objectForKey:@"user_phone"];
    }
}

- (NSDictionary*)departParam{
    NSDictionary *fileds = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getAccount],@"userID",_user_id,@"addressUserId", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"addressUserInfoQuery",@"requestKey",fileds,@"fields", nil];
    return param;
}

- (IBAction)touchSaveEvent:(id)sender{
    
   // NSString * addressString1 = @"地址";
    
    
   // NSString * emailString = _emailLabel.text;
    
    NSString * phoneNumber = _mobileLabel.text;
    
    NSString * mobile = _phoneLabel.text;
    
    NSString *email = _emailLabel.text;
    NSString * prefName = _nameLabel.text;
    
    BOOL isSuccess = NO;
    
    isSuccess =[[ZCAddressBook shareControl]addContactName:prefName phoneNum:phoneNumber withLabel:@"手机" email:email address:@"" fox:mobile code:@""];
    

    if (isSuccess) {
        [self showHUDWithTextOnly:@"保存成功"];
    }
    else{
        [self showHUDWithTextOnly:@"保存失败"];
    }

}

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person{
    [newPersonView dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    
    
}

- (IBAction)touchMessageEvent:(id)sender{
    if (_mobileLabel.text.length > 0) {
        path = [NSString stringWithFormat:@"sms://%@",_mobileLabel.text];
        [self showPhoneAlert:@"是否发送短信"];
    }
    else{
        [self showHUDWithTextOnly:@"号码不正确"];
    }
}

- (IBAction)touchMobileEvent:(id)sender{
    if (_mobileLabel.text.length > 0) {
        path = [NSString stringWithFormat:@"tel://%@",_mobileLabel.text];
        [self showPhoneAlert:@"是否拨打电话"];
    }
    else{
        [self showHUDWithTextOnly:@"号码不正确"];
    }
}

- (IBAction)touchMPhoneEvent:(id)sender{
    if (_phoneLabel.text.length > 0) {
        path = [NSString stringWithFormat:@"tel://%@",_phoneLabel.text];
        [self showPhoneAlert:@"是否拨打电话"];
    }
    else{
        [self showHUDWithTextOnly:@"号码不正确"];
    }
}

- (IBAction)touchEmailEvent:(id)sender{
    if (_emailLabel.text.length > 0) {
        if ([_emailLabel.text isValidateEmail:_emailLabel.text]) {
            path = [NSString stringWithFormat:@"mailto://%@",_emailLabel.text];
            [self showPhoneAlert:@"是否发送邮件"];
            
        }
        else{
            [self showHUDWithTextOnly:@"邮箱格式错误"];
        }
    }
    else{
        [self showHUDWithTextOnly:@"该用户无邮箱"];
    }
}

- (void)showPhoneAlert:(NSString*)title{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
    }
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    if (request == _httpClient) {
        _contactMapping = result;
        NSDictionary *personDetailMapping = [(NSDictionary*)_contactMapping objectForKey:@"record"];
        _nameLabel.text = [personDetailMapping objectForKey:@"user_name"];
        _dutyLabel.text = [personDetailMapping objectForKey:@"deptName"];
        _phoneLabel.text = [personDetailMapping objectForKey:@"phone"];
        _emailLabel.text = [personDetailMapping objectForKey:@"mail"];
        _areaLabel.text = [personDetailMapping objectForKey:@"userArea"];
    }
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
