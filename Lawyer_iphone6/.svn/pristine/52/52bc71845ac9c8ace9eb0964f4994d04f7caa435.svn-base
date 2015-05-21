//
//  CaseViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-10.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CaseViewController.h"

#import "HttpClient.h"

#import "RootViewController.h"


@interface CaseViewController ()<UITableViewDataSource,UITableViewDelegate,RequestManagerDelegate,PullToRefreshDelegate,CaseRightViewController>{
    RootViewController *_rootViewController;
    
    RootViewController *_detailViewController;
    
    HttpClient *_searchHttpClient;
    
    NSString *_searchIDkey;
    NSString *_searchClientNkey;
    NSString *_searchCategorykey;
    NSString *_searchChargekey;
    
    NSDictionary *_param;
}

@end

@implementation CaseViewController

@synthesize caseCell = _caseCell;

@synthesize caseStatuts = _caseStatuts;

@synthesize delegate = _delegate;

@synthesize searchKey = _searchKey;
@synthesize hintView = _hintView;


- (void)setRootView:(RootViewController*)rootViewController{
    _rootViewController = rootViewController;
}

- (void)openRightView{
    [self.revealContainer showRight];
    if (_searchKey.length > 0){
        _rootViewController.caseRightViewController.caseNameField.text = _searchKey;
    }
}

- (NSDictionary*)requestSearchParams:(NSString*)clientName{

    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            clientName,@"cl_client_name",
                            @"",@"ca_client_id",
                            @"",@"ca_category",
                            _searchKey,@"ca_case_name",
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setTitle:@"案件" color:nil];
    [self setRightButton:nil title:@"筛选" target:self action:@selector(openRightView)];
    
    
    if (_searchKey.length == 0) {
        _searchKey = @"";
    }
    
    _searchIDkey = @"";
    _searchClientNkey = @"";
    _searchCategorykey = @"";
    _searchChargekey = @"";
    
    _searchHttpClient = [[HttpClient alloc] init];
    _searchHttpClient.delegate = self;
    [_searchHttpClient startRequest:[self requestSearchParams:@""]];
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UINib *cellNib = [UINib nibWithNibName:@"CaseCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CaseCell"];
    
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    self.bottomRefreshIndicator.pullToRefreshDelegate = self;
    
    _rootViewController.caseRightViewController.delegate = self;

}

- (void)returnCommomName:(NSString *)categoryName chargeName:(NSString *)chargeName{
    NSRange categoryRange = [categoryName rangeOfString:@"】"];
    if (categoryRange.location != NSNotFound) {
        categoryName = [categoryName substringFromIndex:categoryRange.location+1];
    }
    
    
    
    
    _searchCategorykey = categoryName;
    _searchChargekey = chargeName;
}



- (void)returnSearchKey:(NSString *)caseName caseId:(NSString *)caseId clientName:(NSString *)clientName category:(NSString *)category charge:(NSString *)charge startTime:(NSString *)startTime endTime:(NSString *)endTime{
    _searchKey = caseName;
    _searchIDkey = caseId;
    _searchClientNkey = clientName;
    
    
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            clientName,@"cl_client_name",
                            @"",@"ca_client_id",
                            category,@"ca_category",
                            caseName,@"ca_case_name",
                            caseId,@"ca_case_id",
                            @"",@"ca_kind_type",
                            @"",@"ca_area",
                            @"",@"ca_dept_id",
                            charge,@"ca_manager",
                            @"",@"ca_lawyer",
                            startTime,@"ca_case_date_b",
                            endTime,@"ca_case_date_e",
                            @"",@"ca_status",
                            @"",@"last_request_date",nil];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"casequery",@"requestKey",@"1",@"currentPage",@"20000",@"pageSize",fields,@"fields", nil];
    
    _param = param;
    [_searchHttpClient startRequest:param];
 }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CaseCell"];
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    NSString *caseName = [NSString stringWithFormat:@"%@",[item objectForKey:@"ca_case_name"]];
    NSRange range = [caseName rangeOfString:_searchKey];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:caseName];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        cell.titleLabel.attributedText = caseString;
    }
    else{
        cell.titleLabel.text = caseName;
    }
    
    
    NSString *caseID = [NSString stringWithFormat:@"案件编号:%@",[item objectForKey:@"ca_case_id"]];
    NSRange caseIDRange = [caseID rangeOfString:_searchIDkey];
    if (caseIDRange.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:caseID];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:caseIDRange];
        cell.caseLabel.attributedText = caseString;
    }
    else{
        cell.caseLabel.text = caseID;
    }
    
    NSString *clientName = [NSString stringWithFormat:@"客户:%@",[item objectForKey:@"cl_client_name"]];
    NSRange clientNRange = [clientName rangeOfString:_searchClientNkey];
    if (clientNRange.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:clientName];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:clientNRange];
        cell.clientLabel.attributedText = caseString;
    }
    else{
        cell.clientLabel.text = clientName;
    }
    
    
    NSString *categoryName = [NSString stringWithFormat:@"案件类别:%@",[item objectForKey:@"ca_category"]];
    NSRange categoryRange = [categoryName rangeOfString:_searchCategorykey];
    if (categoryRange.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:categoryName];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:categoryRange];
        cell.categoryLabel.attributedText = caseString;
    }
    else{
        cell.categoryLabel.text = categoryName;
    }
    
    
    NSString *chargeName = [NSString stringWithFormat:@"负责人:%@",[item objectForKey:@"ca_manager_name"]];
    NSRange chargeRange = [chargeName rangeOfString:_searchChargekey];
    if (chargeRange.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:chargeName];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:chargeRange];
        cell.chargeLabel.attributedText = caseString;
    }
    else{
        cell.chargeLabel.text = chargeName;
    }
    
    
    
    NSString *time = [item objectForKey:@"ca_case_date"];
    NSRange timeRange = [time rangeOfString:@" "];
    if (timeRange.location != NSNotFound) {
        cell.dateLabel.text = [NSString stringWithFormat:@"立案日期:%@",[time substringToIndex:timeRange.location]];
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    if (_caseStatuts == CaseStatutsNormal) {
        _detailViewController = [[RootViewController alloc] init];
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:_detailViewController animated:YES completion:nil];
        [_detailViewController showInCaseDetail];
        [_detailViewController.caseDetatilViewController setCaseId:[item objectForKey:@"ca_case_id"]];

    }
    else if (_caseStatuts == CaseStatutsSelectable){
        if ([_delegate respondsToSelector:@selector(returnDataToProcess:)]) {
            [_delegate returnDataToProcess:item];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
}

#pragma mark -- RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self.view bringSubviewToFront:self.progressHUD];
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    [self clearTableData];
    for (NSDictionary *item in [result objectForKey:@"record_list"]) {
        [self.tableDatas addObject:item];
    }
    
    if (self.tableDatas.count == 0) {
        _hintView.frame = self.view.bounds;
        [self.view addSubview:_hintView];
    }
    else{
        [_hintView removeFromSuperview];
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
        if (_param.count > 0) {
            [_searchHttpClient startRequest:_param];
        }
        else{
            [_searchHttpClient startRequest:[self requestSearchParams:@""]];
        }
        
    }
    else{
        [self.bottomRefreshIndicator didLoadComplete:nil];
    }
    
}

@end
