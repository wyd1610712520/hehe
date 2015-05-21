//
//  RevealViewController.h
//  Lawyer_Iphone
//
//  Created by 邬 明 on 14-4-14.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RevealViewController : UIViewController

@property (nonatomic, strong) UIViewController *centerViewController;
@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *rightViewController;

- (void)showRight;
- (void)showLeft;
- (void)showCenter;

- (void)dismiss;

- (void)clickBlackLayer;

@end


@interface UIViewController (RevealViewController)

- (RevealViewController*)revealContainer;


@end
