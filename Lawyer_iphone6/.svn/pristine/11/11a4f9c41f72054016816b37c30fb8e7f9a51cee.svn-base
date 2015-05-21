//
//  PersonViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-23.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "AvatorView.h"

#define  PersonNormal @"PersonNormal"
#define  PersonGroup @"PersonGroup"

typedef enum {
    PersonTypeNormal = 0,
    PersonTypeGroup = 1,
}PersonType;

@interface PersonViewController : CustomNavigationViewController

@property (nonatomic, assign) PersonType personType;

@property (nonatomic, strong) NSString *caseID;
@property (nonatomic, strong) NSString *ywcpID;

@property (nonatomic, strong) IBOutlet AvatorView *avatorView;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *hintView;


@property (nonatomic, strong) NSArray *datas;

- (IBAction)touchSureEvent:(id)sender;

@end
