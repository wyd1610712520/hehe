//
//  ClientDetailRightViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-9.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RightViewController.h"

@class ClientDetailViewController;

@interface ClientDetailRightViewController : RightViewController

@property (nonatomic, strong) UITableView *tableView;

- (void)setClientDetailView:(ClientDetailViewController*)clientDetailViewController;

@end
