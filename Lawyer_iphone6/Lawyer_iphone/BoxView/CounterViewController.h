//
//  CounterViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

#import "CustomTextField.h"

@interface CounterViewController : CommomTableViewController

@property (nonatomic, strong) IBOutlet UIView *fristView;
@property (nonatomic, strong) IBOutlet UIView *secondView;
@property (nonatomic, strong) IBOutlet UIView *thirdView;

@property (nonatomic, strong) IBOutlet UIButton *fristButton;
@property (nonatomic, strong) IBOutlet UIButton *secondButton;
@property (nonatomic, strong) IBOutlet UIButton *thirdButton;

@property (nonatomic, strong) IBOutlet UIView *calculateView;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet CustomTextField *fristTextField;
@property (nonatomic, strong) IBOutlet CustomTextField *secondTextField;
@property (nonatomic, strong) IBOutlet CustomTextField *thirdTextField;

@property (nonatomic, strong) IBOutlet UIButton *caichanButton;
@property (nonatomic, strong) IBOutlet UIButton *noSubButton;
@property (nonatomic, strong) IBOutlet UIButton *jobButton;

- (IBAction)touchCalculate:(UIButton*)sender;


- (IBAction)touchCaiChanEvent:(UIButton*)sender;
- (IBAction)touchSubEvent:(id)sender;
- (IBAction)touchJobEvent:(id)sender;

@end
