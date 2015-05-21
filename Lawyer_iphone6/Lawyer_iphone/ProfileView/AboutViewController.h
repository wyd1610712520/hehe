//
//  AboutViewController.h
//  Lawyer_iphone
//
//  Created by 邬明 on 15/3/11.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

@interface AboutViewController : CustomNavigationViewController

@property (nonatomic, strong) IBOutlet UILabel *versionLabel;

- (IBAction)touchVersionEvent:(id)sender;
- (IBAction)touchUserEvent:(id)sender;
- (IBAction)touchPhoneEvent:(id)sender;


@end
