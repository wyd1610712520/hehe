//
//  JBSXRCUnitTileView.m
//  JBCalendar
//
//  Created by YongbinZhang on 7/23/13.
//  Copyright (c) 2013 YongbinZhang
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "JBSXRCUnitTileView.h"
#import <QuartzCore/QuartzCore.h>

@interface JBSXRCUnitTileView ()

@end

@implementation JBSXRCUnitTileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.eventCountLabel.hidden = NO;
        
        self.dayLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        CGRect dayLabelFrame = self.dayLabel.frame;
        dayLabelFrame.origin.y = self.bounds.size.height*0.1;
        dayLabelFrame.size.height = self.bounds.size.height*0.7;
        self.dayLabel.frame = dayLabelFrame;

      
        
        CGRect lunarLabelFrame = self.lunarLabel.frame;
        lunarLabelFrame.origin.y = self.bounds.size.height*0.5;
        lunarLabelFrame.size.height = self.bounds.size.height*0.5;
        self.lunarLabel.frame = lunarLabelFrame;
        
        self.lunarLabel.font = [UIFont systemFontOfSize:11.0f];
        self.lunarLabel.textColor = [UIColor grayColor];
        
        self.lunarLabel.hidden = NO;
    }
    return self;
}

- (NSUInteger)weekday:(NSDate*)weekDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSWeekdayCalendarUnit) fromDate:weekDate];
    return [weekdayComponents weekday];
}

/**************************************************************
 *模版方法，设置Tile的显示
 **************************************************************/
- (void)updateUnitTileViewShowingWithOtherUnit:(BOOL)otherUnit Selected:(BOOL)selected Today:(BOOL)today eventsCount:(NSInteger)eventsCount date:(JBCalendarDate *)date
{
    [super updateUnitTileViewShowingWithOtherUnit:otherUnit Selected:selected Today:today eventsCount:eventsCount date:date];
    

    if (otherUnit) {
        self.dayLabel.textColor = [UIColor whiteColor];
        self.lunarLabel.textColor = [UIColor whiteColor];
        
    } else {
        if (selected) {

            self.selectImageView.hidden = NO;
            self.dayLabel.textColor = [UIColor whiteColor];
            self.lunarLabel.textColor = [UIColor whiteColor];
        } else if (today) {
            self.selectImageView.hidden = YES;
//            self.dayLabel.textColor = [UIColor blackColor];
//            self.lunarLabel.textColor = [UIColor blackColor];
            
            NSUInteger tag = [self weekday:date.nsDate];
            if (tag == 1 || tag == 7) {
                self.dayLabel.textColor = [UIColor redColor];
                self.lunarLabel.textColor = [UIColor redColor];
            }
            else{
                self.dayLabel.textColor = [UIColor blackColor];
                self.lunarLabel.textColor = [UIColor blackColor];
            }

        } else {
            self.selectImageView.hidden = YES;
            
            NSUInteger tag = [self weekday:date.nsDate];
            if (tag == 1 || tag == 7) {
                self.dayLabel.textColor = [UIColor redColor];
                self.lunarLabel.textColor = [UIColor redColor];
            }
            else{
                self.dayLabel.textColor = [UIColor blackColor];
                self.lunarLabel.textColor = [UIColor blackColor];
            }
            JBCalendarDate *todayDate = [JBCalendarDate dateFromNSDate:[NSDate date]];
            
            if (self.date.year == todayDate.year && self.date.month == todayDate.month && date.day < todayDate.day) {
                self.dayLabel.textColor = [UIColor lightGrayColor];
                self.lunarLabel.textColor = [UIColor lightGrayColor];
            }
            else if (self.date.year == todayDate.year && self.date.month < todayDate.month){
                self.dayLabel.textColor = [UIColor lightGrayColor];
                self.lunarLabel.textColor = [UIColor lightGrayColor];
            }
            else if (self.date.year < todayDate.year){
                self.dayLabel.textColor = [UIColor lightGrayColor];
                self.lunarLabel.textColor = [UIColor lightGrayColor];
            }
        }
    }
    

    
    
    if (eventsCount == 0) {
        self.eventCountLabel.text = @"";
        
    } else {
        
        self.eventCountLabel.text = [NSString stringWithFormat:@"%li", (long)eventsCount];
    }
}

@end
