//
//  NewFileViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-20.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextField.h"



@interface NewFileViewController : CustomNavigationViewController

@property (strong, nonatomic) IBOutlet CustomTextField *addressField;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewLayout;

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *do_doc_class;



- (IBAction)touchLocationEvent:(id)sender;

- (IBAction)touchMediaEvent:(id)sender;

@end
