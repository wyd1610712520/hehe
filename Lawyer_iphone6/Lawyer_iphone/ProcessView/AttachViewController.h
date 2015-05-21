//
//  AttachViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-28.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

@interface AttachViewController : CustomNavigationViewController

@property (strong, nonatomic) NSString *caseID;
@property (strong, nonatomic) NSDictionary *item;

@property (strong, nonatomic) NSString *caseName;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIButton *docButton;
- (IBAction)touchDocEvent:(id)sender;
- (IBAction)touchSureEvent:(id)sender;

@end
