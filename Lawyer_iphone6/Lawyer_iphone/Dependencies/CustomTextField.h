//
//  CustomTextField.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField

@property (nonatomic, strong) UIColor* placeholderTextColor;

/**
 * If non-nil, this font will be used to draw the placeholder text.
 * else the text field font will be used.
 */
@property (nonatomic, strong) UIFont* placeholderFont;

/**
 * The amount to inset the text by, or zero to use default behavior
 */
@property (nonatomic, assign) UIEdgeInsets textInsets;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) UIEdgeInsets leftIndsets;

- (void)setStyleInHome;

@end
