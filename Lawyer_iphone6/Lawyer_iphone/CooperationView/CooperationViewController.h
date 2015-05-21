//
//  CooperationViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

#import "CustomTextField.h"

@class RootViewController;

@interface CooperationViewController : CommomTableViewController

@property (nonatomic, strong) IBOutlet UIView *fristView;
@property (nonatomic, strong) IBOutlet UIView *secondView;

@property (nonatomic, strong) IBOutlet UIImageView *fristImageView;
@property (nonatomic, strong) IBOutlet UIImageView *secondImageView;
@property (nonatomic, strong) IBOutlet UIImageView *thirdImageView;
@property (nonatomic, strong) IBOutlet UIImageView *fourthImageView;

@property (nonatomic, strong) IBOutlet UIImageView *fristimageView;
@property (nonatomic, strong) IBOutlet UIImageView *secondimageView;
@property (nonatomic, strong) IBOutlet UIImageView *thirdimageView;
@property (nonatomic, strong) IBOutlet UIImageView *fourthimageView;



@property (nonatomic, strong) IBOutlet CustomTextField *titleField;
@property (nonatomic, strong) IBOutlet CustomTextField *needField;


- (IBAction)touchFristEvent:(UIButton*)sender;
- (IBAction)touchSecondEvent:(UIButton*)sender;

- (void)setRootView:(RootViewController*)rootViewController;

@end
