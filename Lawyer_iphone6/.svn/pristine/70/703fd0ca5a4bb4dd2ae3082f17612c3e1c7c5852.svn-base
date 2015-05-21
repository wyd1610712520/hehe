//
//  CooperationNewViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-14.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextField.h"
#import "CustomTextView.h"

typedef enum {
    CooperationTypeAdd = 1,
    CooperationTypeNew = 2,
}CooperationType;

@interface CooperationNewViewController : CustomNavigationViewController

@property (nonatomic, assign) CooperationType cooperationType;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet CustomTextField *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *categoryButton;
@property (strong, nonatomic) IBOutlet UIButton *regionButton;

@property (strong, nonatomic) IBOutlet UIScrollView *scorll;

@property (strong, nonatomic) IBOutlet UIButton *industyButton;
@property (strong, nonatomic) IBOutlet UIButton *addressButton;
@property (strong, nonatomic) IBOutlet UIButton *dateButton;
@property (strong, nonatomic) IBOutlet UIButton *bButton;
@property (strong, nonatomic) IBOutlet CustomTextField *calcaulateField;


@property (strong, nonatomic) IBOutlet UIView *sureView;

@property (strong, nonatomic) IBOutlet UILabel *wayLabel;
@property (strong, nonatomic) IBOutlet UILabel *describeLabel;

@property (strong, nonatomic) NSDictionary *record;

@property (strong, nonatomic) NSString *cooperationID;

@property (strong, nonatomic) IBOutlet CustomTextView *typeTextView;
@property (strong, nonatomic) IBOutlet CustomTextView *describeTextView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *statusButton;

- (IBAction)touchBEvent:(id)sender;

- (IBAction)touchStatusEvent:(id)sender;

- (IBAction)touchCategoryEvent:(id)sender;
- (IBAction)touchRegionEvent:(id)sender;
- (IBAction)touchIndustyEvent:(id)sender;
- (IBAction)touchAddressEvent:(id)sender;
- (IBAction)touchDateEvent:(id)sender;
- (IBAction)touchMediaView:(id)sender;

- (IBAction)touchSureEvent:(id)sender;

@end
