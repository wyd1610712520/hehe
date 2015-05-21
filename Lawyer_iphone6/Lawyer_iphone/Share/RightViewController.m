//
//  RightViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-9.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

@synthesize backgroundView = _backgroundView;

- (void)viewDidLoad {
    [super viewDidLoad];
    _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightbackground.png"]];
    _backgroundView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:_backgroundView atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
