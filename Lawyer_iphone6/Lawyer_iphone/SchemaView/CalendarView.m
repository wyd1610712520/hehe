//
//  CalendarView.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-31.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CalendarView.h"

#import "UIView+Utility.h"

@interface CalendarView(){
    
}
@end


@implementation CalendarView

@synthesize unitView = _unitView;

@synthesize delegate = _delegate;

- (id)init{
    self = [super init];
    if (self) {
        [self addUnitView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUnitView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self addUnitView];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //
    
}

- (void)addUnitView{
    self.backgroundColor = [UIColor whiteColor];
    CGRect frame = self.bounds;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    _unitView = [[JBUnitView alloc] initWithFrame:frame UnitType:UnitTypeMonth SelectedDate:[NSDate date] AlignmentRule:JBAlignmentRuleTop Delegate:self DataSource:self];

    [self addSubview:_unitView];
    
}

#pragma mark -
#pragma mark - JBUnitGridViewDelegate
/**************************************************************
 *@Description:获取当前UnitGridView中UnitTileView的高度
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:当前unitGridView中UnitTileView的高度
 **************************************************************/
- (CGFloat)heightOfUnitTileViewsInUnitGridView:(JBUnitGridView *)unitGridView
{

    return btnHeight;
}


/**************************************************************
 *@Description:获取当前UnitGridView中UnitTileView的宽度
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:当前UnitGridView中UnitTileView的宽度
 **************************************************************/
- (CGFloat)widthOfUnitTileViewsInUnitGridView:(JBUnitGridView *)unitGridView
{
    return btnWidth;
}


//  ------------选中了当前月份或周之外的时间--------------
/**************************************************************
 *@Description:选中了当前Unit的上一个Unit中的时间点
 *@Params:
 *  unitGridView:当前unitGridView
 *  date:选中的时间点
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView selectedOnPreviousUnitWithDate:(JBCalendarDate *)date
{
    
}

/**************************************************************
 *@Description:选中了当前Unit的下一个Unit中的时间点
 *@Params:
 *  unitGridView:当前unitGridView
 *  date:选中的时间点
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView selectedOnNextUnitWithDate:(JBCalendarDate *)date
{
    
}

#pragma mark -
#pragma mark - JBUnitGridViewDataSource
/**************************************************************
 *@Description:获得unitTileView
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:unitTileView
 **************************************************************/
- (JBUnitTileView *)unitTileViewInUnitGridView:(JBUnitGridView *)unitGridView
{
    return [[JBSXRCUnitTileView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, btnWidth, btnHeight)];
}

/**************************************************************
 *@Description:设置unitGridView中的weekdaysBarView
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:weekdaysBarView
 **************************************************************/
- (UIView *)weekdaysBarViewInUnitGridView:(JBUnitGridView *)unitGridView
{
    
    return nil;
}


/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件的数量
 *@Params:
 *  unitGridView:当前unitGridView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView NumberOfEventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSInteger eventCount))completedBlock
{
    //completedBlock(calendarDate.day);
    
    
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件
 *@Params:
 *  unitGridView:当前unitGridView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView EventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSArray *events))completedBlock
{
    completedBlock(nil);
}


#pragma mark -
#pragma mark - JBUnitViewDelegate
/**************************************************************
 *@Description:获取当前UnitView中UnitTileView的高度
 *@Params:
 *  unitView:当前unitView
 *@Return:当前UnitView中UnitTileView的高度
 **************************************************************/
- (CGFloat)heightOfUnitTileViewsInUnitView:(JBUnitView *)unitView
{
    return btnHeight;
}

/**************************************************************
 *@Description:获取当前UnitView中UnitTileView的宽度
 *@Params:
 *  unitView:当前unitView
 *@Return:当前UnitView中UnitTileView的宽度
 **************************************************************/
- (CGFloat)widthOfUnitTileViewsInUnitView:(JBUnitView *)unitView
{
    return btnWidth;
}


/**************************************************************
 *@Description:更新unitView的frame
 *@Params:
 *  unitView:当前unitView
 *  newFrame:新的frame
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView UpdatingFrameTo:(CGRect)newFrame
{
    
}

/**************************************************************
 *@Description:重新设置unitView的frame
 *@Params:
 *  unitView:当前unitView
 *  newFrame:新的frame
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView UpdatedFrameTo:(CGRect)newFrame
{
    //NSLog(@"OK");
    self.frame = newFrame;
    
    
    if ([_delegate respondsToSelector:@selector(view:frameChange:)]) {
        [_delegate view:self frameChange:newFrame];
    }
    
}

#pragma mark -
#pragma mark - JBUnitViewDataSource
/**************************************************************
 *@Description:获得unitTileView
 *@Params:
 *  unitView:当前unitView
 *@Return:unitTileView
 **************************************************************/
- (JBUnitTileView *)unitTileViewInUnitView:(JBUnitView *)unitView
{
    return [[JBSXRCUnitTileView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, btnWidth, btnHeight)];
}

/**************************************************************
 *@Description:设置unitView中的weekdayView
 *@Params:
 *  unitView:当前unitView
 *@Return:weekdayView
 **************************************************************/
- (UIView *)weekdaysBarViewInUnitView:(JBUnitView *)unitView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weekdaysBarView"]];
    return imageView;
}

/**************************************************************
 *@Description:选择某一天
 *@Params:
 *  unitView:当前unitView
 *  date:选择的日期
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView SelectedDate:(NSDate *)date
{
    //NSLog(@"selected date:%@", date);
    self.frame = unitView.frame;
    
    if ([_delegate respondsToSelector:@selector(view:selectDay:)]) {
        [_delegate view:self selectDay:date];
        
    }
}

- (void)unitView:(JBUnitView *)unitView switchDate:(NSDate *)date{
    self.frame = unitView.frame;
    if ([_delegate respondsToSelector:@selector(view:switchMonth:)]) {
        [_delegate view:self switchMonth:date];
    }
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件的数量
 *@Params:
 *  unitView:当前unitView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView NumberOfEventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSInteger eventCount))completedBlock
{
    completedBlock(calendarDate.day);
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件
 *@Params:
 *  unitView:当前unitView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView EventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSArray *events))completedBlock
{
    completedBlock(nil);
}



@end

