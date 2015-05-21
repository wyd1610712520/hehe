//
//  TextViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-30.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//


#import "CustomNavigationViewController.h"

typedef enum {
    TextTypeNormal = 0,
    TextTypeRead = 1,
}TextType;

@class TextViewController;

@protocol TextViewControllerDelegate <NSObject>
@optional
- (void)textViewController:(TextViewController*)textViewController text:(NSString*)text;
- (void)dissView;

@end

@interface TextViewController : CustomNavigationViewController

@property (nonatomic, assign) TextType textType;

@property (nonatomic, strong) NSObject<TextViewControllerDelegate> *delegate;

@property (nonatomic, strong) NSString *content;

@end
