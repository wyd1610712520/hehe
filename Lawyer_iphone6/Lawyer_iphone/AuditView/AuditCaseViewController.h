//
//  AuditCaseViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

@class RootViewController;

typedef enum {
    AuditCaseStateUndone = 0,
    AuditCaseStateDone = 1,
}AuditCaseState;

@interface AuditCaseViewController : CommomTableViewController

@property (nonatomic, assign) AuditCaseState auditCaseState;

- (void)setRootView:(RootViewController*)rootViewController;

@end
