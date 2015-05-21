//
//  CaseDetatilViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-3.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CaseDetatilViewController.h"

#import "HttpClient.h"

#import "CaseDetailRightViewController.h"

#import "CaseDescribeViewController.h"

#import "RootViewController.h"

#import "CommomClient.h"

#import "AlertView.h"

#import "RootViewController.h"

#import "ResearchViewController.h"

#import "FileViewController.h"

#import "ConflictViewController.h"
#import "ConstractViewController.h"

@interface CaseDetatilViewController ()<AlertViewDelegate,RequestManagerDelegate,UIAlertViewDelegate>{
    HttpClient *_detailHttpClient;
    
    NSString *_caseId;
    
    CaseDetailRightViewController *_caseDetailRightViewController;
    CaseDescribeViewController *_caseDescribeViewController;
    
    RootViewController *_rootViewController;
    
    NSString *_clientId;
    
    HttpClient *_favoriteHttpClient;
    HttpClient *_cancelHttpClient;
    
    UIButton *_favoriteButton;
    
    HttpClient *_audtiHttpClient;
    
    AlertView *_alertView;
    
    RootViewController *_rootProcessViewController;
    ResearchViewController *_researchViewController;
    
    NSDictionary *_Record;
    
    FileViewController *_fileViewController;
    
    RootViewController *_fileRootViewController;
    
    RootViewController *_logRootViewController;
    
    ConflictViewController *_conflictViewController;
    ConstractViewController *_constractViewController;
}

@end

@implementation CaseDetatilViewController


@synthesize caseStatus=  _caseStatus;

@synthesize currentView = _currentView;
@synthesize caseView = _caseView;
@synthesize auditCaseView = _auditCaseView;
@synthesize operationView = _operationView;

@synthesize caseNameLabel = _caseNameLabel;
@synthesize caseDateLabel = _caseDateLabel;
@synthesize officeLabel = _officeLabel;
@synthesize caseDescribeLabel = _caseDescribeLabel;
@synthesize caseCategoryLabel = _caseCategoryLabel;
@synthesize companyLabel = _companyLabel;
@synthesize companyTypeLabel = _companyTypeLabel;
@synthesize instrueLabel = _instrueLabel;
@synthesize languageLabel = _languageLabel;
@synthesize foreignLabel = _foreignLabel;
@synthesize lawyerLabel = _lawyerLabel;
@synthesize arrangeLabel = _arrangeLabel;

@synthesize avatorView = _avatorView;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    if (_auditCaseSate == AuditCaseState) {
//        [self setTitle:[Utility localizedStringWithTitle:@"case_nav_detail_title"] color:nil];
//        
//        [_auditCaseView removeFromSuperview];
//        [_currentView addSubview:_caseView];
//
//        _detailHttpClient = [[HttpClient alloc] init];
//        _detailHttpClient.delegate = self;
//       //[_detailHttpClient startRequestAtCaseDetail:[self getCaseInfo:_caseId]];
//        [_detailHttpClient startReqeust:[self getCaseInfo:_caseId]];
//    }
//    else if (_auditCaseSate == AuditCaseSateDone) {
//        [_caseView removeFromSuperview];
//        [_currentView addSubview:_auditCaseView];
//        [_operationView removeFromSuperview];
//    }
//    else if (_auditCaseSate == AuditCaseSateUndone){
//        [_caseView removeFromSuperview];
//        [_currentView addSubview:_auditCaseView];
//        _operationView.frame = CGRectMake(0, _auditCaseView.frame.size.height + _auditCaseView.frame.origin.y, self.view.frame.size.width, 50);
//        [_currentView addSubview:_operationView];
//    }
}


- (IBAction)touchDescirbeEvnet:(id)sender{
    _caseDescribeViewController = [[CaseDescribeViewController alloc] init];
    _caseDescribeViewController.content = _caseDescribeLabel.text;
    [self.navigationController pushViewController:_caseDescribeViewController animated:YES];
}

- (void)setCaseId:(NSString*)caseId{
    _caseId = caseId;
}

- (void)setRootView:(RootViewController*)rootViewController{
    _rootViewController = rootViewController;
}

- (IBAction)touchClientDetailEvnet:(id)sender{
    _rootViewController = [[RootViewController alloc] init];
    
    [self presentViewController:_rootViewController animated:YES completion:nil];
    [_rootViewController showInClientDetail];
    _rootViewController.clientDetailViewController.clientId = _clientId;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    
    
    
    [self setTitle:@"案件详情" color:nil];
    
    
    
    _detailHttpClient = [[HttpClient alloc] init];
    _detailHttpClient.delegate = self;
    [_detailHttpClient startRequest:[self getCaseInfo:_caseId]];
    
    _favoriteHttpClient = [[HttpClient alloc] init];
    _favoriteHttpClient.delegate = self;
    
    _cancelHttpClient = [[HttpClient alloc] init];
    _cancelHttpClient.delegate = self;

   
    if (_caseStatus == CaseStatusNormal) {
        NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"favorite_normal.png"],@"image",[UIImage imageNamed:@"favorite_selected.png"],@"selectedImage", nil];
        NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
        
        NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
        _favoriteButton = [self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];
        
        _sureView.hidden = YES;
        
        CGRect frame = _caseView.frame;
        frame.size.width = [UIScreen mainScreen].bounds.size.width;
        _caseView.frame = frame;
        [_currentView addSubview:_caseView];

    }
    else if (_caseStatus == CaseStatusAudit){
        _sureView.hidden = NO;
        
        
        _audtiHttpClient = [[HttpClient alloc] init];
        _audtiHttpClient.delegate = self;
        
        CGRect frame1 = _auditCaseView.frame;
        frame1.size.width = [UIScreen mainScreen].bounds.size.width;
        _auditCaseView.frame = frame1;
        
        [_caseView removeFromSuperview];
        [_currentView addSubview:_auditCaseView];
        
        if (!_isDone) {
            [_sureView removeFromSuperview];
        }

    }
}

- (IBAction)touchConflictEvent:(id)sender{
    _conflictViewController = [[ConflictViewController alloc] init];
    _conflictViewController.caseID = _caseId;
    [self.navigationController pushViewController:_conflictViewController animated:YES];
}

- (IBAction)touchContractEvent:(id)sender{
    _constractViewController = [[ConstractViewController alloc] init];
    _constractViewController.caseID = _caseId;
    [self.navigationController pushViewController:_constractViewController animated:YES];
}

- (IBAction)touchRejuectEvent:(id)sender{
    _alertView = [[AlertView alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 155)];
    _alertView.delegate = self;
    [_alertView showTextView:@""];
    
    //_alertView.textField.placeholder = @"请输入拒绝原因";
    _alertView.tipLabel.text = @"请输入拒绝原因";
    _alertView.alertButtonType = AlertButtonTwo;
    
    [self.view addSubview:_alertView];
}

- (void)alertView:(AlertView *)alertView field:(NSString *)text{
    NSString *memo = @"";
    if (text.length > 0) {
        memo = text;
        [_audtiHttpClient startRequest:[self caseParan:@"1" desc:memo]];
    }
    else{
        [self showHUDWithTextOnly:@"请输入拒绝原因"];
    }
    
}

- (IBAction)touchSureEvent:(id)sender{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要通过吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [_audtiHttpClient startRequest:[self caseParan:@"0" desc:@""]];
    }
}

- (NSDictionary*)caseParan:(NSString*)type desc:(NSString*)desc{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:type,@"type",
                            _caseId,@"caseID",
                            [[CommomClient sharedInstance] getAccount],@"userID",
                            desc,@"requestKey",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"caseapprove",@"requestKey", nil];
    return param;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_caseDetailRightViewController.view removeFromSuperview];
}

- (void)touchNavRight:(UIButton*)button{
    if (button.tag == 0) {
        if (button.selected) {
            [_cancelHttpClient startRequest:[self cancelFavoriteParan]];
        }
        else{
            [_favoriteHttpClient startRequest:[self favoriteParan]];
            
        }
    }
    else if (button.tag == 1){
//        [self showRight];
        _rootViewController.caseDetailRightViewController.record = _Record;
        _rootViewController.caseDetailRightViewController.caseid = _caseId;
        [self.revealContainer showRight];
    }
    
}

- (NSDictionary*)favoriteParan{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"case",@"collect_type",
                         @"案件",@"collect_item_type",
                         _caseId,@"collect_key_id",
                         [[CommomClient sharedInstance] getAccount],@"userID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"addCollection",@"requestKey",
                           dic,@"fields",
                           nil];
    return param;
}

- (NSDictionary*)cancelFavoriteParan{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _caseId,@"collect_key_id",
                         [[CommomClient sharedInstance] getAccount],@"userID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"deleteCollection",@"requestKey",
                           dic,@"fields",
                           nil];
    return param;
}

- (NSDictionary*)getCaseInfo:(NSString*)caseID{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         caseID, @"caseID",
                         @"iphone",@"requestfrom",
                         nil];
    NSDictionary *fieldsDic = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"caseGetBasic",@"requestKey",
                               dic,@"fields",
                               nil];
    
    return fieldsDic;
    
}

- (NSString*)getDate:(NSString*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
    NSDate *dates = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"YYYY-MM-DD";
    
    NSString *dateString = [dateFormatter stringFromDate:dates];
    return dateString;
}


#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    if (_detailHttpClient == request) {
        NSDictionary *record = (NSDictionary*)[dic objectForKey:@"record"];
        _Record = record;
        _clientId = [record objectForKey:@"cl_client_id"];
        
        _caseNameLabel.text = [record objectForKey:@"ca_case_name"];
        _caseDateLabel.text = [NSString stringWithFormat:@"立案日期：%@",[self getDate:[record objectForKey:@"ca_case_date"]]];
        
        if (!_isDone) {
           //
            [_sureView removeFromSuperview];
        }
        
        if (_caseStatus == CaseStatusNormal) {
            _caseIdLabel.text = [record objectForKey:@"ca_case_id"];
        }
        
        _officeLabel.text = [NSString stringWithFormat:@"办公室：%@",[record objectForKey:@"ca_area"]];
        _caseDescribeLabel.text = [record objectForKey:@"ca_description"];
        _caseCategoryLabel.text = [NSString stringWithFormat:@"案件类别：%@",[record objectForKey:@"ca_categoryname"]];
        _companyLabel.text = [record objectForKey:@"cl_client_name"];
        
        
        if ([[record objectForKey:@"ca_iscollect"] isEqualToString:@"0"]) {
            _favoriteButton.selected = NO;
        }
        else{
            _favoriteButton.selected = YES;
        }
        
        if ([[record objectForKey:@"cl_type_name"] length] == 0){
            _companyTypeLabel.text = [NSString stringWithFormat:@"类型：无"];
        }
        else{
            _companyTypeLabel.text = [NSString stringWithFormat:@"类型：%@",[record objectForKey:@"cl_type_name"]];
        }
        
        if ([[record objectForKey:@"cl_hangye_name"] length] == 0){
            _instrueLabel.text = [NSString stringWithFormat:@"行业：无"];
        }
        else{
            _instrueLabel.text = [NSString stringWithFormat:@"行业：%@",[record objectForKey:@"cl_hangye_name"]];
        }
        
        
        
        _languageLabel.text = [record objectForKey:@"ca_language"];
        
        
        if ([[record objectForKey:@"ca_is_foreign"] isEqualToString:@"0"]) {
            _foreignLabel.text = @"否";
        }
        else{
            _foreignLabel.text = @"是";
        }
        
        if ([[record objectForKey:@"ca_is_help"] isEqualToString:@"0"]) {
            _lawyerLabel.text = @"否";
        }
        else{
            _lawyerLabel.text = @"是";
        }
        
//        if ([[record objectForKey:@"ca_iscollect"] isEqualToString:@"0"]) {
//            _arrangeLabel.text = @"否";
//        }
//        else{
//            _arrangeLabel.text = @"是";
//        }
        _arrangeLabel.text= [record objectForKey:@"ca_alloc_style"];
        
        
        if ([[record objectForKey:@"lawyer_list"] count] > 0 ) {
            _avatorView.nameId = [record objectForKey:@"ca_manager"];
            [_avatorView setAvators:[record objectForKey:@"lawyer_list"]];
        }
        
        
    }
    else if (request == _favoriteHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"收藏成功"];
            _favoriteButton.selected = YES;
        }
        else{
            [self showHUDWithTextOnly:@"收藏失败"];
            _favoriteButton.selected = NO;
        }
    }
    else if (request == _cancelHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"取消收藏成功"];
            _favoriteButton.selected = NO;
        }
        else{
            [self showHUDWithTextOnly:@"取消收藏失败"];
            _favoriteButton.selected = YES;
        }
    }
    else if (request == _audtiHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"审核成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"审核失败"];
        }
    }
    
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

//FG2014BJ012
- (IBAction)touchCaseProcessEvent:(id)sender{
    _rootProcessViewController = [[RootViewController alloc] init];
    [self presentViewController:_rootProcessViewController animated:NO completion:nil];
    [_rootProcessViewController showInProcessDetail];
    _rootProcessViewController.processDetailViewController.caseID = _caseId;
}

- (IBAction)touchCaseSearchEvent:(id)sender{
    _researchViewController = [[ResearchViewController alloc] init];
    _researchViewController.record = _Record;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_researchViewController];
    [self presentViewController:nav animated:NO completion:nil];
}

- (IBAction)touchCaseLogEvent:(id)sender{
    _logRootViewController = [[RootViewController alloc] init];
    [self presentViewController:_logRootViewController animated:NO completion:nil];
    [_logRootViewController showInLog];
    _logRootViewController.logViewController.caseId = _caseId;
}

- (IBAction)touchCasedocEvent:(id)sender{
    _fileRootViewController = [[RootViewController alloc] init];
    
    NSString *string = [[CommomClient sharedInstance] getValueFromUserInfo:@"docClassSplit"];
    

   NSString *clssid = [NSString stringWithFormat:@"M4%@%@",string,_caseId];
    
    [self presentViewController:_fileRootViewController animated:NO completion:nil];
    [_fileRootViewController showInFile];
    _fileRootViewController.fileViewController.caseClassId =clssid;
    _fileRootViewController.fileViewController.fileOperation = FileOperationRead;
    _fileRootViewController.fileViewController.titleStr = @"";
}



@end
