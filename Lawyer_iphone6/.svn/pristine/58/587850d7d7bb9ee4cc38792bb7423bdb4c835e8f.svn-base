//
//  NavigationTitleView.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-31.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleButton : UIButton{
    BOOL isRotation;
    
}

@end



@interface NavigationTitleView : UIView<UIGestureRecognizerDelegate>{
    BOOL isRotation;
}

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) TitleButton *titleButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

- (void)setTitle:(NSString*)title target:(id)target action:(SEL)action;

@end


