//
//  RootViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RevealViewController.h"

#import "HomeViewController.h"
#import "SetupViewController.h"

#import "ClientDetailViewController.h"
#import "ClientDetailRightViewController.h"

#import "CaseViewController.h"
#import "CaseRightViewController.h"

#import "CaseDetatilViewController.h"
#import "CaseDetailRightViewController.h"

#import "LogViewController.h"
#import "LogRightViewController.h"

#import "SchemaViewController.h"
#import "SchemaRightViewController.h"

#import "CooperationViewController.h"
#import "CooperationRightViewController.h"

#import "FileViewController.h"
#import "FileRightViewController.h"

#import "LawRuleViewController.h"
#import "LawRuleRightViewController.h"

#import "ProcessDetailViewController.h"
#import "ProcessDetailRightViewController.h"

#import "DocumentAuditViewController.h"
#import "DocumentAuditRightViewController.h"

#import "LogAuditViewController.h"
#import "LogAuditRightViewController.h"

#import "AuditCaseViewController.h"
#import "AuditCaseRightViewController.h"

@interface RootViewController : RevealViewController

@property (nonatomic, assign) BOOL isChangeStatusBar;

@property (nonatomic, strong) HomeViewController *homeViewController;
@property (nonatomic, strong) SetupViewController *setupViewController;

@property (nonatomic, strong) ClientDetailViewController *clientDetailViewController;
@property (nonatomic, strong) ClientDetailRightViewController *clientDetailRightViewController;

@property (nonatomic, strong) CaseViewController *caseViewController;
@property (nonatomic, strong) CaseRightViewController *caseRightViewController;

@property (nonatomic, strong) CaseDetailRightViewController *caseDetailRightViewController;
@property (nonatomic, strong) CaseDetatilViewController *caseDetatilViewController;

@property (nonatomic, strong) LogViewController *logViewController;
@property (nonatomic, strong) LogRightViewController *logRightViewController;

@property (nonatomic, strong) SchemaViewController *schemaViewController;
@property (nonatomic, strong) SchemaRightViewController *schemaRightViewController;

@property (nonatomic, strong) CooperationViewController *cooperationViewController;
@property (nonatomic, strong) CooperationRightViewController *cooperationRightViewController;

@property (nonatomic, strong) FileViewController *fileViewController;
@property (nonatomic, strong) FileRightViewController *fileRightViewController;

@property (nonatomic, strong) LawRuleViewController *lawRuleViewController;
@property (nonatomic, strong) LawRuleRightViewController *lawRuleRightViewController;


@property (nonatomic, strong) ProcessViewController *processViewController;
@property (nonatomic, strong) CaseRightViewController *processRightViewController;

@property (nonatomic, strong) ProcessDetailViewController *processDetailViewController;
@property (nonatomic, strong) ProcessDetailRightViewController *processDetailRightViewController;

@property (nonatomic, strong) DocumentAuditViewController *documentAuditViewController;
@property (nonatomic, strong) DocumentAuditRightViewController *documentAuditRightViewController;

@property (nonatomic, strong) LogAuditViewController *logAuditViewController;
@property (nonatomic, strong) LogAuditRightViewController *logAuditRightViewController;

@property (nonatomic, strong) AuditCaseViewController *auditCaseViewController;
@property (nonatomic, strong) AuditCaseRightViewController *auditCaseRightViewController;


+ (RootViewController *)sharedInstance;

- (void)showInHome;

- (void)showInClientDetail;
- (void)showInLog;

- (void)showInCase;
- (void)showInCaseDetail;

- (void)showInSchema;

- (void)showCooperation;

- (void)showInFile;

- (void)showInLawRule;

- (void)showInProcess;
- (void)showInProcessDetail;

- (void)showInDocumentAudit;
- (void)showInLogAudit;
- (void)showInCaseAudit;

@end
