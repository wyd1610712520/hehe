//
//  CaseDetatilViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-3.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"
#import "CaseViewController.h"

#import "CustomLabel.h"

#import "AvatorView.h"

typedef enum {
    CaseStatusNormal = 0,
    CaseStatusAudit = 1,
}CaseStatus;

@interface CaseDetatilViewController : CustomNavigationViewController

@property (nonatomic, assign) CaseStatus caseStatus;

@property (nonatomic, strong) IBOutlet UIView *currentView;
@property (nonatomic, strong) IBOutlet UIView *caseView;
@property (nonatomic, strong) IBOutlet UIView *auditCaseView;

@property (nonatomic, strong) IBOutlet UIView *operationView;

@property (nonatomic, strong) IBOutlet UILabel *caseNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *caseDateLabel;
@property (nonatomic, strong) IBOutlet UILabel *officeLabel;
@property (nonatomic, strong) IBOutlet CustomLabel *caseDescribeLabel;
@property (nonatomic, strong) IBOutlet UILabel *caseCategoryLabel;
@property (nonatomic, strong) IBOutlet UILabel *companyLabel;
@property (nonatomic, strong) IBOutlet UILabel *companyTypeLabel;
@property (nonatomic, strong) IBOutlet UILabel *instrueLabel;
@property (nonatomic, strong) IBOutlet UILabel *languageLabel;
@property (nonatomic, strong) IBOutlet UILabel *foreignLabel;
@property (nonatomic, strong) IBOutlet UILabel *lawyerLabel;
@property (nonatomic, strong) IBOutlet UILabel *arrangeLabel;
@property (nonatomic, strong) IBOutlet UILabel *caseIdLabel;
@property (nonatomic, strong) IBOutlet AvatorView *avatorView;
@property (nonatomic, assign)  BOOL isDone;

@property (strong, nonatomic) IBOutlet UIView *sureView;

- (void)setRootView:(RootViewController*)rootViewController;

- (void)setCaseId:(NSString*)caseId;

- (IBAction)touchCaseProcessEvent:(id)sender;
- (IBAction)touchCaseSearchEvent:(id)sender;
- (IBAction)touchCaseLogEvent:(id)sender;
- (IBAction)touchCasedocEvent:(id)sender;

- (IBAction)touchDescirbeEvnet:(id)sender;
- (IBAction)touchClientDetailEvnet:(id)sender;

- (IBAction)touchRejuectEvent:(id)sender;
- (IBAction)touchSureEvent:(id)sender;

- (IBAction)touchConflictEvent:(id)sender;
- (IBAction)touchContractEvent:(id)sender;

@end
