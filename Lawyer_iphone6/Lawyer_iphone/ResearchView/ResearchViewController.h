//
//  ResearchViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"



#import "CustomTextField.h"

@interface ResearchViewController : CustomNavigationViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIButton *locationButton;

@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (nonatomic, strong) IBOutlet UIButton *caseNameButton;
@property (nonatomic, strong) IBOutlet CustomTextField *caseIdField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientNameField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientIdField;
@property (nonatomic, strong) IBOutlet CustomTextField *pathField;
@property (nonatomic, strong) IBOutlet UIButton *docButton;
@property (nonatomic, strong) IBOutlet CustomTextField *addressField;

@property (nonatomic, strong) NSDictionary *record;

- (IBAction)touchCaseEvent:(id)sender;
- (IBAction)touchAttachEvent:(id)sender;
- (IBAction)touchSureEvent:(id)sender;
- (IBAction)touchDocEvent:(id)sender;
- (IBAction)touchLocationEvent:(id)sender;

@end
