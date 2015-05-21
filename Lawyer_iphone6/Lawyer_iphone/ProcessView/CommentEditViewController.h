//
//  CommentEditViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-27.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextView.h"

@interface CommentEditViewController : CustomNavigationViewController

@property (strong, nonatomic) IBOutlet UILabel *numLabel;

@property (strong, nonatomic) IBOutlet CustomTextView *textView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *sureView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong) NSString *caseID;
@property (nonatomic, strong) NSString *ywcpID;

- (IBAction)touchAttachEvent:(id)sender;

- (IBAction)touchSureEvent:(id)sender;

@end
