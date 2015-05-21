//
//  CheckResultViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

#import "CustomTextField.h"

@interface CheckResultViewController : CommomTableViewController

@property (nonatomic, strong) IBOutlet CustomTextField *searchTextField;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) NSString *searchKey;

@property (nonatomic, strong) IBOutlet UIView *alertView;

- (IBAction)touchCancelEvent:(id)sender;

@end
