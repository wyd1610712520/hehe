//
//  ProcessModuleSearchViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-18.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

#import "CustomTextField.h"

@interface ProcessModuleSearchViewController : CommomTableViewController

@property (nonatomic, strong) IBOutlet CustomTextField *firstField;
@property (nonatomic, strong) IBOutlet CustomTextField *secondField;
@property (nonatomic, strong) IBOutlet CustomTextField *thirdField;

@end
