//
//  SegmentView.h
//  AirportService
//
//  Created by sugar on 13-9-14.
//  Copyright (c) 2013年 cares. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentView;

@protocol SegmentViewDelegate <NSObject>

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button;

@end

@interface SegmentView : UIView{
    
}
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, assign) NSObject<SegmentViewDelegate> *delegate;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) BOOL isTouchEvent;
@property (nonatomic, strong) NSMutableArray *buttons;

- (id)initWithTitle:(NSArray*)titles;

- (void)clickSegment:(UIButton*)button;


@end
