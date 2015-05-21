//
//  LibViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-18.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

@class LibViewController;

@protocol LibViewControllerDelegate   <NSObject>

- (void)returnLib:(NSString*)lib code:(NSString*)code name:(NSString*)name;

@end

@interface LibViewController : CustomNavigationViewController

@property (nonatomic, strong) NSObject<LibViewControllerDelegate> *delegate;

@property (strong, nonatomic) IBOutlet UIView *hintView;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)touchNextEvent:(id)sender;
- (IBAction)touchsssSureEvent:(id)sender;

@end
