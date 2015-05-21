//
//  CalendarView.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-31.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JBCalendarLogic.h"

#import "JBUnitView.h"
#import "JBUnitGridView.h"

#import "JBSXRCUnitTileView.h"

#define btnWidth     [UIScreen mainScreen].bounds.size.width/7
#define btnHeight     [UIScreen mainScreen].bounds.size.width/7

@class CalendarView;

@protocol CalendarViewDelegate <NSObject>

- (void)view:(CalendarView*)calendarView frameChange:(CGRect)frame;
- (void)view:(CalendarView*)calendarView switchMonth:(NSDate*)date;
- (void)view:(CalendarView*)calendarView selectDay:(NSDate*)date;


@end

@interface CalendarView : UIView<JBUnitGridViewDelegate, JBUnitGridViewDataSource, JBUnitViewDelegate, JBUnitViewDataSource>

@property (nonatomic, strong) JBUnitView *unitView;

@property (nonatomic, strong) NSObject<CalendarViewDelegate> *delegate;

@end


