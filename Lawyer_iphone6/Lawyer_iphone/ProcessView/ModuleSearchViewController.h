//
//  ModuleSearchViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-23.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#define ModuleSearch @"ModuleSearch"
#define ModuleBack @"ModuleBack"

#import "CustomTextField.h"

@class ModuleSearchViewController;

@protocol ModuleSearchViewDelegate <NSObject>

- (void)returnModuleSearch:(NSString*)name creator:(NSString*)creator;

@end

@interface ModuleSearchViewController : CustomNavigationViewController

@property (strong, nonatomic) NSObject<ModuleSearchViewDelegate> *delegate;

@property (strong, nonatomic) IBOutlet CustomTextField *nameField;
@property (strong, nonatomic) IBOutlet UIButton *categoryButton;
@property (strong, nonatomic) IBOutlet UIButton *creatorButton;
@property (strong, nonatomic) IBOutlet UIButton *startTimeButton;
@property (strong, nonatomic) IBOutlet UIButton *endTimeButton;

- (IBAction)touchCategoryEvent:(id)sender;

- (IBAction)touchCreatorEvent:(id)sender;
- (IBAction)touchTimeEvent:(UIButton *)sender;

- (IBAction)touchSureEvent:(id)sender;
- (IBAction)touchClearEvent:(id)sender;

@end
