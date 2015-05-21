//
//  ConflictViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-2-24.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ConflictViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"

@interface ConflictViewController ()<RequestManagerDelegate>{
    HttpClient *_httpClient;
}

@end

@implementation ConflictViewController

@synthesize caseID = _caseID;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"冲突检索信息" color:nil];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    [_httpClient startRequest:[self requestParam]];
    
    
}

- (NSDictionary*)requestParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_caseID,@"caseID",
                            [[CommomClient sharedInstance] getAccount],@"userID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"casegetApproveConflict",@"requestKey",@"1",@"currentPage",@"100",@"pageSize", nil];
    return param;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}


- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    _nameLabel.text = [dic objectForKey:@"ca_conflictor"];
    _dateLabel.text = [dic objectForKey:@"ca_conflictDate"];
    _typeLabel.text = [dic objectForKey:@"ca_conflictType"];
    _resultLabel.text = [dic objectForKey:@"ca_conflictResult"];

}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

/*
 {
 "ca_conflictDate" = "2015-02-09 21:40:18";
 "ca_conflictResult" = "\U5df2\U7ecf\U68c0\U7d22\Uff0c\U6709\U51b2\U7a81";
 "ca_conflictType" = "";
 "ca_conflictor" = "\U9093\U5929\U7136";
 currentCount = 0;
 currentPage = 1;
 mgid = true;
 msg = "";
 pageCount = 0;
 pageSize = 100;
 recordCount = 0;
 "record_list" =     (
 );
 responsetime = "2015-02-25 10:23:19";
 }
 */


@end
