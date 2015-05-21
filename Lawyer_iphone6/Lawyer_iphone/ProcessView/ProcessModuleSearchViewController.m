//
//  ProcessModuleSearchViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-18.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProcessModuleSearchViewController.h"

#import "ProcessSelectedViewController.h"

@interface ProcessModuleSearchViewController ()<UITextFieldDelegate>{
    ProcessSelectedViewController *_processSelectedViewController;
}

@end

@implementation ProcessModuleSearchViewController

@synthesize firstField = _firstField;
@synthesize secondField = _secondField;
@synthesize thirdField = _thirdField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _processSelectedViewController = [[ProcessSelectedViewController alloc] init];
    _processSelectedViewController.processSelect = ProcessSelectModule;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _secondField) {
        [self.navigationController pushViewController:_processSelectedViewController animated:YES];
        return NO;
    }
    else if (textField == _thirdField){
   
        return NO;
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
