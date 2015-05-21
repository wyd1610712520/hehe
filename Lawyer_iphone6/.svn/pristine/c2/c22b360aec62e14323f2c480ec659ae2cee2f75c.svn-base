//
//  HttpClient.h
//  Lawyer_ipad
//
//  Created by 邬 明 on 14-12-12.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetWorking.h"

#define HOSTURL @"http://www.elinklaw.com/mobile/Mobileinterface_new.ashx"
#define HOSTCOMMOMURL @"http://www.elinklaw.com/Common/generalcode.ashx"
#define LawURL @"http://124.192.33.50:6031/Db/"
#define TestUrl @"http://test.elinklaw.com/Mobile/mobileinterface.ashx"
#define TESTCOMMOMURL @"http://test.elinklaw.com/Common/generalcode.ashx"
#define Beida @"http://124.192.33.50:6031/Db"

@protocol RequestManagerDelegate <NSObject>

@optional

- (void)requestStarted:(id)request;

- (void)request:(id)request didCompleted:(id)responseObject;

- (void)requestFailed:(id)request;

- (void)request:(id)request didReceiveFile:(NSString*)fileName;

@end

@interface HttpClient : NSObject

@property (nonatomic, strong) NSObject<RequestManagerDelegate> *delegate;

@property (nonatomic, strong) AFHTTPRequestOperation *operation;
@property (nonatomic, assign) BOOL isChange;

- (void)startRequest:(NSDictionary*)parameters;
- (void)startRequestAtPath:(NSDictionary*)parameters path:(NSString*)path;
- (void)startRequestAtCommom:(NSDictionary*)parameters;
- (void)cancelRequest;
- (void)startBeidaRequest:(NSDictionary*)parameters path:(NSString*)path;

@end
