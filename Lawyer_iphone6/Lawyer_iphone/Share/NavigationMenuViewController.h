//
//  NavigationMenuViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-1.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommomViewController.h"

@interface NavigationMenuViewController : CommomViewController


+ (NavigationMenuViewController *)sharedInstance;

- (IBAction)touchCloseEvent:(id)sender;

- (IBAction)touchHomeEvent:(UIButton*)sender;
- (IBAction)touchMessageEvent:(id)sender;
- (IBAction)touchAuditEvent:(id)sender;
- (IBAction)touchFavoriteEvent:(id)sender;

@property (nonatomic, assign) BOOL isSet;

@end
