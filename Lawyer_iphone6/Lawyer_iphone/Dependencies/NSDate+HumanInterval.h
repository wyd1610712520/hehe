//
//  NSDate+HumanInterval.h
//  Airport_ipad
//
//  Created by wuming on 11/11/13.
//  Copyright (c) 2013年 wuming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HumanInterval)

// justnow-0 s->1 m->2 h->3...
- (NSString*)humanIntervalSinceNow:(NSInteger)justNowSeconds 
                              unit:(NSInteger*)section 
                    relative:(NSInteger*)relative;
- (NSString*)humanIntervalSinceNow;

@end
