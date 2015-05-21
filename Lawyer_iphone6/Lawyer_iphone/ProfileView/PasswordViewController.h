//
//  PasswordViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-23.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextField.h"

@interface PasswordViewController : CustomNavigationViewController

@property (nonatomic, strong) IBOutlet CustomTextField *oldWordField;
@property (nonatomic, strong) IBOutlet CustomTextField *wordField;
@property (nonatomic, strong) IBOutlet CustomTextField *sureNewField;

@property (nonatomic, strong) IBOutlet UIButton *sureButton;
@property (nonatomic, strong) IBOutlet UILabel *tintLabel;

- (IBAction)touchSureEvent:(id)sender;

@end
