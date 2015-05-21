//
//  AuditCaseRightViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "RightViewController.h"

@class AuditCaseViewController;

@class AuditCaseRightViewController;

#import "CustomTextField.h"

@protocol AuditCaseRightViewControllerDelegate <NSObject>

- (void)returnData:(NSString*)caseName
            caseId:(NSString*)caseId
        clientName:(NSString*)clientName
      caseCategory:(NSString*)caseCategory
        caseCharge:(NSString*)caseCharge
         startTime:(NSString*)startTime
         endTime:(NSString*)endTime;

- (void)returnRedData:(NSString*)caseName
               caseId:(NSString*)caseId
               clientName:(NSString*)clientName
               category:(NSString*)category
               charge:(NSString*)charge;

@end



@interface AuditCaseRightViewController : RightViewController

@property (nonatomic, strong) NSObject<AuditCaseRightViewControllerDelegate> *delegate;

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UIView *caseRightView;

@property (nonatomic, strong) IBOutlet CustomTextField *caseNameField;
@property (nonatomic, strong) IBOutlet CustomTextField *caseIdField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientNameField;
@property (nonatomic, strong) IBOutlet UIButton *categoryButton;
@property (nonatomic, strong) IBOutlet UIButton *chargeButton;
@property (nonatomic, strong) IBOutlet UIButton *startTimeButton;
@property (nonatomic, strong) IBOutlet UIButton *endTimeButton;


- (void)setAuditCaseView:(AuditCaseViewController*)auditCaseViewController;

- (IBAction)touchCategoryEvent:(UIButton*)sender;
- (IBAction)touchChargeEvent:(UIButton*)sender;

- (IBAction)toucHTimeEvent:(UIButton*)sender;

- (IBAction)touchClearEvent:(id)sender;
- (IBAction)touchSureEvent:(id)sender;

- (IBAction)touchCloseEvent:(id)sender;


@end
