//
//  UIView+Utility.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "UIView+Utility.h"

@implementation UIView (Utility)


- (void)showBorder:(UIColor*)color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 2.0f;
    
}

- (NSString*)getCurrentDate{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:date];
}


- (UIImage*)checkResourceType:(NSString*)name{
    NSString *str = name;
    NSRange range = [str rangeOfString:@"."];
    if (range.location != NSNotFound) {
        str = [str substringFromIndex:range.location];
    }
    
    NSString *resourceName = [str lowercaseString];
    if ([resourceName isEqualToString:@"mp3"] || [resourceName isEqualToString:@"caf"]) {
        return [UIImage imageNamed:@"mp3.png"];
    }
    else if ([resourceName isEqualToString:@"pdf"]) {
        return [UIImage imageNamed:@"pdf.png"];
    }
    else if ([resourceName isEqualToString:@"mp4"] || [resourceName isEqualToString:@"mov"]) {
        return [UIImage imageNamed:@"video_logo.png"];
    }
    else if ([resourceName isEqualToString:@"html"]) {
        return [UIImage imageNamed:@"web_logo.png"];
    }
    else if ([resourceName isEqualToString:@"xsl"] || [resourceName isEqualToString:@"xlsx"]) {
        return [UIImage imageNamed:@"xsl.png"];
    }
    else if ([resourceName isEqualToString:@"doc"] || [resourceName isEqualToString:@"docx"]) {
        return [UIImage imageNamed:@"word_logo.png"];
    }
    else if ([resourceName isEqualToString:@"jpg"] || [resourceName isEqualToString:@"png"]) {
        return [UIImage imageNamed:@"image_logo.png"];
    }
    else if ([resourceName isEqualToString:@"txt"]){
        return [UIImage imageNamed:@"TXT.png"];
    }
    else if ([resourceName isEqualToString:@"ppt"] || [resourceName isEqualToString:@"pptx"]){
        return [UIImage imageNamed:@"ppt.png"];
    }
    else if ([resourceName isEqualToString:@"rar"] || [resourceName isEqualToString:@"zip"]){
        return [UIImage imageNamed:@"rar.png"];
    }
    return [UIImage imageNamed:@"other_logo.png"];
}

- (NSString*)getDate:(NSString*)string formatter:(NSString*)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *date = [dateFormatter dateFromString:string];
    [dateFormatter setDateFormat:formatter];
    NSString *time = [dateFormatter stringFromDate:date];
    return time;
    
}

- (BOOL)isEqual:(NSString*)fristDate secondDate:(NSString*)secondDate;{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *fDate = [dateFormatter dateFromString:fristDate];
    NSDate *sDate = [dateFormatter dateFromString:secondDate];
    
    
    
    
    
    if ([fDate isEqualToDate:sDate]) {
        return YES;
    }
    return NO;
    
}

- (NSString*)getLastTime:(NSString*)str{
    NSString *time = str;
    NSRange range = [time rangeOfString:@" "];
    if (range.location != NSNotFound) {
        time = [time substringFromIndex:range.location];
        return time;
    }
    return @"";
}

- (NSString*)getPerTime:(NSString*)str{
    NSString *time = str;
    NSRange range = [time rangeOfString:@" "];
    if (range.location != NSNotFound) {
        time = [time substringToIndex:range.location];
        return time;
    }
    return @"";
}


@end
