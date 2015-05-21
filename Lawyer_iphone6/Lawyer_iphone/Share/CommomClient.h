//
//  CommomClient.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AccountName @"AccountName"
#define UserInfo @"UserInfo"

@interface CommomClient : NSObject

+ (CommomClient *)sharedInstance;

- (void)saveAccount:(NSString*)username;
- (NSString*)getAccount;

- (void)saveUserInfo:(NSDictionary*)record;
- (NSString*)getValueFromUserInfo:(NSString*)key;

- (void)removeAccount;

@end
