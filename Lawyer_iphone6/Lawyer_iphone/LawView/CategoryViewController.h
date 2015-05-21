//
//  CategoryViewController.h
//  Lawyer_iphone
//
//  Created by bitzsoft_mac on 15/3/22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

@interface CategoryViewController : CommomTableViewController

@property (nonatomic, strong) NSString *navtitle;
@property (nonatomic, strong) NSDictionary *item;

@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) IBOutlet UILabel *hintLabel;

@end
