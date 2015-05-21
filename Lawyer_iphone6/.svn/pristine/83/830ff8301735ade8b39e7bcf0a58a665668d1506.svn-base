//
//  AlertView.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-19.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AlertButtonOne = 1,
    AlertButtonTwo = 2,
}AlertButtonType;

@class AlertView;

@protocol AlertViewDelegate <NSObject>

@optional

- (void)alertView:(AlertView*)alertView field:(NSString*)text;

@end

@interface AlertView : UIView

@property(nonatomic, strong) NSObject<AlertViewDelegate> *delegate;

@property (nonatomic, assign) AlertButtonType alertButtonType;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UITextView *textView;


- (void)showSimpleTitle:(NSString*)title;

- (void)showField:(NSString*)title;
- (void)showTextView:(NSString*)content;


@end
