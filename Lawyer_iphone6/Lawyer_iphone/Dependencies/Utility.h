//
//  Utility.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-2.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KLanguage @"Language"
#define KLanguageEn @"LanguageEn"
#define kLanguageCh @"LanguageCh"

@interface Utility : NSObject

+ (NSString*)currentLanguage;

+ (NSString*)localizedStringWithTitle:(NSString*)title;

@end
