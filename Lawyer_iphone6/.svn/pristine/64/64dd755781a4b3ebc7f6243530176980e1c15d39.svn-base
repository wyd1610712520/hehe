//
//  LogViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-4.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LogViewController.h"

#import "LogCell.h"

#import "LogRightViewController.h"

#import "LogCreateViewController.h"

#import "HttpClient.h"
#import "CommomClient.h"

#import "LogDetailViewController.h"
#import "NSString+Utility.h"
#import "RootViewController.h"

@interface LogViewController ()<UITableViewDataSource,UITableViewDelegate,SegmentViewDelegate,LogRightViewControllerDelegate,RequestManagerDelegate,PullToRefreshDelegate>{
    LogRightViewController *_logRightViewController;
    LogCreateViewController *_logCreateViewController;
    
    HttpClient *_listHttpClient;
    
    int currentPage;
    
    LogDetailViewController *_logDetailViewController;
    
    RootViewController *_rootViewController;
    
    NSDictionary *_myParam;
    
    NSString *_caseName;
    
    NSString *_clientName;
    NSString *_caseCategory;
    NSString *_caseCharge;
    NSString *_startTime;
    NSString *_endTime;
    
    NSString *_searchNameKey;
    NSString *_status;
    
    BOOL isPull;
}

@end

@implementation LogViewController

@synthesize logList = _logList;
@synthesize caseId = _caseId;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self clearTableData];
    if (_logList == LogListTime) {
        [_listHttpClient startRequest:[self listParam:@""]];
    }
    else if (_logList == LogListCase){
        
        [_listHttpClient startRequest:[self listParam:@"case"]];
    }
    else if (_logList == LogListCreate)
    {
        [_listHttpClient startRequest:[self listParam:@"create"]];
    }

}

- (void)setRootView:(RootViewController*)rootViewController{
    _rootViewController = rootViewController;
}

- (NSDictionary*)listParam:(NSString*)previewType{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"cl_client_id",
                            _caseId,@"ca_case_id",
                            _clientName,@"cl_client_name",
                            _caseName,@"ca_case_name",
                            _caseCharge,@"wl_empl_id",
                            _caseCategory,@"wl_case_category",
                            @"",@"wl_case_manager",
                            _startTime,@"wl_start_date_b",
                            _endTime,@"wl_start_date_e",
                            [[CommomClient sharedInstance] getAccount],@"userID",
                            _status, @"wl_status",
                            previewType,@"previewType",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"workLoggetList",@"requestKey",
                           [NSString stringWithFormat:@"%d",currentPage],@"currentPage",
                           @"10",@"pageSize",
                           fields,@"fields",nil];
    return param;
}

- (void)touchNavRight:(UIButton*)button{
    if (button.tag == 0) {
        _logCreateViewController = [[LogCreateViewController alloc] init];
        _logCreateViewController.logType = LogTypeAdd;
        if(![self.navigationController.topViewController isKindOfClass:[LogCreateViewController class]]){
            [self.navigationController pushViewController:_logCreateViewController animated:YES];
        }
        
    }
    else if (button.tag == 1){
//        [self showRight];
        
        [self.revealContainer showRight];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setTitle:@"工作日志" color:nil];
    
    [self showSegment:[NSArray arrayWithObjects:@"创建时间排序",@"日志时间排序",@"案件排序", nil]];
    self.segmentView.delegate = self;
    
    NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_add_btn.png"],@"image",nil,@"selectedImage", nil];
    NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
    NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
    [self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 130;
    self.tableView.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    self.bottomRefreshIndicator.pullToRefreshDelegate = self;
    
    _rootViewController.logRightViewController.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UINib *nib = [UINib nibWithNibName:@"LogCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LogCell"];
    
    currentPage = 1;
    
    _listHttpClient = [[HttpClient alloc] init];
    _listHttpClient.delegate = self;
    
    _caseName = @"";
    if (_caseId.length == 0) {
        _caseId = @"";
    }
    
    _clientName = @"";
    _caseCategory = @"";
    _caseCharge = @"";
    _startTime = @"";
    _endTime = @"";
    
    _searchNameKey = @"";
    

//    if (_logList == LogListTime) {
//        [_listHttpClient startRequest:[self listParam:@""]];
//    }
//    else if (_logList == LogListCase){
//        [_listHttpClient startRequest:[self listParam:@"case"]];
//    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesUpdate) name:@"log_create" object:nil];
    self.segmentView.isTouchEvent = YES;
}

- (void)receivesUpdate{
    UIButton *btn = (UIButton*)[self.segmentView.buttons objectAtIndex:0];
    [self didClickSegment:self.segmentView button:btn];
}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    [self clearTableData];
//    [self.tableView reloadData];
    if (button.tag == 0)
    {
        _logList = LogListCreate;
        
        [_listHttpClient startRequest:[self listParam:@"create"]];
    }
    else if (button.tag == 1) {
        _logList = LogListTime;
        
        [_listHttpClient startRequest:[self listParam:@""]];
    }
    else if (button.tag == 2){
        _logList = LogListCase;
        
        if (_status == NULL)
        {
            _status = @"";
        }
        [_listHttpClient startRequest:[self listParam:@"case"]];
    }
    [self.tableView reloadData];
    
}

- (void)logRightViewController:(LogRightViewController *)logRightViewController param:(NSDictionary *)param{
    _myParam = param;
    isPull = YES;
    [self clearTableData];
    _logList = LogListTime;
    if (_myParam) {
        [_listHttpClient startRequest:param];
    }
    
}

- (void)returnLogData:(NSString *)caseName caseID:(NSString *)caseID clientName:(NSString *)clientName caseCategory:(NSString *)caseCategory caseCharge:(NSString *)caseCharge startTime:(NSString *)startTime endTime:(NSString *)endTime status:(NSString *)status{
    isPull = NO;
    if (caseName.length > 0) {
        _caseName = caseName;
        
    }
    else{
        _caseName = @"";
    }
    
    if (caseID.length > 0) {
        _caseId = caseID;
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
    
    if (endTime.length > 0) {
        _endTime = endTime;
    }
    else{
        _endTime = @"";
    }

    _status = status;
    [self clearTableData];
    [self.tableView reloadData];
    
    if (_logList == LogListCreate)
    {
        [_listHttpClient startRequest:[self listParam:@"create"]];
    }
    else if (_logList == LogListTime) {
    
        [_listHttpClient startRequest:[self listParam:@""]];
    }
    else if (_logList == LogListCase){
        
        [_listHttpClient startRequest:[self listParam:@"case"]];
    }
    
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.tableDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_logList == LogListTime || _logList == LogListCreate) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
        return datas.count;
    }
    else if (_logList == LogListCase){
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"worklog_list"];
        return datas.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogCell"];

    if (_logList == LogListTime || _logList == LogListCreate) {
        if (self.tableDatas.count > 0) {
            NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
            
            NSDictionary *item = [datas objectAtIndex:indexPath.row];

            cell.contentLabel.text = [item objectForKey:@"wl_description"];
            cell.nameLabel.text = [item objectForKey:@"cl_client_name"];
            NSString *time = [self getDate:[item objectForKey:@"wl_start_date"] formatter:@"yyyy-MM-dd"];
            cell.timeLabel.text = time;
            
            NSString *title = [item objectForKey:@"ca_case_name"];
            NSRange titleRange = [title rangeOfString:_caseName];
            if (titleRange.location != NSNotFound) {
                NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:title];
                [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:titleRange];
                cell.titleLabel.attributedText = caseString;
            }
            else{
                cell.titleLabel.text = title;
            }

            if ([[item objectForKey:@"wl_state"] isEqualToString:@"N"]) {
                cell.auditLabel.text = @"未审核";
                cell.auditLabel.textColor = [UIColor redColor];
            }
            
            if ([[item objectForKey:@"wl_state"] isEqualToString:@"A"]) {
                cell.auditLabel.text = @"已审核";
                cell.auditLabel.textColor = [UIColor blackColor];
            }
            
            if ([[item objectForKey:@"wl_state"] isEqualToString:@"B"]) {
                cell.auditLabel.text = @"被退回";
                cell.auditLabel.textColor = [UIColor redColor];
            }
        }

    }
    
    else
        if (_logList == LogListCase){
        if (self.tableDatas.count > 0) {
            NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *datas = (NSArray*)[temDic objectForKey:@"worklog_list"];

            NSDictionary *item = [datas objectAtIndex:indexPath.row];

            cell.titleLabel.text = [temDic objectForKey:@"ca_case_name"];
            cell.contentLabel.text = [item objectForKey:@"wl_description"];
            cell.nameLabel.text = [temDic objectForKey:@"cl_client_name"];
            NSString *time = [self getDate:[item objectForKey:@"wl_start_date"] formatter:@"yyyy-MM-dd"];
            cell.timeLabel.text = time;

            if ([[item objectForKey:@"wl_state"] isEqualToString:@"N"]) {
                cell.auditLabel.text = @"未审核";
                cell.auditLabel.textColor = [UIColor redColor];
            }
            
            if ([[item objectForKey:@"wl_state"] isEqualToString:@"A"]) {
                cell.auditLabel.text = @"已审核";
                cell.auditLabel.textColor = [UIColor blackColor];
            }
            
            if ([[item objectForKey:@"wl_state"] isEqualToString:@"B"]) {
                cell.auditLabel.text = @"被退回";
                cell.auditLabel.textColor = [UIColor redColor];
            }

        }
            
    }
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_logList == LogListTime || _logList == LogListCreate) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        return [temDic objectForKey:@"time"];
    }
    else if (_logList == LogListCase){
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        return [temDic objectForKey:@"ca_case_name"];
    }
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)];
    view.backgroundColor = [@"#F9F9F9" colorValue];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-10, 22)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.textColor = [UIColor blackColor];
    if (_logList == LogListTime || _logList == LogListCreate) {
        if (self.tableDatas.count > 0) {
            NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
            titleLabel.text = [temDic objectForKey:@"time"];
        }
        
    }
    else if (_logList == LogListCase){
        if (self.tableDatas.count > 0) {
            NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
            titleLabel.text = [temDic objectForKey:@"ca_case_name"];
        }
        
    }
    
    [view addSubview:titleLabel];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _logDetailViewController = [[LogDetailViewController alloc] init];
    
    NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
    
    
    NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
    NSDictionary *item = [datas objectAtIndex:indexPath.row];
    _logDetailViewController.auditStatus = [item objectForKey:@"wl_state"];

    if (_logList == LogListTime || _logList == LogListCreate) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
        
        NSDictionary *item = [datas objectAtIndex:indexPath.row];
        
        _logDetailViewController.logId = [item objectForKey:@"wl_log_id"];
    }
    else if (_logList == LogListCase){
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"worklog_list"];
        
        NSDictionary *item = [datas objectAtIndex:indexPath.row];
        
        _logDetailViewController.logId = [item objectForKey:@"wl_log_id"];
    }
    if(![self.navigationController.topViewController isKindOfClass:[LogDetailViewController class]]){
        [self.navigationController pushViewController:_logDetailViewController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_logList == LogListTime || _logList == LogListCreate) {
        if (self.tableDatas.count) {
            NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
            
            NSDictionary *item = [datas objectAtIndex:indexPath.row];
            
            return [LogCell heightForRow:[item objectForKey:@"wl_description"]];
        }
        
    }
    else if (_logList == LogListCase){
        if (self.tableDatas.count) {
            NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *datas = (NSArray*)[temDic objectForKey:@"worklog_list"];
            
            NSDictionary *item = [datas objectAtIndex:indexPath.row];
            return [LogCell heightForRow:[item objectForKey:@"wl_description"]];
        }
        
    }
    return 0;
}

#pragma mark - RequestManagerDelegate


- (void)requestStarted:(id)request{
    
    [self showProgressHUD:@""];
    [self.view bringSubviewToFront:self.progressHUD];
}



- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;

    self.tableView.hidden = NO;
    
    if (_logList == LogListTime || _logList == LogListCreate) {
        NSMutableArray *dates = [[NSMutableArray alloc] init];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });  
            
        });
         
        for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
            NSString *time = nil;
            if (_logList == LogListTime)
            {
                time = [self getDate:[item objectForKey:@"wl_start_date"] formatter:@"yyyy-MM-dd"];
            }
            else
            {
                
                time = [self getDate:[item objectForKey:@"wl_create_date"] formatter:@"yyyy-MM-dd"];
                
            }
            if (![dates containsObject:time]) {
                [dates addObject:time];
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
            for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
                
                NSString *time = nil;
                if (_logList == LogListTime)
                {
                    time = [self getDate:[item objectForKey:@"wl_start_date"] formatter:@"yyyy-MM-dd"];
                }
                else
                {
                    time = [self getDate:[item objectForKey:@"wl_create_date"] formatter:@"yyyy-MM-dd"];
                }
                
                if ([tmpTime isEqualToString:time]) {
                    [tempD addObject:item];
                }
            }
            NSDictionary *temDic = [NSDictionary dictionaryWithObjectsAndKeys:tmpTime,@"time",tempD,@"data", nil];
            [self.tableDatas addObject:temDic];
        }
        
        
    }
    else if (_logList == LogListCase){
        for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
            [self.tableDatas addObject:item];
        }
        
        
    }
    [self.topRefreshIndicator didLoadComplete:nil];
    [self.bottomRefreshIndicator didLoadComplete:nil];
    
    [self.tableView reloadData];
}


- (NSString*)getDate:(NSString*)string formatter:(NSString*)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:string];
    [dateFormatter setDateFormat:formatter];
    NSString *time = [dateFormatter stringFromDate:date];
    return time;
    
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
    NSLog(@"%@", indicator);
    if (indicator == self.topRefreshIndicator) {
        [self clearTableData];
        currentPage = 1;
    }
    else{
        currentPage = 1 + currentPage;
    }
    if (!isPull) {
        if (_logList == LogListTime) {
            [_listHttpClient startRequest:[self listParam:@""]];
        }
        else if (_logList == LogListCase) {
            [_listHttpClient startRequest:[self listParam:@"case"]];
        }
        else if (_logList == LogListCreate) {
            [_listHttpClient startRequest:[self listParam:@"create"]];
        }
    }
    else{
        [self.topRefreshIndicator didLoadComplete:nil];
        [self.bottomRefreshIndicator didLoadComplete:nil];
        
        
      //  [self.tableView reloadData];

    }
    
}

@end
