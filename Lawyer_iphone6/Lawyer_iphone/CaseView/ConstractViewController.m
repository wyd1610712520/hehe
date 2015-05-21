//
//  ConstractViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-2-25.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ConstractViewController.h"

#import "HttpClient.h"
#import "ClientDocCell.h"

#import "DocumentViewController.h"

@interface ConstractViewController ()<RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    
    ClientDocCell *_clientDocCell;
}

@end

@implementation ConstractViewController

@synthesize caseID = _caseID;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"案件合同" color:nil];
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 70;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    [_httpClient startRequest:[self requestParam]];
    
    _clientDocCell = [[ClientDocCell alloc] init];
}

- (NSDictionary*)requestParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_caseID,@"caseID",@"",@"classID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"casegetApprovedocList",@"requestKey", nil];
    return param;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClientDocCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientDocCell"];
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:@"ClientDocCell" owner:self options:nil];
        cell = _clientDocCell;
        // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    cell.titleLabel.text = [item objectForKey:@"do_title"];
    //cell.nameLabel.text = [item objectForKey:@"do_create_date"];
    cell.dateLabel.text = [item objectForKey:@"do_create_date"];
    
    NSString *type = [item objectForKey:@"do_file_type"];
    cell.logoImageView.image = [self.view checkResourceType:type];

    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    DocumentViewController *documentViewController = [[DocumentViewController alloc] init];
    documentViewController.pathString = [item objectForKey:@"do_url"];
    documentViewController.type = [item objectForKey:@"do_file_type"];
    documentViewController.name = [item objectForKey:@"do_title"];
    
    [self.navigationController pushViewController:documentViewController animated:YES];
}

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    [self clearTableData];
    for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
        [self.tableDatas addObject:item];
    }
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}


@end
