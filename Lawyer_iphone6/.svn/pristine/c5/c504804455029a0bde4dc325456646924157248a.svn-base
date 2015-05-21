//
//  SchemaRightViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-25.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "SchemaRightViewController.h"

#import "SchemaNewViewController.h"
#import "RootViewController.h"

#import "DateViewController.h"

@interface SchemaRightViewController ()<DateViewControllerDelegate,UITextFieldDelegate>{
    SchemaViewController *_schemaViewController;
    
    SchemaNewViewController *_schemaNewViewController;
    
    DateViewController *_startPicker;
    DateViewController *_endPicker;
}

@end

@implementation SchemaRightViewController

@synthesize searchField = _searchField;

@synthesize closeButton = _closeButton;

@synthesize startButton = _startButton;
@synthesize endButton = _endButton;

- (void)setSchemaView:(SchemaViewController*)schemaViewController{
    _schemaViewController = schemaViewController;
}

- (IBAction)touchNewEvent:(id)sender{
    _schemaNewViewController.schemaRightType = SchemaRightTypeNormal;
    [self.navigationController pushViewController:_schemaNewViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _schemaViewController.navigationController.view.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _schemaViewController.navigationController.view.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = _contentView.frame;
    frame.origin.x = vectorx+20;
    frame.origin.y = 20;
    frame.size.height = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
    _contentView.frame = frame;
    [self.view addSubview:_contentView];

    _schemaNewViewController = [[SchemaNewViewController alloc] init];
    
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.dateformatter = @"yyyy-MM-dd";
    
    
    
    _endPicker = [[DateViewController alloc] init];
    _endPicker.delegate = self;
    _endPicker.dateformatter = @"yyyy-MM-dd";

    
}

- (IBAction)toucHTimeEvent:(UIButton*)sender{
    [_searchField resignFirstResponder];
    if (sender.tag == 0) {
        CGRect frame = _startPicker.view.frame;
        frame.origin.x = vectorx;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
        _startPicker.view.frame = frame;
        
        
        [self.view addSubview:_startPicker.view];
    }
    else if (sender.tag == 1){
        CGRect frame = _endPicker.view.frame;
        frame.origin.x = vectorx;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
        _endPicker.view.frame = frame;
        [self.view addSubview:_endPicker.view];
    }
}


- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    if (dateViewController == _startPicker) {
        [_startButton setTitle:date forState:UIControlStateNormal];
    }
    else if (dateViewController == _endPicker){
        [_endButton setTitle:date forState:UIControlStateNormal];
    }
}


- (IBAction)touchSearchEvent:(id)sender{
    _schemaNewViewController.startTime = _startButton.titleLabel.text;
    _schemaNewViewController.endTime = _endButton.titleLabel.text;
    _schemaNewViewController.schemaRightType = SchemaRightTypeSearch;
    _schemaNewViewController.searchKey = _searchField.text;
    [self.navigationController pushViewController:_schemaNewViewController animated:YES];
}

- (IBAction)touchClearEvent:(id)sender{
    [_startButton setTitle:@"" forState:UIControlStateNormal];
    [_endButton setTitle:@"" forState:UIControlStateNormal];
    _searchField.text = @"";
    _startButton.titleLabel.text=@"";
    _endButton.titleLabel.text=@"";
}

- (IBAction)touchCloseEvent:(id)sender{
    [self.revealContainer clickBlackLayer];
    [_searchField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
