//
//  LawRuleViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-25.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LawRuleViewController.h"

#import "RevealViewController.h"
#import "LawRuleRightViewController.h"

#import "HttpClient.h"

#import "NSString+Utility.h"

#import "LawCell.h"

#import "WebViewController.h"

#import "RootViewController.h"

#import "BeidaLibViewController.h"

#import "CategoryViewController.h"

@interface LawRuleViewController ()<UITableViewDataSource,UITableViewDelegate,PullToRefreshDelegate,CustomSegmentDelegate,RequestManagerDelegate>{
    LawRuleRightViewController *_lawRuleRightViewController;
    
    NSInteger _currentPage;
    
    WebViewController *_webViewController;
    
    HttpClient *_newHttpClient;
    HttpClient *_recomHttpClient;
    HttpClient *_listHttpClient;
    HttpClient *_lawHttpClient;
    BeidaLibViewController *_beidaLibViewController;
    
    HttpClient *_historyHttpClient;
    
    
    NSInteger _curTag;
    
    RootViewController *_rootViewController;
}

@end

@implementation LawRuleViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:[Utility localizedStringWithTitle:@"law_fabao_nav_title"] color:nil];
}

- (void)touchRightEvent{
   // [self showRight];
    [self.revealContainer showRight];
}

- (void)setRootViewController:(RootViewController*)rootViewController{
    _rootViewController = rootViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    
    [self setTitle:@"北大法宝" color:nil];
    [self setSegmentTitles:[NSArray arrayWithObjects:@"最新",@"推荐",@"排行",@"法库", nil] frame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    self.customSegment.segmentDelegate = self;
    self.customSegment.backgroundColor = [@"#E4F0FF" colorValue];
    CGRect frame = self.customSegment.frame;
    frame.origin.y = 0;
    frame.origin.x = 0;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x*2;
    self.customSegment.frame = frame;
    
    [self setRightButton:[UIImage imageNamed:@"nav_right_btn.png"] title:nil target:self action:@selector(touchRightEvent)];
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    self.bottomRefreshIndicator.pullToRefreshDelegate = self;
    
    
    _newHttpClient = [[HttpClient alloc] init];
    _newHttpClient.delegate = self;
    
    _recomHttpClient = [[HttpClient alloc] init];
    _recomHttpClient.delegate = self;
    
    _listHttpClient = [[HttpClient alloc] init];
    _listHttpClient.delegate = self;
    
    _lawHttpClient = [[HttpClient alloc] init];
    _lawHttpClient.delegate = self;
    
    _historyHttpClient = [[HttpClient alloc] init];
    _historyHttpClient.delegate = self;
    
    
    [self.customSegment clickFirstEvent];
}



- (NSDictionary*)newParam{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_currentPage],@"PageIndex",@"20",@"PageSize",@"AOM,CHL,EAGN,HKD,IEL,LAR,LFBJ,TWD",@"Library", nil];
    return param;
}

- (NSDictionary*)recomParam{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_currentPage],@"currentPage",@"20",@"pageSize",@"Lawrulerecommendlst",@"requestKey", nil];
    return param;
}

- (NSDictionary*)listParam{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_currentPage],@"currentPage",@"20",@"pageSize",@"Lawruleranklst",@"requestKey", nil];
    return param;
}

- (NSDictionary*)lawParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:@"LAWMODEL",@"gc_code_group", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"generalcode",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)touchSegment:(CustomSegment*)customSegment tag:(NSInteger)tag{
    [self clearTableData];
    _curTag = tag;
    _currentPage = 0;
    if (tag == 0) {
        UINib *cellNib = [UINib nibWithNibName:@"LawRuleCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawRuleCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_newHttpClient startRequestAtPath:[self newParam] path:@"UpdateRecordList"];
    }
    else if (tag == 1){
        UINib *cellNib = [UINib nibWithNibName:@"LawRuleCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawRuleCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_recomHttpClient startRequest:[self recomParam]];
    }
    else if (tag == 2){
        UINib *cellNib = [UINib nibWithNibName:@"LawRuleCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawRuleCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_listHttpClient startRequest:[self listParam]];
    }
    else if (tag == 3){
        UINib *cellNib = [UINib nibWithNibName:@"LawCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_lawHttpClient startRequestAtCommom:[self lawParam]];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_lawRuleRightViewController.view removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_curTag != 3) {
        LawRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LawRuleCell"];
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        cell.titleLabel.text = [item objectForKey:@"Title"];
        cell.timeLabel.text = [item objectForKey:@"IssueDate"];
        cell.companyLabel.text = [self checkType:[item objectForKey:@"Lib"]];
        
        return cell;
    }
    else{
        LawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LawCell"];
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        cell.titleLabel.text = [item objectForKey:@"gc_name"];
        cell.logoImageView.image = [UIImage imageNamed:@"law_fa_logo.png"];
        return cell;
    }
        
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_curTag != 3) {
        return 75;
    }
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_curTag != 3) {
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        NSString *library = [item objectForKey:@"Lib"];
        NSString *gid = [item objectForKey:@"Gid"];
        
        NSString *strUrl = [NSString stringWithFormat:@"http://www.elinklaw.com/zsglmobile/lawrule_view.htm?library=%@&gid=%@&word=", library, gid];
        
        [_historyHttpClient startRequest:[self loadParam:gid lr_prov_lib:library lr_prov_title:[item objectForKey:@"Title"]date:[item objectForKey:@"IssueDate"]]];
        
        _webViewController = [[WebViewController alloc] init];
        _webViewController.path = strUrl;
        _webViewController.title = @"法律法规正文";
        [self.navigationController pushViewController:_webViewController animated:YES];
    }
    else {
         NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];

        CategoryViewController *categoryViewController = [[CategoryViewController alloc] init];
        categoryViewController.navtitle = [item objectForKey:@"gc_name"];
        categoryViewController.item = item;
        [self.navigationController pushViewController:categoryViewController animated:YES];
        
//        _beidaLibViewController = [[BeidaLibViewController alloc] init];
//        _beidaLibViewController.lib = [item objectForKey:@"gc_id"];
//        [self.navigationController pushViewController:_beidaLibViewController animated:YES];
    }
}

- (NSDictionary*)loadParam:(NSString*)lr_prov_id
               lr_prov_lib:(NSString*)lr_prov_lib
             lr_prov_title:(NSString*)lr_prov_title date:(NSString*)date{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"lr_id",
                            @"pkulaw",@"lr_provider",
                            lr_prov_id,@"lr_prov_id",
                            lr_prov_lib,@"lr_prov_lib",
                            @"",@"lr_prov_category",
                            lr_prov_title,@"lr_prov_title",
                            date,@"lr_prov_issuedate",
                            date,@"lr_prov_updatedate",
                            @"",@"lr_search_date",
                            @"",@"lr_search_key",
                            @"",@"lr_ip_address",
                            @"",@"lr_location",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"lawrulehistoryadd",@"requestKey",fields,@"fields", nil];
    return param;
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    
    if (request == _newHttpClient) {
        NSDictionary *record = (NSDictionary*)[result objectForKey:@"Data"];
        for (NSDictionary *item in [record objectForKey:@"Collection"]) {
            if (![self.indexSet containsObject:[item objectForKey:@"Gid"]]) {
                [self.indexSet addObject:[item objectForKey:@"Gid"]];
                [self.tableDatas addObject:item];
            }
        }
    }
    else if (request == _recomHttpClient){
        NSDictionary *record = (NSDictionary*)responseObject;
        for (NSDictionary *item in [record objectForKey:@"record_list"]) {
            if (![self.indexSet containsObject:[item objectForKey:@"Gid"]]) {
                [self.indexSet addObject:[item objectForKey:@"Gid"]];
                [self.tableDatas addObject:item];
            }
        }
    }
    else if (request == _listHttpClient){
        NSDictionary *record = (NSDictionary*)responseObject;
        for (NSDictionary *item in [record objectForKey:@"record_list"]) {
            if (![self.indexSet containsObject:[item objectForKey:@"Gid"]]) {
                [self.indexSet addObject:[item objectForKey:@"Gid"]];
                [self.tableDatas addObject:item];
            }
        }
    }
    else if (request == _lawHttpClient){
        NSDictionary *record = (NSDictionary*)responseObject;
        for (NSDictionary *item in [record objectForKey:@"record_list"]) {
            if (![self.indexSet containsObject:[item objectForKey:@"gc_id"]]) {
                [self.indexSet addObject:[item objectForKey:@"gc_id"]];
                [self.tableDatas addObject:item];
            }
        }
    }
  
    [self.topRefreshIndicator didLoadComplete:nil];
    [self.bottomRefreshIndicator didLoadComplete:nil];
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

#pragma mark - PullToRefreshDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.topRefreshIndicator didPull];
    if (self.tableDatas.count == 0) {
        return;
    }
    
    
    [self.bottomRefreshIndicator didPull];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.topRefreshIndicator didPullReleased];
    if (self.tableDatas.count == 0) {
        return;
    }
    [self.bottomRefreshIndicator didPullReleased];
}

- (void)didStartLoading:(PullToRefreshIndicator*)indicator{
    if (indicator == self.topRefreshIndicator) {
        _currentPage = 1;
    }
    else{
        _currentPage = 1 + _currentPage;
    }
    
    
    if (_curTag == 0) {
        [_newHttpClient startRequestAtPath:[self newParam] path:@"UpdateRecordList"];
    }
    else if (_curTag == 1) {
        [_recomHttpClient startRequest:[self recomParam]];
    }
    else if (_curTag == 2) {
        [_listHttpClient startRequest:[self listParam]];
    }
    else if (_curTag == 3) {
        
    }
}


- (NSString*)checkType:(NSString*)type{
    NSString *company = @"";
    if ([type isEqualToString:@"AOM"]) {
        company = @"澳门法律法规";
    }
    else if ([type isEqualToString:@"ATR"]) {
        company = @"仲裁案例";
    }
    else if ([type isEqualToString:@"CHL"]) {
        company = @"中央法规司法解释";
    }
    else if ([type isEqualToString:@"CON"]) {
        company = @"合同范本";
    }
    else if ([type isEqualToString:@"EAGN"]) {
        company = @"中外条约";
    }
    else if ([type isEqualToString:@"FMT"]) {
        company = @"文书范本";
    }
    else if ([type isEqualToString:@"HKD"]) {
        company = @"香港法律法规";
    }
    else if ([type isEqualToString:@"IEL"]) {
        company = @"外国法律法规";
    }
    else if ([type isEqualToString:@"LAR"]) {
        company = @"地方法规规章";
    }
    else if ([type isEqualToString:@"LFBJ"]) {
        company = @"立法背景资料";
    }
    else if ([type isEqualToString:@"NEWS"]) {
        company = @"法律动态";
    }
    else if ([type isEqualToString:@"PAL"]) {
        company = @"案例报道";
    }
    else if ([type isEqualToString:@"PAYZ"]) {
        company = @"案例要旨";
    }
    else if ([type isEqualToString:@"PCAS"]) {
        company = @"公报案例";
    }
    else if ([type isEqualToString:@"PFNL"]) {
        company = @"司法案例";
    }
    else if ([type isEqualToString:@"TWD"]) {
        company = @"台湾法律法规";
    }
    return company;
}

@end

/*  new
 
 {
 "Lib":"CHL",
 "Gid":"215493",
 "Title":"全国中小企业股份转让系统有限责任公司关于修改《全国中小企业股份转让系统业务规则(试行)》的公告(2013)",
 "IssueDate":"2013.12.30",
 "UpdateTime":"2014.01.01 12:43:18"
 },
 
 
 {"mgid":"True","msg":"","record_list":[{"gc_id":"AOM","gc_name":"澳门法律法规"},{"gc_id":"CHL","gc_name":"中央法规司法解释"},{"gc_id":"EAGN","gc_name":"中外条约"},{"gc_id":"HKD","gc_name":"香港法律法规"},{"gc_id":"IEL","gc_name":"外国法律法规"},{"gc_id":"LAR","gc_name":"地方法规规章"},{"gc_id":"LFBJ","gc_name":"立法背景资料"},{"gc_id":"TWD","gc_name":"台湾法律法规"}]}
 */
