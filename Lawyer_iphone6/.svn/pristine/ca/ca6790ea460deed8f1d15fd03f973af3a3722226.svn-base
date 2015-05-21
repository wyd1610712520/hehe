//
//  NewsDetailViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "NewsViewController.h"
#import "HttpClient.h"


@interface NewsDetailViewController : CustomNavigationViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scroll;

@property (nonatomic, assign) NewType newType;

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSDictionary *record;
@property (nonatomic, strong) NSString *titleID;

@property (nonatomic, strong) IBOutlet UIButton *attachButton;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *typeLabel;
@property (nonatomic, strong) IBOutlet UILabel *contentLabel;
@property (nonatomic, strong) IBOutlet UILabel *attachLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageHeightLayout;

- (IBAction)touchAttachEvent:(id)sender;


@end
