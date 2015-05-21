//
//  LogAuditViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "LogAuditViewController.h"

#import "RootViewController.h"
#import "RevealViewController.h"
#import "HttpClient.h"
#import "NSString+Utility.h"

#import "LogAuditRightViewController.h"
#import "LogCell.h"

#import "CommomClient.h"

#import "UIView+Utility.h"

#import "LogDetailViewController.h"

@interface LogAuditViewController ()<SegmentViewDelegate,LogAuditRightViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,RequestManagerDelegate>{
    RootViewController *_rootViewController;
    
    HttpClient *_httpClient;
    
    NSInteger curTag;
    
    NSString *_caseName;
    NSString *_clientName;
    NSString *_caseId;
    NSString *_lawyer;
    NSString *_startTime;
    NSString *_endTime;

    NSString *_caseNameKey;
    NSString *_clientNameKey;
    
    LogDetailViewController *_logDetailViewController;
}


@end

@implementation LogAuditViewController

@synthesize logAuditType = _logAuditType;

- (void)touchRightEvent{
    [self.revealContainer showRight];
    
}

- (void)setRootView:(RootViewController *)rootViewController{
    _rootViewController = rootViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setRightButton:nil title:@"筛选" target:self action:@selector(touchRightEvent)];
    [self showSegment:[NSArray arrayWithObjects:@"时间排序",@"人员排序",@"案件排序", nil]];
    self.segmentView.isShow = NO;
    self.segmentView.backgroundColor = [@"#F9F9F9" colorValue];
    self.segmentView.delegate = self;
    
    CGRect frame = self.segmentView.frame;
    frame.origin.y = 5;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x*2;
    self.segmentView.frame = frame;
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *cellNib = [UINib nibWithNibName:@"LogCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LogCell"];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _rootViewController.logAuditRightViewController.delegate = self;
    
    _caseName = @"";
    _caseId = @"";
    _clientName = @"";
    _startTime = @"";
    _endTime = @"";
    _lawyer = @"";
    
    _caseNameKey = @"";
    _clientNameKey = @"";
    
    if (_logAuditType == DocumentAuditTypeUndone) {
        [self setTitle:@"待审核日志" color:nil];
    }
    else if (_logAuditType == DocumentAuditTypeDone){
        [self setTitle:@"已审核日志" color:nil];
    }

}

- (NSDictionary*)param:(NSString*)previewType status:(NSString*)status{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getAccount],@"userID",
                            @"",@"cl_client_id",
                            _caseId,@"ca_case_id",
                            _clientName,@"cl_client_name",
                            _caseName,@"ca_case_name",
                            _lawyer,@"wl_empl_id",
                            _startTime,@"wl_start_date_b",
                            _endTime,@"wl_start_date_e",
                            previewType,@"previewType",
                            status,@"wl_status",nil];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"1000",@"pageSize",@"1",@"currentPage",@"workLoggetCheckList",@"requestKey", nil];
    return param;
}

- (void)returnLogAuditData:(NSString*)caseName
                    caseId:(NSString*)caseId
                clientName:(NSString*)clientName
                 startTime:(NSString*)startTime
                   endTime:(NSString*)endTime
                    lawyer:(NSString*)lawyer{
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
    if (lawyer.length > 0) {
       
        _lawyer = lawyer;
    }
    else{
        _lawyer = @"";
    }
  
    
    for (int i = 0; i < self.segmentView.buttons.count; i++) {
        UIButton *btn = (UIButton*)[self.segmentView.buttons objectAtIndex:i];
        if (i == 0) {
            btn.selected = YES;
        }
        else{
            btn.selected = NO;
        }
    }
    UIButton *btn = (UIButton*)[self.segmentView.buttons objectAtIndex:0];
    [self didClickSegment:self.segmentView button:btn];
//    if (_logAuditType == DocumentAuditTypeUndone) {
//        
////        if (curTag == 0) {
////            [_httpClient startRequest:[self param:@"" status:@"N"]];
////        }
////        else if (curTag == 1){
////            [_httpClient startRequest:[self param:@"person" status:@"N"]];
////        }
////        else if (curTag == 2){
////            [_httpClient startRequest:[self param:@"case" status:@"N"]];
////        }
//        [_httpClient startRequest:[self param:@"" status:@"N"]];
//    }
//    else if (_logAuditType == DocumentAuditTypeDone){
////        if (curTag == 0) {
////            [_httpClient startRequest:[self param:@"" status:@"A"]];
////        }
////        else if (curTag == 1){
////            [_httpClient startRequest:[self param:@"person" status:@"A"]];
////        }
////        else if (curTag == 2){
////            [_httpClient startRequest:[self param:@"case" status:@"A"]];
////        }
//        [_httpClient startRequest:[self param:@"" status:@"A"]];
//    }
//
    _caseNameKey = caseName;
    _clientNameKey = clientName;
}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    curTag = button.tag;
    if (_logAuditType == DocumentAuditTypeUndone) {
        
        if (button.tag == 0) {
            [_httpClient startRequest:[self param:@"" status:@"N"]];
        }
        else if (button.tag == 1){
            [_httpClient startRequest:[self param:@"person" status:@"N"]];
        }
        else if (button.tag == 2){
            [_httpClient startRequest:[self param:@"case" status:@"N"]];
        }
        
    }
    else if (_logAuditType == DocumentAuditTypeDone){
        if (button.tag == 0) {
            [_httpClient startRequest:[self param:@"" status:@"A"]];
        }
        else if (button.tag == 1){
            [_httpClient startRequest:[self param:@"person" status:@"A"]];
        }
        else if (button.tag == 2){
            [_httpClient startRequest:[self param:@"case" status:@"A"]];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     if (_logAuditType == DocumentAuditTypeUndone) {
        
        if (curTag == 0) {
            [_httpClient startRequest:[self param:@"" status:@"N"]];
        }
        else if (curTag == 1){
            [_httpClient startRequest:[self param:@"person" status:@"N"]];
        }
        else if (curTag == 2){
            [_httpClient startRequest:[self param:@"case" status:@"N"]];
        }
        
    }
    else if (_logAuditType == DocumentAuditTypeDone){
        if (curTag == 0) {
            [_httpClient startRequest:[self param:@"" status:@"A"]];
        }
        else if (curTag == 1){
            [_httpClient startRequest:[self param:@"person" status:@"A"]];
        }
        else if (curTag == 2){
            [_httpClient startRequest:[self param:@"case" status:@"A"]];
        }
    }

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (curTag == 0) {
        return self.tableDatas.count;
    }
    else if (curTag == 1){
        return self.tableDatas.count;
    }
    else if (curTag == 2){
        return self.tableDatas.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (curTag == 0) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
        return datas.count;
    }
    else if (curTag == 1){
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        return [[item objectForKey:@"worklog_list"] count];
    }
    else if (curTag == 2){
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        return [[item objectForKey:@"worklog_list"] count];
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)];
    view.backgroundColor = [@"#F9F9F9" colorValue];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-10, 22)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    
    [view addSubview:titleLabel];
    
    
    if (curTag == 0) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        titleLabel.text = [temDic objectForKey:@"time"];
    }
    else if (curTag == 1){
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        titleLabel.text = [item objectForKey:@"wl_empl_name"];
    }
    else if (curTag == 2){
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        titleLabel.text = [item objectForKey:@"ca_case_name"];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogCell"];
    cell.auditLabel.hidden = YES;
    if (curTag == 0) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
        
        NSDictionary *item = [datas objectAtIndex:indexPath.row];
        
        cell.contentLabel.text = [item objectForKey:@"wl_description"];
        NSString *time = [self getDate:[item objectForKey:@"wl_start_date"] formatter:@"yyyy-MM-dd"];
        cell.timeLabel.text = time;
        
        NSString *caseName = [item objectForKey:@"ca_case_name"];
        NSRange range = [caseName rangeOfString:_caseNameKey];
        if (range.location != NSNotFound) {
            NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:caseName];
            [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            cell.titleLabel.attributedText = caseString;
        }
        else{
            cell.titleLabel.text = caseName;
        }
        
        
        NSString *clientName = [item objectForKey:@"cl_client_name"];
        NSRange clientNRange = [clientName rangeOfString:_clientNameKey];
        if (clientNRange.location != NSNotFound) {
            NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:clientName];
            [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:clientNRange];
            cell.nameLabel.attributedText = caseString;
        }
        else{
            cell.nameLabel.text = clientName;
        }
    }
    else if (curTag == 1){
        NSDictionary *recod = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *list = [recod objectForKey:@"worklog_list"];
        
        NSDictionary *item = [list objectAtIndex:indexPath.row];

        cell.titleLabel.text = [item objectForKey:@"ca_case_name"];
        cell.contentLabel.text = [item objectForKey:@"wl_description"];
        cell.nameLabel.text = [recod objectForKey:@"wl_empl_name"];
        NSString *time = [self getDate:[item objectForKey:@"wl_start_date"] formatter:@"yyyy-MM-dd"];
        cell.timeLabel.text = time;
        
    }
    else if (curTag == 2){
        NSDictionary *recod = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *list = [recod objectForKey:@"worklog_list"];
        
        NSDictionary *item = [list objectAtIndex:indexPath.row];

        cell.titleLabel.text = [recod objectForKey:@"ca_case_name"];
        cell.contentLabel.text = [item objectForKey:@"wl_description"];
        cell.nameLabel.text = [recod objectForKey:@"wl_empl_name"];
        NSString *time = [self getDate:[item objectForKey:@"wl_start_date"] formatter:@"yyyy-MM-dd"];
        cell.timeLabel.text = time;
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (curTag == 0) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
        
        NSDictionary *item = [datas objectAtIndex:indexPath.row];
        return [LogCell heightForRow:[item objectForKey:@"wl_description"]];
    }
    else if (curTag == 1){
        NSDictionary *recod = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *list = [recod objectForKey:@"worklog_list"];
        
        NSDictionary *item = [list objectAtIndex:indexPath.row];
        return  [LogCell heightForRow:[item objectForKey:@"wl_description"]];
    }
    else if (curTag == 2){
        NSDictionary *recod = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *list = [recod objectForKey:@"worklog_list"];
        
        NSDictionary *item = [list objectAtIndex:indexPath.row];
        return  [LogCell heightForRow:[item objectForKey:@"wl_description"]];
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _logDetailViewController = [[LogDetailViewController alloc] init];
    if (curTag == 0) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
        
        NSDictionary *item = [datas objectAtIndex:indexPath.row];
        
        _logDetailViewController.logId = [item objectForKey:@"wl_log_id"];
        
        if (_logAuditType == LogAuditTypeDone) {
            _logDetailViewController.isDone = YES;
        }
        else{
            
        }
    
    }
    else if (curTag == 1){
        NSDictionary *recod = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *list = [recod objectForKey:@"worklog_list"];
        
        NSDictionary *item = [list objectAtIndex:indexPath.row];
        
        
        _logDetailViewController.logId = [item objectForKey:@"wl_log_id"];
    }
    else if (curTag == 2){
        NSDictionary *recod = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *list = [recod objectForKey:@"worklog_list"];
        
        NSDictionary *item = [list objectAtIndex:indexPath.row];
        
        _logDetailViewController.logId = [item objectForKey:@"wl_log_id"];
    }
    _logDetailViewController.logAudtiState = LogAudtiStateAudit;
    [self.navigationController pushViewController:_logDetailViewController animated:YES];
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    [self clearTableData];
    
    if (curTag == 0) {
        NSMutableArray *dates = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [result objectForKey:@"record_list"]) {
            NSString *time = [item objectForKey:@"wl_start_date"];
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
                NSString *time = [item objectForKey:@"wl_start_date"];
                time = [self.view getPerTime:time];
                
                if ([tmpTime isEqualToString:time]) {
                    [tempD addObject:item];
                }
            }
            NSDictionary *temDic = [NSDictionary dictionaryWithObjectsAndKeys:tmpTime,@"time",tempD,@"data", nil];
            [self.tableDatas addObject:temDic];
        }
        

    }
    else if (curTag == 1){
        for (NSDictionary *item in [result objectForKey:@"record_list"]) {
            [self.tableDatas addObject:item];
        }
    }
    else if (curTag == 2){
        for (NSDictionary *item in [result objectForKey:@"record_list"]) {
            [self.tableDatas addObject:item];
        }
    }
    
    
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
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

@end
