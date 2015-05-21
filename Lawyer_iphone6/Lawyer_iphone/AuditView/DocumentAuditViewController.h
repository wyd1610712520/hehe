//
//  DocumentAuditViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

@class RootViewController;

typedef enum {
    DocumentAuditTypeUndone = 0,
    DocumentAuditTypeDone = 1,
}DocumentAuditType;

@interface DocumentAuditViewController : CommomTableViewController

@property (nonatomic, assign) DocumentAuditType documentAuditType;

- (void)setRootView:(RootViewController*)rootViewController;

@end
