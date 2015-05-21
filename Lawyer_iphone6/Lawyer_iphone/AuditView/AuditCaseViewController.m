//
//  AuditCaseViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "AuditCaseViewController.h"

#import "RootViewController.h"

#import "HttpClient.h"

#import "CaseCell.h"

#import "CaseDetatilViewController.h"

@interface AuditCaseViewController ()<RequestManagerDelegate,AuditCaseRightViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>{
    RootViewController *_rootViewController;
    
    HttpClient *_httpClient;
    
    NSString *_caseName;
    NSString *_caseId;
    NSString *_clientName;
    NSString *_caseCategory;
    NSString *_caseCharge;
    NSString *_startTime;
    NSString *_endTime;
    
    
    NSString *_searchCaseName;
    NSString *_searchCaseId;
    NSString *_searchClientName;
    NSString *_searchCategory;
    NSString *_searchCharge;
    
    CaseDetatilViewController *_caseDetatilViewController;
    
    UILabel *_tipLabel;
}

@end

@implementation AuditCaseViewController

@synthesize auditCaseState = _auditCaseState;

- (void)setRootView:(RootViewController*)rootViewController{
    _rootViewController = rootViewController;
}

- (void)touchRightEvent{
    [self.revealContainer showRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setRightButton:nil title:@"筛选" target:self action:@selector(touchRightEvent)];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _rootViewController.auditCaseRightViewController.delegate = self;
    
    _caseName = @"";
    _caseId = @"";
    _clientName = @"";
    _caseCategory = @"";
    _caseCharge = @"";
    _startTime = @"";
    _endTime = @"";
    
    _searchCaseName = @"";
    _searchCaseId = @"";
    _searchClientName = @"";
    _searchCategory = @"";
    _searchCharge = @"";
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 110;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *cellNib = [UINib nibWithNibName:@"CaseCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CaseCell"];

    
    _tipLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    _tipLabel.backgroundColor = [UIColor whiteColor];
    _tipLabel.textColor = [UIColor blackColor];
    _tipLabel.font = [UIFont systemFontOfSize:18];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.text = @"无相关数据";
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_auditCaseState == AuditCaseStateUndone) {
        [self setTitle:@"待审核案件" color:nil];
        [_httpClient startRequest:[self param:@"0"]];
    }
    else if (_auditCaseState == AuditCaseStateDone){
        [self setTitle:@"已审核案件" color:nil];
        [_httpClient startRequest:[self param:@"1"]];
    }
    
}

- (void)returnRedData:(NSString *)caseName
               caseId:(NSString *)caseId
           clientName:(NSString *)clientName
             category:(NSString *)category
               charge:(NSString *)charge{
    _searchCaseName = caseName;
    _searchCaseId = caseId;
    _searchCategory = category;
    _searchClientName = clientName;
    _searchCharge = charge;
}


- (void)returnData:(NSString*)caseName
            caseId:(NSString*)caseId
        clientName:(NSString*)clientName
      caseCategory:(NSString*)caseCategory
        caseCharge:(NSString*)caseCharge
         startTime:(NSString*)startTime
           endTime:(NSString*)endTime{
    if (caseName.length > 0) {
        _caseName = caseName;
    }
    else{
        _caseName = @"";
    }
    
    if (caseId.length > 0) {
        _caseId = caseId;
    }
    else{
        _caseId = @"";
    }
    
    if (clientName.length > 0) {
        _clientName = clientName;
    }
    else{
        _clientName = @"";
    }
    
    if (caseCategory.length > 0) {
        _caseCategory = caseCategory;
    }
    else{
        _caseCategory = @"";
    }
    
    if (caseCharge.length > 0) {
        _caseCharge = caseCharge;
    }
    else{
        _caseCharge = @"";
    }
    
    
    if (startTime.length > 0) {
        _startTime = startTime;
    }
    else{
        _startTime = @"";
    }
    
    if (caseName.length > 0) {
        _caseName = caseName;
    }
    else{
        _caseName = @"";
    }
    
    if (endTime.length > 0) {
        _endTime = endTime;
    }
    else{
        _endTime = @"";
    }
    
    if (_auditCaseState == AuditCaseStateUndone) {
        [_httpClient startRequest:[self param:@"0"]];
    }
    else if (_auditCaseState == AuditCaseStateDone){
        [_httpClient startRequest:[self param:@"1"]];
    }
}

- (NSDictionary*)param:(NSString*)status{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_clientName,@"cl_client_name",
                            @"",@"ca_client_id",
                            _caseCategory,@"ca_category",
                            _caseName,@"ca_case_name",
                            _caseId,@"ca_case_id",
                            @"",@"ca_kind_type",
                            @"",@"ca_area",
                            @"",@"ca_dept_id",
                            _caseCharge,@"ca_manager",
                            @"",@"ca_lawyer",
                            _endTime,@"ca_case_date_e",
                            _startTime,@"ca_case_date_b",
                            status,@"ca_status",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"casegetApproveList",@"requestKey",@"1",@"currentPage",@"1000",@"pageSize",fields,@"fields", nil];
    return param;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_auditCaseState == AuditCaseStateUndone) {
        return self.tableDatas.count;
    }
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_auditCaseState == AuditCaseStateUndone) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
        return datas.count;
    }
    else{
        return self.tableDatas.count;
    }
    return 0;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_auditCaseState == AuditCaseStateUndone) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        return [temDic objectForKey:@"time"];
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CaseCell"];
    
    NSDictionary *item = nil;
    if (_auditCaseState == AuditCaseStateUndone) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
        
        item = [datas objectAtIndex:indexPath.row];
    }
    else{
        item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
     }
    
    NSString *caseName = [[NSString stringWithFormat:@"%@",[item objectForKey:@"ca_case_name"]] lowercaseString];
    NSRange range = [caseName rangeOfString:_searchCaseName];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:caseName];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        cell.titleLabel.attributedText = caseString;
    }
    else{
        cell.titleLabel.text = caseName;
    }
    cell.topMargin.constant = -10;
    
//    NSString *caseID = [NSString stringWithFormat:@"案件编号:%@",[item objectForKey:@"ca_case_id"]];
//    NSRange caseIDRange = [caseID rangeOfString:_searchCaseId];
//    if (caseIDRange.location != NSNotFound) {
//        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:caseID];
//        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:caseIDRange];
//        cell.caseLabel.attributedText = caseString;
//    }
//    else{
//        cell.caseLabel.text = caseID;
//    }
//    
    NSString *clientName = [NSString stringWithFormat:@"客户:%@",[item objectForKey:@"cl_client_name"]];
    NSRange clientNRange = [clientName rangeOfString:_searchClientName];
    if (clientNRange.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:clientName];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:clientNRange];
        cell.clientLabel.attributedText = caseString;
    }
    else{
        cell.clientLabel.text = clientName;
        
    }
    
    NSString *categoryName = [NSString stringWithFormat:@"案件类别:%@",[item objectForKey:@"ca_category"]];
    NSRange categoryRange = [categoryName rangeOfString:_searchCategory];
    if (categoryRange.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:categoryName];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:categoryRange];
        cell.categoryLabel.attributedText = caseString;
    }
    else{
        cell.categoryLabel.text = categoryName;
    }

    
    NSString *chargeName = [NSString stringWithFormat:@"负责人:%@",[item objectForKey:@"ca_manager_name"]];
    NSRange chargeRange = [chargeName rangeOfString:_searchCharge];
    if (chargeRange.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:chargeName];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:chargeRange];
        cell.chargeLabel.attributedText = caseString;
    }
    else{
        cell.chargeLabel.text = chargeName;
    }
    
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _caseDetatilViewController = [[CaseDetatilViewController alloc] init];
    if (_auditCaseState == AuditCaseStateUndone) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
        
        NSDictionary *item = [datas objectAtIndex:indexPath.row];
        _caseDetatilViewController.caseStatus = CaseStatusAudit;
        [_caseDetatilViewController setCaseId:[item objectForKey:@"ca_case_id"]];
        _caseDetatilViewController.isDone = YES;
    }
    else{
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
       [_caseDetatilViewController setCaseId:[item objectForKey:@"ca_case_id"]];
        _caseDetatilViewController.isDone = NO;
        _caseDetatilViewController.caseStatus = CaseStatusAudit;
    }
    
    [self.navigationController pushViewController:_caseDetatilViewController animated:YES];
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    [self clearTableData];
    if ([[result objectForKey:@"record_list"] count] == 0) {
        [self.view addSubview:_tipLabel];
    }
    else{
        [_tipLabel removeFromSuperview];
    }
    
    if (_auditCaseState == AuditCaseStateUndone) {
        NSMutableArray *dates = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [result objectForKey:@"record_list"]) {
            NSString *time = [item objectForKey:@"ca_case_date"];
            time = [self.view getPerTime:time];
            if (![dates containsObject:time]) {
                if (time) {
                    [dates addObject:time];
                }
                
            }
        }
        
        NSArray *tempDate = [dates sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            
            NSDate *date1 = [formatter dateFromString:obj1];
            NSDate *date2 = [formatter dateFromString:obj2];
            
            return [date2 compare:date1];
        }];
        
        for (NSString *tmpTime in tempDate) {
            NSMutableArray *tempD = [[NSMutableArray alloc] init];
            for (NSDictionary *item in [result objectForKey:@"record_list"]) {
                NSString *time = [item objectForKey:@"ca_case_date"];
                time = [self.view getPerTime:time];
                
                if ([tmpTime isEqualToString:time]) {
                    [tempD addObject:item];
                }
            }
            NSDictionary *temDic = [NSDictionary dictionaryWithObjectsAndKeys:tmpTime,@"time",tempD,@"data", nil];
            [self.tableDatas addObject:temDic];
        }

    }
    else{
        for (NSDictionary *item in [result objectForKey:@"record_list"]) {
            [self.tableDatas addObject:item];
        }
    }
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}



@end
