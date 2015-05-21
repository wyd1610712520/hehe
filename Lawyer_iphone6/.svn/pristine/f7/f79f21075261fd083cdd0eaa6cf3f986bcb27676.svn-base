//
//  LoginViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-5.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommomViewController.h"

#import "CustomTextField.h"

@interface LoginViewController : CommomViewController

@property (nonatomic, strong) IBOutlet UIView *contentView;


@property (strong, nonatomic) IBOutlet CustomTextField *userNameField;
@property (strong, nonatomic) IBOutlet UIButton *rememberButton;
@property (strong, nonatomic) IBOutlet CustomTextField *passwordField;
@property (strong, nonatomic) IBOutlet UIView *loginView;


@property (strong, nonatomic) IBOutlet UIView *authView;
@property (strong, nonatomic) IBOutlet UIButton *authButton;
@property (strong, nonatomic) IBOutlet CustomTextField *authField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginTop;

- (IBAction)touchRememberEvent:(UIButton*)sender;

- (IBAction)touchLoginEvent:(id)sender;
- (IBAction)touchAuthEvent:(id)sender;

@end
