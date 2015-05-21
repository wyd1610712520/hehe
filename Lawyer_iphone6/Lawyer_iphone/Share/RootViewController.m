//
//  RootViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController (){
    UINavigationController *_setUpNav;
    
    UINavigationController *_clientDetailNav;
    UINavigationController *_clientDetailRightNav;
    
    UINavigationController *_caseNav;
    UINavigationController *_caseRightNav;
    
    UINavigationController *_caseDetailNav;
    UINavigationController *_caseDetailRightNav;
    
    UINavigationController *_logNav;
    UINavigationController *_logRightNav;
    
    UINavigationController *_schemaNav;
    UINavigationController *_schemaRightNav;
    
    UINavigationController *_cooperationNav;
    UINavigationController *_cooperationRightNav;
    
    UINavigationController *_fileNav;
    UINavigationController *_fileRightNav;
    
    UINavigationController *_lawRuleNav;
    UINavigationController *_lawRuleRightNav;
    
    UINavigationController *_processNav;
    UINavigationController *_processRightNav;
    
    UINavigationController *_processDetailNav;
    UINavigationController *_processDetailRightNav;

    UINavigationController *_documentAuditNav;
    UINavigationController *_documentAuditRightNav;
    
    UINavigationController *_logAuditNav;
    UINavigationController *_logAuditRightNav;

    UINavigationController *_caseAuditNav;
    UINavigationController *_caseAuditRightNav;

}

@end

@implementation RootViewController

@synthesize isChangeStatusBar = _isChangeStatusBar;

@synthesize homeViewController = _homeViewController;
@synthesize setupViewController = _setupViewController;

@synthesize clientDetailViewController = _clientDetailViewController;
@synthesize clientDetailRightViewController = _clientDetailRightViewController;

@synthesize caseRightViewController = _caseRightViewController;
@synthesize caseViewController = _caseViewController;

@synthesize caseDetatilViewController = _caseDetatilViewController;
@synthesize caseDetailRightViewController = _caseDetailRightViewController;

@synthesize logRightViewController = _logRightViewController;
@synthesize logViewController = _logViewController;

@synthesize schemaViewController = _schemaViewController;
@synthesize schemaRightViewController = _schemaRightViewController;

@synthesize cooperationViewController = _cooperationViewController;
@synthesize cooperationRightViewController = _cooperationRightViewController;

+ (RootViewController *)sharedInstance
{
    __strong static RootViewController *instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[RootViewController alloc] init];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _homeViewController = [HomeViewController sharedInstance];
    _setupViewController = [[SetupViewController alloc] init];
    [_setupViewController setHomeView:_homeViewController];
    _setUpNav = [[UINavigationController alloc] initWithRootViewController:_setupViewController];
}

- (void)showInCaseAudit{
    _auditCaseViewController = [[AuditCaseViewController alloc] init];
    _auditCaseRightViewController = [[AuditCaseRightViewController alloc] init];
    
    [_auditCaseViewController setRootView:self];
    [_auditCaseRightViewController setAuditCaseView:_auditCaseViewController];
    
    _caseAuditNav = [[UINavigationController alloc] initWithRootViewController:_auditCaseViewController];
    _caseAuditRightNav = [[UINavigationController alloc] initWithRootViewController:_auditCaseRightViewController];
    [self setCenterViewController:_caseAuditNav];
    [self setRightViewController:_caseAuditRightNav];
}

- (void)showInLogAudit{
    _logAuditViewController = [[LogAuditViewController alloc] init];
    _logAuditRightViewController = [[LogAuditRightViewController alloc] init];
    
    [_logAuditViewController setRootView:self];
    [_logAuditRightViewController setLogAuditView:_logAuditViewController];
    
    _logAuditNav = [[UINavigationController alloc] initWithRootViewController:_logAuditViewController];
    _logAuditRightNav = [[UINavigationController alloc] initWithRootViewController:_logAuditRightViewController];
    
    [self setCenterViewController:_logAuditNav];
    [self setRightViewController:_logAuditRightNav];
}

- (void)showInDocumentAudit{
    _documentAuditViewController = [[DocumentAuditViewController alloc] init];
    _documentAuditRightViewController = [[DocumentAuditRightViewController alloc] init];
    [_documentAuditRightViewController setDocumentAuditView:_documentAuditViewController];
    [_documentAuditViewController setRootView:self];
    
    _documentAuditNav = [[UINavigationController alloc] initWithRootViewController:_documentAuditViewController];
    _documentAuditRightNav = [[UINavigationController alloc] initWithRootViewController:_documentAuditRightViewController];
    [self setCenterViewController:_documentAuditNav];
    [self setRightViewController:_documentAuditRightNav];
}

- (void)showInProcess{
    _processViewController = [[ProcessViewController alloc] init];
    _processNav = [[UINavigationController alloc] initWithRootViewController:_processViewController];
    
    _processRightViewController = [[CaseRightViewController alloc] init];
    _processRightViewController.viewType = ViewTypeProcessRight;
    _processRightNav = [[UINavigationController alloc] initWithRootViewController:_processRightViewController];
    [_processRightViewController setProcessView:_processViewController];
    [_processViewController setRootView:self];
    
    [self setCenterViewController:_processNav];
    [self setRightViewController:_processRightNav];
}

- (void)showInProcessDetail{
    _processDetailViewController = [[ProcessDetailViewController alloc] init];
    _processDetailNav = [[UINavigationController alloc] initWithRootViewController:_processDetailViewController];
    
    
    _processDetailRightViewController = [[ProcessDetailRightViewController alloc] init];
    _processDetailRightNav = [[UINavigationController alloc] initWithRootViewController:_processDetailRightViewController];
    [_processDetailRightViewController setProcessDetailView:_processDetailViewController];
    
    [_processDetailViewController setRootView:self];

    [self setCenterViewController:_processDetailNav];
    [self setRightViewController:_processDetailRightNav];
}

- (void)showInFile{
    _fileViewController = [[FileViewController alloc] init];
    _fileViewController.fileState = FileStateNormal;
    _fileViewController.fileOperation = FileOperationNormal;
    _fileRightViewController = [[FileRightViewController alloc] init];
    
    
    _fileNav = [[UINavigationController alloc] initWithRootViewController:_fileViewController];
    
    _fileRightNav = [[UINavigationController alloc] initWithRootViewController:_fileRightViewController];
    
    [self setCenterViewController:_fileNav];
    [self setRightViewController:_fileRightNav];
    [_fileRightViewController setFileView:_fileViewController];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)showCooperation{
    _cooperationViewController = [[CooperationViewController alloc] init];
    
    _cooperationRightViewController = [[CooperationRightViewController alloc] init];
    
    [_cooperationRightViewController setCoopretaionView:_cooperationViewController];
    [_cooperationViewController setRootView:self];
    
    _cooperationNav = [[UINavigationController alloc] initWithRootViewController:_cooperationViewController];
    _cooperationRightNav = [[UINavigationController alloc] initWithRootViewController:_cooperationRightViewController];
    
    [self setCenterViewController:_cooperationNav];
    [self setRightViewController:_cooperationRightNav];
}

- (void)showInHome{
    
    
    [self setCenterViewController:_homeViewController];
    [self setLeftViewController:_setUpNav];
}

- (void)showInClientDetail{
    _clientDetailViewController = [[ClientDetailViewController alloc] init];
    _clientDetailRightViewController = [[ClientDetailRightViewController alloc] init];
    [_clientDetailRightViewController setClientDetailView:_clientDetailViewController];
    
    _clientDetailNav = [[UINavigationController alloc] initWithRootViewController:_clientDetailViewController];
    _clientDetailRightNav = [[UINavigationController alloc] initWithRootViewController:_clientDetailRightViewController];
    

    [self setCenterViewController:_clientDetailNav];
    [self setRightViewController:_clientDetailRightNav];

}

- (void)showInCase{
    _caseViewController = [[CaseViewController alloc] init];
    _caseViewController.caseStatuts = CaseStatutsNormal;
    _caseNav = [[UINavigationController alloc] initWithRootViewController:_caseViewController];

    _caseRightViewController = [[CaseRightViewController alloc] init];
    _caseRightViewController.viewType = ViewTypeCaseRight;
    _caseRightViewController.delegate = (id)_caseViewController;
    [_caseRightViewController setCenterView:_caseViewController];
    
    _caseRightNav = [[UINavigationController alloc] initWithRootViewController:_caseRightViewController];

    
    [self setCenterViewController:_caseNav];
    [self setRightViewController:_caseRightNav];
}


- (void)showInCaseDetail{
    _caseDetatilViewController = [[CaseDetatilViewController alloc] init];
    _caseDetailRightViewController = [[CaseDetailRightViewController alloc] init];
    
    [_caseDetailRightViewController setCaseDetailView:_caseDetatilViewController];
    [_caseDetatilViewController setRootView:self];
    
    _caseDetailNav = [[UINavigationController alloc] initWithRootViewController:_caseDetatilViewController];
    _caseDetailRightNav = [[UINavigationController alloc] initWithRootViewController:_caseDetailRightViewController];

    
    [self setCenterViewController:_caseDetailNav];
    [self setRightViewController:_caseDetailRightNav];
}

- (void)showInLog{
    _logViewController = [[LogViewController alloc] init];
    _logRightViewController = [[LogRightViewController alloc] init];
    _logNav = [[UINavigationController alloc] initWithRootViewController:_logViewController];
    _logRightNav = [[UINavigationController alloc] initWithRootViewController:_logRightViewController];
    [_logRightViewController setLogView:_logViewController];
    
    [self setCenterViewController:_logNav];
    [self setRightViewController:_logRightNav];

}



- (void)showInSchema{
    _schemaViewController = [[SchemaViewController alloc] init];
    _schemaNav = [[UINavigationController alloc] initWithRootViewController:_schemaViewController];
    
    _schemaRightViewController = [[SchemaRightViewController alloc] init];
    _schemaRightNav = [[UINavigationController alloc] initWithRootViewController:_schemaRightViewController];
    [_schemaRightViewController setSchemaView:_schemaViewController];
    
    [self setCenterViewController:_schemaNav];
    [self setRightViewController:_schemaRightNav];
}

- (void)showInLawRule{
    _lawRuleViewController = [[LawRuleViewController alloc] init];
    _lawRuleRightViewController = [[LawRuleRightViewController alloc] init];
    [_lawRuleRightViewController setLawRuleView:_lawRuleViewController];
    
    _lawRuleNav = [[UINavigationController alloc] initWithRootViewController:_lawRuleViewController];
    _lawRuleRightNav = [[UINavigationController alloc] initWithRootViewController:_lawRuleRightViewController];
    
    [self setCenterViewController:_lawRuleNav];
    [self setRightViewController:_lawRuleRightNav];
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    if (_isChangeStatusBar) {
//        return UIStatusBarStyleLightContent;
//    }
//    return UIStatusBarStyleDefault;
//    
//}

@end
