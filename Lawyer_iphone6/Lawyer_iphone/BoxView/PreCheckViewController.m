//
//  PreCheckViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "PreCheckViewController.h"

#import "CheckResultViewController.h"

@interface PreCheckViewController ()<UITextFieldDelegate>{
    CheckResultViewController *_checkResultViewController;
}

@end

@implementation PreCheckViewController

@synthesize textField = _textField;
@synthesize checkButton = _checkButton;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:[Utility localizedStringWithTitle:@"box_precheck_nav_title"] color:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *leftImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_gray_logo.png"]];
    _textField.leftView=leftImageView;
    _textField.leftViewMode = UITextFieldViewModeAlways;

    
}

- (IBAction)touchCheckEvent:(id)sender{
    _checkResultViewController = [[CheckResultViewController alloc] init];
    _checkResultViewController.searchKey = _textField.text;
    _checkResultViewController.view.frame = [UIScreen mainScreen].bounds;
    
    [self.navigationController.view addSubview:_checkResultViewController.view];
    _checkResultViewController.searchTextField.text = _textField.text;
    [_textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self touchCheckEvent:_checkButton];
    
    return YES;
}

@end
