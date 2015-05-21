//
//  CustomSegment.h
//  Lawyer_Iphone
//
//  Created by 邬 明 on 14-4-21.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CustomSegment;

@protocol CustomSegmentDelegate <NSObject>

- (void)touchSegment:(CustomSegment*)customSegment tag:(NSInteger)tag;

@end

@interface CustomSegment : UIScrollView

@property (nonatomic, strong) NSObject<CustomSegmentDelegate>* segmentDelegate;

@property (nonatomic, assign) float leftMargin;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) float hSpace;

- (void)setSegmentWithTitles:(NSArray*)titles;
- (void)clickFirstEvent;

@end
