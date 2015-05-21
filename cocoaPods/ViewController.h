//
//  ViewController.h
//  cocoaPods
//
//  Created by yadong on 15/5/21.
//  Copyright (c) 2015年 wangyadong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *ipTextField;
@property (strong, nonatomic) IBOutlet UILabel *lab;

- (IBAction)btnClick:(UIButton *)sender;

@end

