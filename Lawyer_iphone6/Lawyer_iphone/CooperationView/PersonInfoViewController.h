//
//  PersonInfoViewController.h
//  Lawyer_iphone
//
//  Created by bitzsoft_mac on 15/3/14.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CircleButton.h"

@interface PersonInfoViewController : CustomNavigationViewController


@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) NSString *rdi_creator;

@property (strong, nonatomic) IBOutlet CircleButton *avatorButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobLabel;
@property (strong, nonatomic) IBOutlet UILabel *deLabel;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@end
