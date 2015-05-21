//
//  CommomViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommomViewController.h"

@interface CommomViewController ()

@end

@implementation CommomViewController

@synthesize progressHUD = _progressHUD;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)showHUDWithTextOnly:(NSString*)title{
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    
    _progressHUD.mode = MBProgressHUDModeText;
    _progressHUD.labelText = title;
    _progressHUD.margin = 10.f;
    _progressHUD.removeFromSuperViewOnHide = YES;
    
    [_progressHUD hide:YES afterDelay:1.4];
    
}

- (void)showProgressHUD:(NSString*)title{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:_progressHUD];
    }
    _progressHUD.center = self.view.center;
    _progressHUD.size = CGSizeMake(88, 100);
    if (title.length == 0) {
        _progressHUD.labelText = @"请稍后";
    }
    else{
        _progressHUD.labelText = title;
    }
    _progressHUD.mode = MBProgressHUDModeIndeterminate;
    
    [_progressHUD show:YES];
}

- (void)hideProgressHUD:(int)afterDelay{
    [_progressHUD hide:YES afterDelay:afterDelay];
}

@end
