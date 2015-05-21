//
//  ShareClient.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-10.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ShareClient.h"



@interface ShareClient ()<WBHttpRequestDelegate>{
    
}

@end

@implementation ShareClient

+ (ShareClient *)sharedInstance
{
    __strong static ShareClient *instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[ShareClient alloc] init];
    });
    return instance;
}

#pragma mark -- Sina

+ (BOOL)checkSinaShare{
    if ([WeiboSDK isCanShareInWeiboAPP]) {
        return  YES;
    }
    return NO;
}

- (void)registerAppInSina{
    [WeiboSDK enableDebugMode:NO];
    [WeiboSDK registerApp:SinaKey];
}

- (void)startSinaAuth{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = sinaRedirectURI;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}

- (void)logoutSina{
    [WeiboSDK logOutWithToken:[self getSinaToken] delegate:self withTag:@"user1"];
}

- (void)saveSinaToken:(NSString*)token{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:token forKey:SinaToken];
    [user synchronize];
}

- (NSString*)getSinaToken{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = @"";
    if ([user objectForKey:SinaToken]) {
        token = (NSString*)[user objectForKey:SinaToken];
    }
    return token;
}

- (void)deleteSinaToken{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:SinaToken];
}

- (void)shareWebInSina:(NSData*)data
                 title:(NSString*)title
                descri:(NSString*)descri
             redictUrl:(NSString*)redictUrl{
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = title;
    webpage.description = [NSString stringWithFormat:descri, [[NSDate date] timeIntervalSince1970]];
    webpage.thumbnailData = data;
    webpage.webpageUrl = redictUrl;
    message.mediaObject = webpage;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    
    [WeiboSDK sendRequest:request];
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    [self deleteSinaToken];
    [[NSNotificationCenter defaultCenter] postNotificationName:SinaLogoutSuccess object:nil];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    [[NSNotificationCenter defaultCenter] postNotificationName:SinaError object:nil];
}

#pragma mark - YiXin

- (void)startYiXinAuth{
    SendOAuthToYXReq *req = [[SendOAuthToYXReq alloc] init];
    BOOL result = [YXApi sendReq:req];
    if(!result){
        [[NSNotificationCenter defaultCenter] postNotificationName:YXError object:nil];
    }
    
}

- (void)logoutYX{
    
}

+ (BOOL)checkYXShare{
    if ([YXApi isYXAppSupportApi]) {
        return YES;
    }
    return NO;
}

#pragma mark -- YiXin

- (void)registerAppInYX{
    [YXApi registerApp:YiXinAppID];
}

- (void)shareWebInYX:(NSData*)data
               title:(NSString*)title
              descri:(NSString*)descri
           redictUrl:(NSString*)redictUrl{
    YXWebpageObject *pageObject = [YXWebpageObject object];
    pageObject.webpageUrl = redictUrl;
    
    YXMediaMessage *message = [YXMediaMessage message];
    message.title = title;
    message.description = descri;
    
    [message setThumbData:data];
    message.mediaObject = pageObject;
    
    SendMessageToYXReq *req = [[SendMessageToYXReq alloc] init];
    req.bText = NO;
    req.scene = kYXSceneSession;
    req.message = message;
    
    [YXApi sendReq:req];


}


#pragma mark -- QQ

+ (BOOL)checkQQShare{
    if ([QQApi isQQSupportApi]) {
        return YES;
    }
    return NO;
}

- (void)shareTextInQQ:(NSString*)text{
    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:text];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    [QQApiInterface sendReq:req];
}

- (void)shareImageInQQ:(NSData*)imageData{
    
}

- (void)shareHtmlInQQ:(NSData*)data
                title:(NSString*)title
               descri:(NSString*)descri
            redictUrl:(NSString*)redictUrl{
    QQApiURLObject *urlObject = [QQApiURLObject objectWithURL:[NSURL URLWithString:redictUrl] title:title description:descri previewImageData:data targetContentType:QQApiURLTargetTypeNews];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:urlObject];
    [QQApiInterface sendReq:req];

}

#pragma -mark -- Weixin

+ (BOOL)checkWXShare{
    if ([WXApi isWXAppSupportApi]) {
        return YES;
    }
    return NO;
}

- (void)registerAppInWX{
    [WXApi registerApp:WXAppID];
}

- (void)shareHtmlInWX:(NSData*)data
                title:(NSString*)title
               descri:(NSString*)descri
            redictUrl:(NSString*)redictUrl
                scene:(int)scene{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = descri;
    [message setThumbImage:[UIImage imageNamed:@"logo.png"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = redictUrl;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];

}

@end
