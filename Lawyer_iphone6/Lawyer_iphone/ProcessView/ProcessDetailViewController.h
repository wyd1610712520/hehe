//
//  ProcessDetailViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

#import "ProcessDetailCell.h"

@class RootViewController;

typedef enum {
    ProcessDetailNormal = 0,
    ProcessDetailEdit = 1,
}ProcessDetail;

@interface ProcessDetailViewController : CommomTableViewController

@property (nonatomic, assign) ProcessDetail processDetail;

@property (nonatomic, assign) BOOL isScrollBottom;

@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) IBOutlet ProcessDetailCell *processDetailCell;

@property (nonatomic, strong) NSString *caseID;
@property (nonatomic, strong) NSDictionary *record;
@property (nonatomic, strong) IBOutlet UILabel *caseNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *caseIdLabel;
@property (nonatomic, strong) IBOutlet UILabel *clientNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *caseTypeLabel;
@property (nonatomic, strong) IBOutlet UILabel *manageLabel;
@property (nonatomic, strong) IBOutlet UILabel *caseDateLabel;
@property (nonatomic, strong) IBOutlet UIView *sureView;
@property (nonatomic, assign) BOOL ispop;

- (void)setRootView:(RootViewController*)rootViewController;

@end
