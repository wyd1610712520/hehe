//
//  CommomClient.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommomClient.h"

@implementation CommomClient

+ (CommomClient *)sharedInstance
{
    __strong static CommomClient *instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[CommomClient alloc] init];
    });
    return instance;
}

- (void)saveAccount:(NSString*)username{
    NSString *name = username;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:name forKey:AccountName];
    [defaults synchronize];
}

- (NSString*)getAccount{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults valueForKey:AccountName];
    return name;
}

- (void)saveUserInfo:(NSDictionary*)record{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:record forKey:UserInfo];
    [defaults synchronize];
}

- (NSString*)getValueFromUserInfo:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *record = (NSDictionary*)[defaults objectForKey:UserInfo];
    NSString *value = (NSString*)[record objectForKey:key];
    return value;
}

- (void)removeAccount{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:AccountName];
    [defaults removeObjectForKey:UserInfo];
    [defaults synchronize];
}

@end
