//
//  NavigationSegmentView.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-31.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationSegmentView : UIView

@property (nonatomic, strong) UIButton *firstButton;


- (void)setImages:(NSArray*)images target:(id)target action:(SEL)action;



@end


@interface NavigationButton : UIButton

@end