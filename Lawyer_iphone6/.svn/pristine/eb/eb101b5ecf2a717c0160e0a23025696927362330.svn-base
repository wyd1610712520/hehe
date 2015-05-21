//
//  CollectViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-7.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CollectViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"
#import "NSString+Utility.h"
#import "CaseCell.h"
#import "ClientCell.h"
#import "ClientDocCell.h"
#import "NewsCell.h"
#import "RootViewController.h"
#import "CooperationCell.h"

#import "DocumentViewController.h"

#import "NewsDetailViewController.h"

#import "DocuDetailViewController.h"

#import "CooperationDetailViewController.h"

@interface CollectViewController ()<UITableViewDataSource,UITableViewDelegate,CustomSegmentDelegate,RequestManagerDelegate>{
    HttpClient *_caseHttpClient;
    
    NSInteger _tag;
    
    ClientDocCell *_clientDocCell;
    
    RootViewController *_rootViewController;
    
    DocumentViewController *documentViewController;
    NewsDetailViewController *_newsDetailViewController;
    CooperationDetailViewController *_cooperationDetailViewController;
}

@end

@implementation CollectViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self setTitle:@"我的收藏" color:nil];
    
    if (_tag == 0) {
        UINib *cellNib = [UINib nibWithNibName:@"CaseCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CaseCell"];
        
        [_caseHttpClient startRequest:[self requestParam:@"case" typeName:@"案件"]];
    }
    else if (_tag == 1){
        UINib *cellNib = [UINib nibWithNibName:@"ClientCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ClientCell"];
        
        [_caseHttpClient startRequest:[self requestParam:@"client" typeName:@"客户"]];
    }
    else if (_tag == 2){
        _clientDocCell = [[ClientDocCell alloc] init];
        [_caseHttpClient startRequest:[self requestParam:@"document" typeName:@"文书"]];
    }
    else if (_tag == 3){
        UINib *cellNib = [UINib nibWithNibName:@"CooperationCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CooperationCell"];
        
        [_caseHttpClient startRequest:[self requestParam:@"cooperation" typeName:@"合作"]];
    }
    else if (_tag == 4){
        UINib *cellNib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"NewsCell"];
        
        [_caseHttpClient startRequest:[self requestParam:@"bulletin" typeName:@"新闻"]];
    }
    else if (_tag == 5){
        UINib *cellNib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"NewsCell"];
        
        [_caseHttpClient startRequest:[self requestParam:@"bulletin" typeName:@"公告"]];
    }
}

- (NSDictionary *)requestParam:(NSString*)type typeName:(NSString*)typeName{
    NSString *_userID = [[CommomClient sharedInstance] getAccount];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _userID,@"userID",
                         type, @"collect_type",
                         typeName, @"collect_item_type",
                         @"" ,@"collect_key_id",
                         nil];
    NSDictionary *fieldsDic = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"collectionCenter",@"requestKey",
                               @"1",@"currentPage",
                               @"1000",@"pageSize",
                               dic,@"fields",
                               nil];
    
    return fieldsDic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setSegmentTitles:[NSArray arrayWithObjects:@"案件",@"客户",@"文书",@"合作",@"新闻",@"公告", nil] frame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    self.customSegment.segmentDelegate = self;
    self.customSegment.backgroundColor = [@"#E4F0FF" colorValue];

    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    _caseHttpClient = [[HttpClient alloc] init];
    _caseHttpClient.delegate = self;
    
    [_caseHttpClient startRequest:[self requestParam:@"case" typeName:@"案件"]];
    
    UINib *cellNib = [UINib nibWithNibName:@"CaseCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CaseCell"];
    
    
    
    
}

- (void)touchSegment:(CustomSegment*)customSegment tag:(NSInteger)tag{
    _tag = tag;
    if (tag == 0) {
        UINib *cellNib = [UINib nibWithNibName:@"CaseCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CaseCell"];
        
        [_caseHttpClient startRequest:[self requestParam:@"case" typeName:@"案件"]];
        
    }
    else if (tag == 1){
        UINib *cellNib = [UINib nibWithNibName:@"ClientCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ClientCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_caseHttpClient startRequest:[self requestParam:@"client" typeName:@"客户"]];
    }
    else if (tag == 2){
        _clientDocCell = [[ClientDocCell alloc] init];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_caseHttpClient startRequest:[self requestParam:@"document" typeName:@"文书"]];
    }
    else if (tag == 3){
        UINib *cellNib = [UINib nibWithNibName:@"CooperationCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CooperationCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_caseHttpClient startRequest:[self requestParam:@"cooperation" typeName:@"合作"]];
    }
    else if (tag == 4){
        UINib *cellNib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"NewsCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [_caseHttpClient startRequest:[self requestParam:@"bulletin" typeName:@"新闻"]];
    }
    else if (tag == 5){
        UINib *cellNib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"NewsCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [_caseHttpClient startRequest:[self requestParam:@"bulletin" typeName:@"公告"]];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_tag == 0) {
        CaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CaseCell"];
        
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        cell.titleLabel.text = [item objectForKey:@"ca_case_name"];
        cell.caseLabel.text = [NSString stringWithFormat:@"案件编号：%@",[item objectForKey:@"ec_key_id"]];
        cell.clientLabel.text = [NSString stringWithFormat:@"客户：%@",[item objectForKey:@"ca_client_name"]];
        cell.categoryLabel.text = [NSString stringWithFormat:@"案件类别：%@",[item objectForKey:@"ca_category_name"]];
        cell.chargeLabel.text = [NSString stringWithFormat:@"负责人：%@",[item objectForKey:@"ca_manager_name"]];
        cell.dateLabel.text = [NSString stringWithFormat:@"立案日期：%@",[item objectForKey:@"ca_case_date"]];
        return cell;
    }
    else if (_tag == 1){
        ClientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientCell"];
        
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        cell.titleLabel.text = [item objectForKey:@"cl_client_name"];
        cell.detailLabel.text = [NSString stringWithFormat:@"客户编号：%@",[item objectForKey:@"ec_key_id"]];
        
        return cell;
    }
    else if (_tag == 2){
        ClientDocCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientDocCell"];
        if (!cell) {
            [[NSBundle mainBundle] loadNibNamed:@"ClientDocCell" owner:self options:nil];
            cell = _clientDocCell;
           // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        cell.titleLabel.text = [item objectForKey:@"do_title"];
        cell.nameLabel.text = [item objectForKey:@"do_creator_name"];

        cell.widthLayout.constant = 100;
        cell.dateLabel.text = [item objectForKey:@"do_create_date"];
        
        NSString *type = [item objectForKey:@"do_file_type"];
        cell.logoImageView.image = [self.view checkResourceType:type];
        
        return cell;
    }
    else if (_tag == 3){
        CooperationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CooperationCell"];
        cell.backgroundColor = [@"#F9F9F9" colorValue];
        
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        cell.titleLabel.text = [item objectForKey:@"rdi_name"];
        cell.typeLabel.text = [item objectForKey:@"rdi_bigcategory_name"];
        cell.dateLabel.text = [NSString stringWithFormat:@"截止：%@",[item objectForKey:@"rdi_deadline"]];
        cell.addressLabel.text = [item objectForKey:@"rdi_regions_name"];
        cell.followerLabel.text = [item objectForKey:@"rdi_care_cnt"];
        cell.topLabel.text = [item objectForKey:@"rdi_zan_cnt"];
        [cell setState:[item objectForKey:@"rdi_type"]];
        
        cell.buttonView.hidden = YES;
        
        return cell;
    }
    else if (_tag == 4){
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
        
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        cell.titleLabel.text = [item objectForKey:@"blt_title"];
        cell.statusLabel.text = [item objectForKey:@"blt_type_name"];
        cell.timeLabel.text = [item objectForKey:@"blt_create_date"];
        
        
        
        return cell;

    }
    else if (_tag == 5){
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
        
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        cell.titleLabel.text = [item objectForKey:@"blt_title"];
        cell.statusLabel.text = [item objectForKey:@"blt_type_name"];
        cell.timeLabel.text = [item objectForKey:@"blt_create_date"];

        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_tag == 0) {
        return 128;
    }
    else if (_tag == 1){
        return 59;
    }
    else if (_tag == 2){
        return 70;
    }
    else if (_tag == 3){
        return 88;
    }
    else if (_tag == 4){
        return 60;
    }
    else if (_tag == 5){
        return 60;
    }

    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    if (_tag == 0) {
        _rootViewController = [[RootViewController alloc] init];
        [self presentViewController:_rootViewController animated:NO completion:nil];

        [_rootViewController showInCaseDetail];
        [_rootViewController.caseDetatilViewController setCaseId:[item objectForKey:@"ec_key_id"]];
    }
    else if (_tag == 1){
        _rootViewController = [[RootViewController alloc] init];
        [self presentViewController:_rootViewController animated:NO completion:nil];

        [_rootViewController showInClientDetail];
        _rootViewController.clientDetailViewController.clientId = [item objectForKey:@"ec_key_id"];
    }
    else if (_tag == 2){
        DocuDetailViewController *docuDetailViewController = [[DocuDetailViewController alloc] init];
        docuDetailViewController.papered = [item objectForKey:@"ec_key_id"];
        
        [self.navigationController pushViewController:docuDetailViewController animated:YES];
        
//        documentViewController = [[DocumentViewController alloc] init];
//        
//        documentViewController.pathString = [item objectForKey:@"do_doc_url"];
//        documentViewController.type = [item objectForKey:@"do_file_type"];
//        documentViewController.name = [item objectForKey:@"do_title"];
//        [self presentViewController:documentViewController animated:YES completion:nil];
    }
    else if (_tag == 3){
        _cooperationDetailViewController = [[CooperationDetailViewController alloc] init];
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        _cooperationDetailViewController.cooperationId = [item objectForKey:@"ec_key_id"];
        [self.navigationController pushViewController:_cooperationDetailViewController animated:YES];
    }
    else if (_tag == 4){
        _newsDetailViewController = [[NewsDetailViewController alloc] init];
        _newsDetailViewController.key = @"newsgetDetail";
        _newsDetailViewController.newType = NewTypeNews;
        _newsDetailViewController.titleID = [item objectForKey:@"ec_key_id"];
        [self.navigationController pushViewController:_newsDetailViewController animated:YES];
    }
    else if (_tag == 5){
        _newsDetailViewController = [[NewsDetailViewController alloc] init];
        _newsDetailViewController.newType = NewTypeNotice;
        _newsDetailViewController.key = @"noticegetDetail";
        _newsDetailViewController.titleID = [item objectForKey:@"ec_key_id"];
        [self.navigationController pushViewController:_newsDetailViewController animated:YES];
    }
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    [self clearTableData];
    NSDictionary *dic = (NSDictionary*)responseObject;
    if (request == _caseHttpClient) {
        for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
            [self.tableDatas addObject:item];
        }
    }
    
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
