//
//  ModulePreviewViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-2-4.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

typedef enum {
    ModuleTypeNormal = 0,
    ModuleTypeCustom = 1,
}ModuleType;

@interface ModulePreviewViewController : CustomNavigationViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) ModuleType moduleType;

@property (strong, nonatomic) IBOutlet UILabel *moduleNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *manageLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) IBOutlet UIView *customView;

@property (nonatomic, strong) NSDictionary *record;

@property (nonatomic, strong) NSString *caseID;
@property (nonatomic, strong) NSString *cptcID;

- (IBAction)touchSureEvent:(id)sender;

- (IBAction)touchProEvent:(id)sender;

@end
