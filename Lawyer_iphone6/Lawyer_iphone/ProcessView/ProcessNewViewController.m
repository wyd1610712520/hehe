//
//  ProcessNewViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-18.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProcessNewViewController.h"

#import "CaseViewController.h"

#import "ProcessSelectedViewController.h"

#import "RootViewController.h"

#import "ModuleViewController.h"

#import "HttpClient.h"
#import "CommomClient.h"

#import "GeneralViewController.h"

#import "ProcessModuleViewController.h"
#import "ModulePreviewViewController.h"
#import "AlertView.h"

@interface ProcessNewViewController ()<UITextFieldDelegate,GeneralViewControllerDelegate,AlertViewDelegate,CaseViewControllerDelegate,RequestManagerDelegate>{
    CaseViewController *_caseViewController;
    ProcessSelectedViewController *_processSelectedViewController;
    
    RootViewController *_rootViewController;
    
    ModuleViewController *_moduleViewController;
    NSDictionary *_recordCase;
    NSDictionary *_record;
    
    HttpClient *_httpClient;
    
    GeneralViewController *_generalViewController;
    NSDictionary *_generalDic;
    
    ProcessModuleViewController *_processModuleViewController;
    
    HttpClient *_checkHttpClient;
    
    AlertView *_fileAlertView;
}

@end

@implementation ProcessNewViewController

@synthesize firstField = _firstField;
@synthesize secondField = _secondField;
@synthesize thirdField = _thirdField;
@synthesize foruthField = _foruthField;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:[Utility localizedStringWithTitle:@"process_new_nav_title"] color:nil];
}

- (IBAction)touchModuleEvent:(id)sender{
//    _moduleViewController = [[ModuleViewController alloc] init];
//    [self.navigationController pushViewController:_moduleViewController animated:YES];
    _checkHttpClient = [[HttpClient alloc] init];
    _checkHttpClient.delegate = self;
    [_checkHttpClient startRequest:[self checkParam]];
    
    //[self.navigationController pushViewController:_generalViewController animated:YES];
}

- (NSDictionary*)checkParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getAccount],@"userID",[_recordCase objectForKey:@"ca_case_id"],@"caseID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"caseProcessView",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)general:(GeneralViewController *)generalViewController data:(NSDictionary *)data{
    _generalDic = data;
    [_foruthField setTitle:[_generalDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
    [_foruthField setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesModule:) name:ModulePost object:nil];
    
    
    _generalViewController = [[GeneralViewController alloc] init];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"gc_id",@"按模板创建",@"gc_name", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"gc_id",@"自定义进程",@"gc_name", nil];
    NSArray *generalArr = [NSArray arrayWithObjects:dic1,dic2, nil];
    _generalViewController.datas = generalArr;
    _generalViewController.delegate = self;
    
    
//    _caseViewController = [[CaseViewController alloc] init];
//    _caseViewController.auditCaseSate = AuditCaseState;
//    _caseViewController.caseType = CaseTypeProcess;
//    _caseViewController.delegate = self;
//    
    _processSelectedViewController = [[ProcessSelectedViewController alloc] init];
    _processSelectedViewController.processSelect = ProcessSelectProcess;
    
    _processModuleViewController = [[ProcessModuleViewController alloc] init];
    
}

- (IBAction)touchSureEvent:(id)sender{
//    _httpClient = [[HttpClient alloc] init];
//    _httpClient.delegate = self;
//    [_httpClient startRequest:[self requestParam]];
    
    if ([_recordCase count] == 0) {
        [self showHUDWithTextOnly:@"请选择案件!"];
        return;
    }
    
    if ([_generalDic count] == 0) {
        [self showHUDWithTextOnly:@"请设置进程!"];
        return;
    }
    
    
    
    if ([[_generalDic objectForKey:@"gc_name"] isEqualToString:@"按模板创建"]) {
        _moduleViewController = [[ModuleViewController alloc] init];
        _moduleViewController.caseID = [_recordCase objectForKey:@"ca_case_id"];
        
        [self.navigationController pushViewController:_moduleViewController animated:YES];

       // [self.navigationController pushViewController:_processModuleViewController animated:YES];
    }
    else if ([[_generalDic objectForKey:@"gc_name"] isEqualToString:@"自定义进程"]){
        ModulePreviewViewController *modulePreviewViewController = [[ModulePreviewViewController alloc] init];
        modulePreviewViewController.moduleType = ModuleTypeCustom;
        modulePreviewViewController.record = _recordCase;
        modulePreviewViewController.caseID = [_recordCase objectForKey:@"ca_case_id"];
        [self.navigationController pushViewController:modulePreviewViewController animated:YES];
    }
}

- (NSDictionary*)requestParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[_recordCase objectForKey:@"ca_case_id"],@"ywcp_case_id",
                            @"",@"ywcp_id",
                            [_record objectForKey:@"cptc_description"],@"ywcp_title",
                            @"",@"ywcp_type",
                            [_record objectForKey:@"cptc_create_date"],@"ywcp_date",
                            @"",@"ywcp_end_date",
                            [_record objectForKey:@"cptc_memo"],@"ywcp_detail",
                            @"0",@"ywcp_complete",
                            [_record objectForKey:@"cptc_creator"],@"ywcp_empl_id",
                            @"",@"ywcp_group",
                            @"",@"ywcp_files",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"CaseProcessItemEdit",@"requestKey",fields,@"fields", nil];
    return param;
}

#pragma mark - CaseViewControllerDelegate

- (void)returnDataToProcess:(NSDictionary *)item{
    if (item) {
        _recordCase = item;
        _firstField.text = [item objectForKey:@"ca_case_name"];
        _secondField.text = [item objectForKey:@"cl_client_name"];
        _thirdField.text = [self.view getPerTime:[item objectForKey:@"ca_case_date"]];
        
        [_foruthField setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)receivesModule:(NSNotification*)notification{
    NSDictionary *item = (NSDictionary*)[notification object];
    _record = item;
    [_foruthField setTitle:[_record objectForKey:@"cptc_description"] forState:UIControlStateNormal];
    [_foruthField setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _firstField) {
        _rootViewController = [[RootViewController alloc] init];
        [self presentViewController:_rootViewController animated:YES completion:nil];
        [_rootViewController showInCase];
        _rootViewController.caseViewController.delegate = self;
        _rootViewController.caseViewController.caseStatuts =CaseStatutsSelectable;
        return NO;
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
    
}



- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    
    NSDictionary *dic = (NSDictionary*)responseObject;
    
    if (request == _httpClient) {
//        [self.navigationController popViewControllerAnimated:YES];
//        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
//            
//            [self showHUDWithTextOnly:@"创建成功"];
//        }
//        else{
//            // [self showHUDWithTextOnly:@"创建失败"];
//        }
    }
    else if (request == _checkHttpClient){
        NSArray *list = (NSArray*)[dic objectForKey:@"record_list"];
        if (list.count > 0) {
            _fileAlertView = [[AlertView alloc] initWithFrame:CGRectMake(15, 120, self.view.frame.size.width-30, 125)];
            [self.view addSubview:_fileAlertView];
            _fileAlertView.delegate = self;
            _fileAlertView.textField = nil;
            [_fileAlertView setAlertButtonType:AlertButtonTwo];
            [_fileAlertView.tipLabel setText:@"案件已存在案件进程，是否查看？"];
            [_fileAlertView.sureButton setTitle:@"查看" forState:UIControlStateNormal];
            [self.view bringSubviewToFront:_fileAlertView];

        }
        else{
            [self.navigationController pushViewController:_generalViewController animated:YES];
        }
        
    }
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

- (void)alertView:(AlertView*)AlertView field:(NSString*)text{
    if (AlertView == _fileAlertView){
        _rootViewController = [[RootViewController alloc] init];
        [self presentViewController:_rootViewController animated:NO completion:nil];
        [_rootViewController showInProcessDetail];
        _rootViewController.processDetailViewController.caseID = [_recordCase objectForKey:@"ca_case_id"];
    }
    
}

/*
 {
 "cptc_category" = FG;
 "cptc_category_name" = "\U3010\U975e\U8bc9\U3011\U5e38\U5e74\U6cd5\U5f8b\U987e\U95ee";
 "cptc_create_date" = "2014-09-19";
 "cptc_creator" = "\U9093\U5929\U7136";
 "cptc_description" = dfsd;
 "cptc_emp_name" = "\U9093\U5929\U7136";
 "cptc_id" = CPTC00000031;
 "cptc_is_often" = 0;
 "cptc_is_public" = 1;
 "cptc_itemcnt" = 4;
 "cptc_kindtype" = "";
 "cptc_kindtype_name" = "";
 "cptc_memo" = fdsfsdfdsfsdfsdfsdf;
 }

 */

@end
