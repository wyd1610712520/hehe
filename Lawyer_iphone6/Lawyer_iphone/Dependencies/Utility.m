//
//  Utility.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-2.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSString*)currentLanguage{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KLanguage];
}

+ (NSString*)localizedStringWithTitle:(NSString*)title{
    NSString *language = [Utility currentLanguage];
    if (language == nil) {
        language = [[NSUserDefaults standardUserDefaults] objectForKey:KLanguage];
        if (language == nil) {
            language = kLanguageCh;
        }
    }
    NSString *str = nil;
    NSString *stringTableName = nil;
    if ([language isEqualToString:KLanguageEn]) {
        stringTableName = @"language_en";
    } else if ([language isEqualToString:kLanguageCh]) {
        stringTableName = @"language_ch";
    }
    
    if ([stringTableName length]) {
        str = NSLocalizedStringFromTable(title,stringTableName, nil);
    }
//    [[NSBundle mainBundle] localizedStringForKey:title value:@"" table:stringTableName];
    return str;

}

@end
