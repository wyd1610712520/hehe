//
//  NSDate+HumanInterval.h
//  Airport_ipad
//
//  Created by wuming on 11/11/13.
//  Copyright (c) 2013年 wuming. All rights reserved.
//


#import "NSDate+HumanInterval.h"

@implementation NSDate (HumanInterval)

- (NSString*)humanIntervalSinceNow:(NSInteger)justNowSeconds 
                              unit:(NSInteger*)section 
                    relative:(NSInteger*)relative {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
	NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
	NSDateComponents *components = [calendar components:unitFlags fromDate:self toDate:[NSDate date] options:0];
    
	NSArray *selectorNames = [NSArray arrayWithObjects:@"year", @"month", @"week", @"day", @"hour", @"minute", @"second", nil];
    NSArray *timeNames = [NSArray arrayWithObjects:@"年", @"月", @"周", @"天", @"小时", @"分钟", @"秒", nil];
    
	for ( int i = 0; i < [selectorNames count]; ++i) {
        NSString *selectorName = [selectorNames objectAtIndex:i];
		SEL currentSelector = NSSelectorFromString(selectorName);
		NSMethodSignature *currentSignature = [NSDateComponents instanceMethodSignatureForSelector:currentSelector];
		NSInvocation *currentInvocation = [NSInvocation invocationWithMethodSignature:currentSignature];
        
		[currentInvocation setTarget:components];
		[currentInvocation setSelector:currentSelector];
		[currentInvocation invoke];
        
		NSInteger relativeNumber;
		[currentInvocation getReturnValue:&relativeNumber];
        
		if (relativeNumber && relativeNumber != INT32_MAX) {
            if (relative) {
                *relative = 0;
            }
            if (section) {
                *section = 0;
            }
            if (i + 1 == [timeNames count]) {
                if (justNowSeconds >= relativeNumber) {
                    return @"刚刚";
                }
            }
            else if(i + 2 == [timeNames count]) {
                if (justNowSeconds >= relativeNumber * 60) {
                    return @"刚刚";
                }
            }
            if (relative) {
                *relative = relativeNumber;
            }
            if (section) {
                *section = [timeNames count] - i;
            }
			return [NSString stringWithFormat:@"%ld%@前", (long)relativeNumber,
                    [timeNames objectAtIndex:i]];
		}
	}
    
	return @"";
}

- (NSString*)humanIntervalSinceNow {
    return [self humanIntervalSinceNow:15 unit:0 relative:0];
}

@end
