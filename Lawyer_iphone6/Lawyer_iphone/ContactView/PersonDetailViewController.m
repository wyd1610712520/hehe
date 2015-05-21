//
//  PersonDetailViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-19.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "PersonDetailViewController.h"

#import "MapViewController.h"

#import "ZCAddressBook.h"

@interface PersonDetailViewController ()<UIAlertViewDelegate>{
    NSString *_path;
    MapViewController *_mapViewController;
}

@end

@implementation PersonDetailViewController

@synthesize record = _record;

@synthesize nameLabel = _nameLabel;
@synthesize dutyLabel = _dutyLabel;
@synthesize companyLabel = _companyLabel;
@synthesize mobileLabel = _mobileLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize faxLabel = _faxLabel;
@synthesize emailLabel = _emailLabel;
@synthesize addressLabel = _addressLabel;
@synthesize mailLabel = _mailLabel;
@synthesize webLabl = _webLabl;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"联系人信息" color:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _nameLabel.text = [_record objectForKey:@"clr_name"];
    _dutyLabel.text = [_record objectForKey:@"clr_duty"];
    _companyLabel.text = [_record objectForKey:@"clr_en_name"];
    _mobileLabel.text = [_record objectForKey:@"clr_phone"];
    _phoneLabel.text = [_record objectForKey:@"clr_telephone"];
    _faxLabel.text = [_record objectForKey:@"clr_fax"];
    _emailLabel.text = [_record objectForKey:@"clr_email"];
    _addressLabel.text = [_record objectForKey:@"clr_address"];
    _mailLabel.text = [_record objectForKey:@"clr_postcode"];
    _webLabl.text = [_record objectForKey:@""];
}


- (IBAction)touchMessageEvent:(id)sender {
    if (_mobileLabel.text.length>0) {
        _path = [NSString stringWithFormat:@"sms://%@",_mobileLabel.text];
        [self showPhoneAlert:@"是否发送短信"];
    }
    else{
        [self showHUDWithTextOnly:@"号码不正确"];
    }
}

- (IBAction)touchMobileEvent:(id)sender {
    if (_mobileLabel.text.length > 0) {
        _path = [NSString stringWithFormat:@"tel://%@",_mobileLabel.text];
        [self showPhoneAlert:@"是否拨打电话"];
    }
    else{
        [self showHUDWithTextOnly:@"号码不正确"];
    }
}

- (IBAction)touchPhoneEvent:(id)sender {
    if (_phoneLabel.text.length > 0) {
        _path = [NSString stringWithFormat:@"tel://%@",_phoneLabel.text];
        [self showPhoneAlert:@"是否拨打电话"];
    }
    else{
        [self showHUDWithTextOnly:@"号码不正确"];
    }
    
}

- (IBAction)touchMailEvent:(id)sender {
    if (_emailLabel.text.length > 0) {
        if ([_emailLabel.text isValidateEmail:_emailLabel.text]) {
            _path = [NSString stringWithFormat:@"mailto://%@",_emailLabel.text];
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

- (IBAction)touchLocationEvent:(id)sender {
    _mapViewController = [[MapViewController alloc] init];
    _mapViewController.address = _addressLabel.text;
    [self.navigationController pushViewController:_mapViewController animated:YES];
    [_mapViewController search];
}



- (void)showPhoneAlert:(NSString*)title{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_path]];
    }
}

- (IBAction)touchSaveEvent:(id)sender{
//    NSString * emailString = _emailLabel.text;
//    
//    NSString * phoneNumber = _mobileLabel.text;
//    
//    NSString * prefName = _nameLabel.text;
//    
//    ABAddressBookRef libroDirec = ABAddressBookCreate();
//    
//    ABRecordRef persona = ABPersonCreate();
//    
//    ABRecordSetValue(persona, kABPersonFirstNameProperty, (__bridge CFTypeRef)(prefName), nil);
//    
//
//    
//    ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
//    
//    bool didAddPhone = ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)(phoneNumber), kABPersonPhoneMobileLabel, NULL);
//    
//    if(didAddPhone){
//        
//        ABRecordSetValue(persona, kABPersonPhoneProperty, multiPhone,nil);
//        
//        
//    }
//    
//    CFRelease(multiPhone);
//
//    //##############################################################################
//    
//    ABMutableMultiValueRef emailMultiValue = ABMultiValueCreateMutable(kABPersonEmailProperty);
//    
//    bool didAddEmail = ABMultiValueAddValueAndLabel(emailMultiValue, (__bridge CFTypeRef)(emailString), kABOtherLabel, NULL);
//    
//    if(didAddEmail){
//        
//        ABRecordSetValue(persona, kABPersonEmailProperty, emailMultiValue, nil);
//        
//    }
//    
//    CFRelease(emailMultiValue);
//    
//
//    
//    ABAddressBookAddRecord(libroDirec, persona, nil);
//    
//    CFRelease(persona);
//    
//    BOOL isSuccess = ABAddressBookSave(libroDirec, nil);
//    
//    CFRelease(libroDirec);
//    
//    if (isSuccess) {
//        [self showHUDWithTextOnly:@"保存成功"];
//    }
//    else{
//        [self showHUDWithTextOnly:@"保存失败"];
//    }
    
    NSString * phoneNumber = _mobileLabel.text;
    
    NSString * mobile = _phoneLabel.text;
    
    NSString *address = _addressLabel.text;
    NSString *email = _emailLabel.text;
    NSString * prefName = _nameLabel.text;
    
    
    BOOL isSuccess = NO;
    
    isSuccess =[[ZCAddressBook shareControl]addContactName:prefName phoneNum:phoneNumber withLabel:@"手机" email:email address:address fox:mobile code:_mailLabel.text];
    
    
    if (isSuccess) {
        [self showHUDWithTextOnly:@"保存成功"];
    }
    else{
        [self showHUDWithTextOnly:@"保存失败"];
    }

}

@end


/*
 {
 "clr_address" = "\U5b89\U5fbd";
 "clr_client_name" = "\U5b89\U5fbd\U7701\U7696\U80fd\U80a1\U4efd\U6709\U9650\U516c\U53f8";
 "clr_duty" = "\U7ecf\U7406";
 "clr_email" = "simahui@SMH.com";
 "clr_en_name" = simahui;
 "clr_fax" = "0667-49583625";
 "clr_homepage" = "";
 "clr_memo" = "test_data";
 "clr_name" = "\U53f8\U9a6c\U5fbd";
 "clr_phone" = 18390347440;
 "clr_postcode" = 4657824;
 "clr_telephone" = "0667-49583625";
 }

 */
