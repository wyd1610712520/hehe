//
//  AboutViewController.m
//  Lawyer_iphone
//
//  Created by 邬明 on 15/3/11.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "AboutViewController.h"

#import "WebViewController.h"

@interface AboutViewController ()<UIAlertViewDelegate>{
    WebViewController *_webViewController;
    NSString *_phone;
}

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"关于软件" color:nil];
    _versionLabel.text = [NSString stringWithFormat:@"v%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}



- (IBAction)touchVersionEvent:(id)sender {
    
}

- (IBAction)touchUserEvent:(id)sender {
    _webViewController = [[WebViewController alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xieyi" ofType:@"html"];
    _webViewController.title = @"用户协议";
    _webViewController.path = path;
    [self.navigationController pushViewController:_webViewController animated:YES];
}

- (IBAction)touchPhoneEvent:(id)sender {
    _phone = [NSString stringWithFormat:@"tel://%@",@"400 821 3228"];
    [self showPhoneAlert];
}

- (void)showPhoneAlert{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否拨打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_phone]];
    }
}


@end
