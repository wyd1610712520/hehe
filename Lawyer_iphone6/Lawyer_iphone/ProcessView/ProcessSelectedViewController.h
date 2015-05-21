//
//  ProcessSelectedViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-18.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

typedef enum {
    ProcessSelectProcess = 1,
    ProcessSelectModule = 2,
}ProcessSelect;

@interface ProcessSelectedViewController : CommomTableViewController

@property (nonatomic, assign) ProcessSelect processSelect;

@property (nonatomic, strong) IBOutlet UIView *hintView;
@property (nonatomic, strong) IBOutlet UILabel *hintLabel;

@property (nonatomic, strong) IBOutlet UITableView *tableview;

- (IBAction)touchSureEvent:(id)sender;
- (IBAction)touchNextEvent:(id)sender;


@end
