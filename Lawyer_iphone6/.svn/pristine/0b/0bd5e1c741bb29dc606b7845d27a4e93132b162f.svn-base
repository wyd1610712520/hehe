//
//  NameIndex.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-23.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "NameIndex.h"

#import "Hanzi.h"

@implementation NameIndex

@synthesize lastName = _lastName;
@synthesize firstName = _firstName;
@synthesize sectionNum = _sectionNum;
@synthesize originIndex = _originIndex;

- (NSString*)getFirstName {
    if ([_firstName canBeConvertedToEncoding: NSASCIIStringEncoding]) {//如果是英文
        return _firstName;
    }
    else { //如果是非英文
        return [NSString stringWithFormat:@"%c",pinyinFirstLetter([_firstName characterAtIndex:0])];
    }
    
}
- (NSString*)getLastName {
    if ([_lastName canBeConvertedToEncoding:NSASCIIStringEncoding]) {
        return _lastName;
    }
    else {
        return [NSString stringWithFormat:@"%c",pinyinFirstLetter([_lastName characterAtIndex:0])];
    }
    
}

@end
