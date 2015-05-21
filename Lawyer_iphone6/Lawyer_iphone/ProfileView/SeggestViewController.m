//
//  SeggestViewController.m
//  Lawyer_iphone
//
//  Created by bitzsoft_mac on 15/3/22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "SeggestViewController.h"

#import "HttpClient.h"

@interface SeggestViewController ()<RequestManagerDelegate,UITextViewDelegate>{
    HttpClient *_httpCLient;
}

@end

@implementation SeggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"意见反馈" color:nil];
    _textView.placeholder = @"请输入您宝贵意见";
}

- (IBAction)touchSureEvent:(id)sender{
    _httpCLient = [[HttpClient alloc] init];
    _httpCLient.delegate = self;
    
    if (![_textView hasText]) {
        [self showHUDWithTextOnly:@"请输入您宝贵意见"];
        return;
    }
    
    [_httpCLient startRequest:[self requestParam]];
}

- (NSDictionary*)requestParam{
   
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_textView.text,@"fd_memo", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"feedback",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
        [self showHUDWithTextOnly:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self showHUDWithTextOnly:@"提交失败"];
    }
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}

@end
