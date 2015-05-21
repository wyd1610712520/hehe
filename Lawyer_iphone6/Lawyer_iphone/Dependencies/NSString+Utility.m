//
//  NSString+Utility.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "NSString+Utility.h"

#import "Hanzi.h"

@implementation NSString (Utility)

-(UIColor*)colorValue {
    NSString *cString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return nil;
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return nil;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    if (!rString || !gString || !bString) {
        return nil;
    }
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}

- (NSString*)processTime:(NSString*)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:self];
    [dateFormatter setDateFormat:format];
    NSString *timeStr = [dateFormatter stringFromDate:date];
    return timeStr;
}

- (NSString*)firstLetterWord:(NSString*)word{
    if ([word canBeConvertedToEncoding:NSASCIIStringEncoding]) {
        if (word.length > 0) {
            return [[NSString stringWithFormat:@"%c",[word characterAtIndex:0]] uppercaseString];
        }
        return @"";
    }
    { //如果是非英文
        return [[NSString stringWithFormat:@"%c",pinyinFirstLetter([word characterAtIndex:0])] uppercaseString];
        
    }
}

-(BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
