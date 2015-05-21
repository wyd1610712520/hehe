//
//  LogAuditViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

@class RootViewController;

typedef enum {
    LogAuditTypeUndone = 0,
    LogAuditTypeDone = 1,
}LogAuditType;


@interface LogAuditViewController : CommomTableViewController

@property (nonatomic, assign) LogAuditType logAuditType;

- (void)setRootView:(RootViewController*)rootViewController;



@end
