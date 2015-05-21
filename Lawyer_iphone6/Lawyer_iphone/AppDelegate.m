//
//  AppDelegate.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-5.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"

#import "HomeViewController.h"

#import "ShareClient.h"

@interface AppDelegate ()<TencentSessionDelegate,WeiboSDKDelegate,WXApiDelegate,YXApiDelegate>{
    TencentOAuth *_tencentOAuth;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];
    
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQAppID andDelegate:self];
    [[ShareClient sharedInstance] registerAppInSina];
    [[ShareClient sharedInstance] registerAppInYX];
    [[ShareClient sharedInstance] registerAppInWX];
    
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    self.window.rootViewController = loginViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message{
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([sourceApplication isEqualToString:@"com.tencent.mqq"])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    else if ([sourceApplication isEqualToString:@"com.yixin.yixin"]){
        return [YXApi handleOpenURL:url delegate:self];
    }
    else if ([sourceApplication isEqualToString:@"com.sina.weibo"]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    else if ([sourceApplication isEqualToString:@"com.tencent.xin"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
}

#pragma mark -- YiXin

- (void)onReceiveRequest: (YXBaseReq *)req{
}

- (void)onReceiveResponse: (YXBaseResp *)resp{
    if([resp isKindOfClass:[SendMessageToYXResp class]])
    {
    }else if([resp isKindOfClass:[SendOAuthToYXResp class]]){
        if(resp.code == kYXRespSuccess){
           
        }else{
        }
    }
    
}


@end
