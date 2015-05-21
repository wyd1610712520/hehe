//
//  ProcessViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProcessViewController.h"

#import "HttpClient.h"

#import "CaseRightViewController.h"

#import "ProcessDetailViewController.h"

#import "ProcessNewViewController.h"

#import "RootViewController.h"
#import "UIButton+AFNetworking.h"

@interface ProcessViewController ()<UITableViewDataSource,CaseViewControllerDelegate,UITableViewDelegate,RequestManagerDelegate,SegmentViewDelegate,PullToRefreshDelegate,CaseRightViewController>{
    CaseRightViewController *_caseRightViewController;
    ProcessDetailViewController *_processDetailViewController;
    ProcessNewViewController *_processNewViewController;
    
    int _currentPage;
    
    HttpClient *_searchHttpClient;
    HttpClient *_httpClient;
    
    RootViewController *_rootViewController;
    
    RootViewController *_rightViewController;
    
    NSString* _curType;
    
    
    NSString *_searchName;
    
    NSInteger _curTag;
    
    NSString *_clientName;
  
// 添加参数
    NSString *_caseId;
    NSString *_caseName;
    NSString *_charge;
    NSString *_category;
    NSString *_startTime;
    NSString *_endTime;
    
    BOOL isPull;
}

@end

@implementation ProcessViewController

@synthesize processCell = _processCell;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self setTitle:[Utility localizedStringWithTitle:@"process_nav_title"] color:nil];
    
}

- (void)setRootView:(RootViewController*)rootViewController{
    _rightViewController = rootViewController;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    
    _processDetailViewController = [[ProcessDetailViewController alloc] init];
    
    _searchName =@"";
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _currentPage = 1;
    self.view.frame = [UIScreen mainScreen].bounds;
    
    [self showSegment:[NSArray arrayWithObjects:@"最新回复",@"最新进程",@"立案日期", nil]];
    self.segmentView.delegate = self;
    [self showTable];
    
    _caseId = @"";
    _caseName = @"";
    _charge = @"";
    _category = @"";
    _startTime = @"";
    _endTime = @"";
    
    NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_add_btn.png"],@"image",nil,@"selectedImage", nil];
    NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
    NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
    [self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];
    
    _searchHttpClient = [[HttpClient alloc] init];
    _searchHttpClient.delegate = self;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 88;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    self.bottomRefreshIndicator.pullToRefreshDelegate = self;
    
    _clientName = @"";
    
    _rightViewController.processRightViewController.delegate = self;
}

- (NSDictionary*)requestProcessParam:(NSString*)order{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            _caseId,@"ca_case_id",
                            _clientName,@"cl_client_name",
                            _caseName,@"ca_case_name",
                            _charge,@"ca_manager",
                            _category,@"ca_category",
                            _startTime,@"ca_case_date_s",
                            _endTime,@"ca_case_date_e",
                            order,@"ca_order_type",
                            @"",@"last_request_date",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"myCaseProcessList",@"requestKey",[NSString stringWithFormat:@"%d",_currentPage],@"currentPage",@"10",@"pageSize",fields,@"fields", nil];

    return param;
}

- (void)returnSearchKey:(NSString*)caseName
                 caseId:(NSString*)caseId
             clientName:(NSString*)clientName
               category:(NSString*)category
                 charge:(NSString*)charge
              startTime:(NSString*)startTime
                endTime:(NSString*)endTime{
    isPull = NO;
    _searchName = caseName;
    _clientName = clientName;
    
    _caseId = caseId;
    _caseName = caseName;
    _charge = charge;
    _category = category;
    _startTime = startTime;
    _endTime = endTime;
    
//    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
//                            caseId,@"ca_case_id",
//                            clientName,@"cl_client_name",
//                            caseName,@"ca_case_name",
//                            charge,@"ca_manager",
//                            category,@"ca_category",
//                            startTime,@"ca_case_date_s",
//                            endTime,@"ca_case_date_e",
//                            _curType,@"ca_order_type",
//                            @"",@"last_request_date",nil];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"myCaseProcessList",@"requestKey",@"1",@"currentPage",@"20000",@"pageSize",fields,@"fields", nil];
//    
//    [_httpClient startRequest:param];

    [_httpClient startRequest:[self requestProcessParam:_curType]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_caseRightViewController.view removeFromSuperview];
}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    _curTag = button.tag;

    if (_curTag == 0) {
        _curType = @"newreply";
        [_httpClient startRequest:[self requestProcessParam:@"newreply"]];
    }
    else if (_curTag == 1){
        _curType = @"newprocess";
        [_httpClient startRequest:[self requestProcessParam:@"newprocess"]];
    }
    else if (_curTag == 2){
        _curType = @"ca_case_date";
        [_httpClient startRequest:[self requestProcessParam:@"ca_case_date"]];
    }

}

- (void)touchNavRight:(UIButton*)button{
    if (button.tag == 0) {
        _processNewViewController = [[ProcessNewViewController alloc] init];
        [self.navigationController pushViewController:_processNewViewController animated:YES];
    }
    else if (button.tag == 1){
        // [self showRight];
        [self.revealContainer showRight];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:@"ProcessCell" owner:self options:nil];
        cell = _processCell;
    }
    
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    cell.avatorImageView.layer.borderColor = [UIColor clearColor].CGColor;
    [cell.avatorImageView setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[item objectForKey:@"ca_manager_photo"]] placeholderImage:[UIImage imageNamed:@"avator.png"]];
    
    NSString *caseName = [NSString stringWithFormat:@"%@",[item objectForKey:@"ca_case_name"]];
    NSRange range1 = [caseName rangeOfString:_searchName];
    if (range1.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:caseName];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
        cell.titleLabel.attributedText = caseString;
    }
    else{
        cell.titleLabel.text = caseName;
    }
    
    
    cell.nameLabel.text = [item objectForKey:@"ca_manager"];
    
    NSString *clientName = [NSString stringWithFormat:@"%@",[item objectForKey:@"cl_client_name"]];
    NSRange range2 = [clientName rangeOfString:_clientName];
    if (range2.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:clientName];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
        cell.companyLabel.attributedText = caseString;
    }
    else{
        cell.companyLabel.text = clientName;
    }
    
    
    cell.dateLabel.text = [item objectForKey:@"ca_case_date"];
    
    NSString *flag = [NSString stringWithFormat:@"%@(%@)",[item objectForKey:@"processCnt"],[item objectForKey:@"newprocessCnt"]];
    NSRange range = [flag rangeOfString:[item objectForKey:@"newprocessCnt"] options:NSBackwardsSearch];
    NSMutableAttributedString *flagString = [[NSMutableAttributedString alloc] initWithString:flag];
    [flagString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    cell.flagLabel.attributedText = flagString;
    
    NSString *comment = [NSString stringWithFormat:@"%@(%@)",[item objectForKey:@"replyCnt"],[item objectForKey:@"newreplyCnt"]];
    NSRange commentrange = [comment rangeOfString:[item objectForKey:@"newreplyCnt"] options:NSBackwardsSearch];
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:comment];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:commentrange];
    cell.commentLabel.attributedText = commentString;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    _rootViewController = [[RootViewController alloc] init];
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController showInProcessDetail];
    _rootViewController.processDetailViewController.caseID = [item objectForKey:@"ca_case_id"];
}


#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    [self clearTableData];
    NSDictionary *dic = (NSDictionary*)responseObject;

    for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
        [self.tableDatas addObject:item];
    }
    [self.tableView reloadData];
    [self.topRefreshIndicator didLoadComplete:nil];
    [self.bottomRefreshIndicator didLoadComplete:nil];

}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

#pragma mark - PullToRefreshDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!isPull) {
        [self.topRefreshIndicator didPull];
        if (self.tableDatas.count == 0) {
            return;
        }
        
        [self.bottomRefreshIndicator didPull];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!isPull) {
        [self.topRefreshIndicator didPullReleased];
        
        if (self.tableDatas.count == 0) {
            return;
        }
        [self.bottomRefreshIndicator didPullReleased];
    }

}

- (void)didStartLoading:(PullToRefreshIndicator*)indicator{
    if (indicator == self.topRefreshIndicator) {
        _currentPage = 1;
    }
    else{
        _currentPage = 1 + _currentPage;
    }
    if (!isPull) {
        
        [_httpClient startRequest:[self requestProcessParam:_curType]];
        
    }
    else{
        [self.topRefreshIndicator didLoadComplete:nil];
        [self.bottomRefreshIndicator didLoadComplete:nil];
        
    }
}

@end
