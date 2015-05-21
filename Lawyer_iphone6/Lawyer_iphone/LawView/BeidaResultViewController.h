//
//  BeidaResultViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

@interface BeidaResultViewController : CustomNavigationViewController

@property (nonatomic, strong) NSString *lib;
@property (nonatomic, strong) NSString *searchKey;
@property (nonatomic, strong) NSString *gid;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *contentLabel;
@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIWebView *webView;

@end
