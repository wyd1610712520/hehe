//
//  VisiteAndCaseViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

typedef enum {
    VisiteType = 1,
    CaseStatType = 2,
}VisiteAndCaseType;

@interface VisiteAndCaseViewController : CommomTableViewController

@property (nonatomic, assign) VisiteAndCaseType visiteAndCaseType;

@property (nonatomic, strong) NSString *clientId;

@end
