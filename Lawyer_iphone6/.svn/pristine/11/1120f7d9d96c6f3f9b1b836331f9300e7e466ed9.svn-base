//
//  CustomNavigationViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-9-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommomViewController.h"
#import "NavigationSegmentView.h"
#import "SegmentView.h"

@interface CustomNavigationViewController : CommomViewController

@property (nonatomic, strong) SegmentView *titleSegment;
@property (nonatomic, assign) BOOL isSet;

- (void)setLeftButton:(UIImage*)image target:(id)target action:(SEL)action;
- (void)setRightButton:(UIImage*)image title:(NSString*)title target:(id)target action:(SEL)action;
- (void)setCenterView:(UIImage*)image targer:(id)targer action:(SEL)action;
- (void)setTitleView:(NSArray*)titles;

- (void)setTitle:(NSString *)title color:(UIColor*)color;
- (void)setDismissButton;
- (void)dismiss;
- (void)popSelf ;

- (UIButton*)setNavigationSegmentWithImages:(NSArray*)images target:(id)target action:(SEL)action;

@end
