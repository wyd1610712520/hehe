//
//  VisiteAndCaseViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "VisiteAndCaseViewController.h"

#import "ClientVisiteCell.h"
#import "CaseCell.h"
#import "HttpClient.h"
#import "UIView+Utility.h"

#import "RootViewController.h"

@interface VisiteAndCaseViewController ()<UITableViewDataSource,UITableViewDelegate,RequestManagerDelegate>{
    HttpClient *_visitHttpClient;
    HttpClient *_casehttpClient;
    
    RootViewController *_rootViewController;
}

@end

@implementation VisiteAndCaseViewController

@synthesize visiteAndCaseType = _visiteAndCaseType;

@synthesize clientId = _clientId;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    if (_visiteAndCaseType == VisiteType) {
        [self setTitle:@"拜访记录" color:nil];
        
        [_visitHttpClient startRequest:[self requestParam]];
        
        UINib *cellNib = [UINib nibWithNibName:@"ClientVisiteCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ClientVisiteCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else if (_visiteAndCaseType == CaseStatType){
        [self setTitle:@"相关案件" color:nil];
        
        UINib *cellNib = [UINib nibWithNibName:@"CaseCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CaseCell"];
        
        [_casehttpClient startRequest:[self requestCase]];
        
    }
}


- (NSDictionary*)requestCase{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"",@"cl_client_name",
                            _clientId,@"ca_client_id",
                            @"",@"ca_category",
                            @"",@"ca_case_name",
                            @"",@"ca_case_id",
                            @"",@"ca_kind_type",
                            @"",@"ca_area",
                            @"",@"ca_dept_id",
                            @"",@"ca_manager",
                            @"",@"ca_lawyer",
                            @"",@"ca_case_date_b",
                            @"",@"ca_case_date_e",
                            @"",@"ca_status",
                            @"",@"last_request_date", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"casequery",@"requestKey",@"1",@"currentPage",@"20000",@"pageSize",fields,@"fields", nil];
    return param;
}
         

- (NSDictionary*)requestParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_clientId,@"clientID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"clientgetDetailVisit",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    
    _visitHttpClient = [[HttpClient alloc] init];
    _visitHttpClient.delegate = self;
    
    _casehttpClient = [[HttpClient alloc] init];
    _casehttpClient.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_visiteAndCaseType == VisiteType) {
        ClientVisiteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientVisiteCell"];
        
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        cell.titleLabel.text = [item objectForKey:@"cvr_title"];
        cell.nameLabel.text = [item objectForKey:@"cvr_visitor"];
        cell.timeLabel.text = [self.view getPerTime:[item objectForKey:@"cvr_start_date"]];
        cell.contentLabel.text = [item objectForKey:@"cvr_description"];
        cell.typeLabel.text = [NSString stringWithFormat:@"拜访类型：%@",[item objectForKey:@"cvr_link_type_name"]];
        return cell;
    }
    else if (_visiteAndCaseType == CaseStatType){
        CaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CaseCell"];
        
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        cell.titleLabel.text = [item objectForKey:@"ca_case_name"];
        cell.caseLabel.text = [NSString stringWithFormat:@"案件编号:%@",[item objectForKey:@"ca_case_id"]];
        cell.clientLabel.text = [NSString stringWithFormat:@"客户:%@",[item objectForKey:@"cl_client_name"]];
        cell.categoryLabel.text = [NSString stringWithFormat:@"案件类别:%@",[item objectForKey:@"ca_category"]];
        cell.chargeLabel.text = [NSString stringWithFormat:@"负责人:%@",[item objectForKey:@"ca_manager_name"]];
        
        cell.dateLabel.text = [NSString stringWithFormat:@"立案日期:%@",[self.view getPerTime:[item objectForKey:@"ca_case_date"]]];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_visiteAndCaseType == VisiteType) {
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        return  [ClientVisiteCell heightForRow:[item objectForKey:@"cvr_description"]];
        
    }
    else if (_visiteAndCaseType == CaseStatType){
        return 128;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_visiteAndCaseType == VisiteType) {
        
    }
    else if (_visiteAndCaseType == CaseStatType){
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        _rootViewController = [[RootViewController alloc] init];
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:_rootViewController animated:YES completion:nil];
        [_rootViewController showInCaseDetail];
        [_rootViewController.caseDetatilViewController setCaseId:[item objectForKey:@"ca_case_id"]];
        
    }
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    [self clearTableData];
    if (request == _visitHttpClient) {
        for (NSDictionary *mapping in [result objectForKey:@"record_list"]) {
            [self.tableDatas addObject:mapping];
        }
        
    }
    else if (request == _casehttpClient){
        
        for (NSDictionary *caseMapping in [result objectForKey:@"record_list"]) {
            [self.tableDatas addObject:caseMapping];
        }

    }
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}



@end
