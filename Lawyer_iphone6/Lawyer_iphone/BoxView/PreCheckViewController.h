//
//  PreCheckViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextField.h"

@interface PreCheckViewController : CustomNavigationViewController

@property (nonatomic, strong) IBOutlet CustomTextField *textField;
@property (nonatomic, strong) IBOutlet UIButton *checkButton;

- (IBAction)touchCheckEvent:(id)sender;

@end
