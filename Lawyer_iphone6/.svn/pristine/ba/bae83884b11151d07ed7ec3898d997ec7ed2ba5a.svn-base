//
//  ShareClient.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-10.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YXApi.h"
#import "WeiboSDK.h"

#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/WeiBoAPI.h>
#import <TencentOpenAPI/WeiyunAPI.h>
#import <TencentOpenAPI/sdkdef.h>

#import "WXApi.h"
#import "WXApiObject.h"

/*
 必智科技公司账号	账号	密码
 易信	bitzsoft@bitzsoft.com	admin2000
 AppID: yxdc91303d65f44c609f124e241b0fe9ea
 AppSecret: 402d7d84e32635183
 
 
 微信	admin@elinklaw.com	admin2014
 微博	admin@elinklaw.com	admin2014
 QQ     3139402677	admin2014
 */

#define SinaError @"SinaError"
#define SinaLogoutSuccess @"SinaLogoutSuccess"
#define SinaLoginSuccess @"SinaLoginSuccess" 

#define SinaKey @"3486122649"
#define SinaToken @"token"
#define sinaRedirectURI @"https://api.weibo.com/oauth2/default.html"



#define YXError @"YXError"
#define YXLoginSuccess @"YXLoginSuccess"
#define YXLogoutSuccess @"YXLogoutSuccess"

#define YiXinAppID @"yxdc91303d65f44c609f124e241b0fe9ea"


#define QQError @"QQError"
#define QQLoginSuccess @"QQLoginSuccess"
#define QQLogoutSuccess @"QQLogoutSuccess"

#define QQAppID @"1103468549"
#define QQAppKey @"Mn6u57uaXuo086L9"

#define WXAppID @"wx39188b7cfd00ea6f"
#define WXAppKey @"33c88e3f49c3cb8370db32837c6ef4c9"

@interface ShareClient : NSObject

+ (ShareClient *)sharedInstance;

#pragma mark -- Sina
+ (BOOL)checkSinaShare;
- (void)registerAppInSina;
- (void)startSinaAuth;
- (void)logoutSina;
- (void)saveSinaToken:(NSString*)token;
- (NSString*)getSinaToken;

- (void)shareWebInSina:(NSData*)data
               title:(NSString*)title
              descri:(NSString*)descri
           redictUrl:(NSString*)redictUrl;

#pragma mark -- YiXin
+ (BOOL)checkYXShare;
- (void)registerAppInYX;
- (void)startYiXinAuth;
- (void)logoutYX;

- (void)shareWebInYX:(NSData*)data
               title:(NSString*)title
              descri:(NSString*)descri
           redictUrl:(NSString*)redictUrl;

#pragma mark -- QQ
+ (BOOL)checkQQShare;
- (void)shareTextInQQ:(NSString*)text;

- (void)shareImageInQQ:(NSData*)NSData;

- (void)shareHtmlInQQ:(NSData*)data
                title:(NSString*)title
               descri:(NSString*)descri
            redictUrl:(NSString*)redictUrl;


#pragma -mark -- Weixin

+ (BOOL)checkWXShare;
- (void)registerAppInWX;
- (void)shareHtmlInWX:(NSData*)data
                title:(NSString*)title
               descri:(NSString*)descri
            redictUrl:(NSString*)redictUrl
                scene:(int)scene;

@end

