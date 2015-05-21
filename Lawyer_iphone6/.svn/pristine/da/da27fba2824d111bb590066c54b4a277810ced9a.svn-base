//
//  NSDictionary+SafeObject.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-2-7.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "NSDictionary+SafeObject.h"

#define checkNull(__X__)        (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

@implementation NSDictionary (SafeObject)



- (NSString *)safeObjectForKey:(id)key{
    return checkNull([self objectForKey:key]);
}

@end
