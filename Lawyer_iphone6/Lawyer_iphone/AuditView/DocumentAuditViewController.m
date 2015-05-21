//
//  DocumentAuditViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "DocumentAuditViewController.h"

#import "RootViewController.h"
#import "RevealViewController.h"
#import "HttpClient.h"
#import "NSString+Utility.h"

#import "DocumentAuditRightViewController.h"

#import "DocumentAuditCell.h"

#import "CommomClient.h"

#import "UIView+Utility.h"

#import "DocuDetailViewController.h"

@interface DocumentAuditViewController ()<SegmentViewDelegate,DocumentAuditViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,RequestManagerDelegate>{
    RootViewController *_rootViewController;
    
    HttpClient *_httpClient;
    
    NSInteger curTag;
    
    NSString *_paperName;
    NSString *_caseName;
    NSString *_caseId;
    NSString *_papercreator;
    NSString *_startTime;
    NSString *_endTime;
    
    NSString *_searchFile;
    NSString *_searchName;
    
    DocuDetailViewController *_docuDetailViewController;
}

@end

@implementation DocumentAuditViewController

@synthesize documentAuditType = _documentAuditType;

- (void)setRootView:(RootViewController*)rootViewController{
    _rootViewController = rootViewController;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_documentAuditType == DocumentAuditTypeUndone) {
        
        if (curTag == 0) {
            [_httpClient startRequest:[self param:@"" status:@"0"]];
        }
        else if (curTag == 1){
            [_httpClient startRequest:[self param:@"case" status:@"0"]];
        }
    }
    else if (_documentAuditType == DocumentAuditTypeDone){
        if (curTag == 0) {
            [_httpClient startRequest:[self param:@"" status:@"1"]];
        }
        else if (curTag == 1){
            [_httpClient startRequest:[self param:@"case" status:@"1"]];
        }
        
    }
}

- (void)touchRightEvent{
    [self.revealContainer showRight];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setRightButton:nil title:@"筛选" target:self action:@selector(touchRightEvent)];
    [self showSegment:[NSArray arrayWithObjects:@"时间排序",@"案件排序", nil]];
    self.segmentView.isShow = NO;
    self.segmentView.backgroundColor = [@"#F9F9F9" colorValue];
    self.segmentView.delegate = self;
    
    CGRect frame = self.segmentView.frame;
    frame.origin.y = 5;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x*2;
    self.segmentView.frame = frame;

    _rootViewController.documentAuditRightViewController.delegate = self;
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *cellNib = [UINib nibWithNibName:@"DocumentAuditCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DocumentAuditCell"];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _searchFile = @"";
    _searchName = @"";
    
    _paperName = @"";
    _caseName = @"";
    _caseId = @"";
    _papercreator = @"";
    _startTime = @"";
    _endTime = @"";
    
    if (_documentAuditType == DocumentAuditTypeUndone) {
        [self setTitle:@"待审核文书" color:nil];
    }
    else if (_documentAuditType == DocumentAuditTypeDone){
        [self setTitle:@"已审核文书" color:nil];
        
    }
    

}

- (NSDictionary*)param:(NSString*)previewType status:(NSString*)status{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getAccount],@"userID",
                            _paperName,@"paperName",
                            @"",@"paperType",
                            _startTime,@"paperDate_b",
                            _endTime,@"paperDate_s",
                            _caseId,@"paper_case_id",
                            _caseName,@"paper_case_name",
                            _papercreator,@"paper_creator",
                            previewType,@"previewType",
                            status,@"status",nil];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"1000",@"pageSize",@"1",@"currentPage",@"papergetList",@"requestKey", nil];
    return param;
}


- (void)returnLogDocuData:(NSString *)fileName caseId:(NSString *)caseId caseName:(NSString *)caseName startTime:(NSString *)startTime endTime:(NSString *)endTime lawyer:(NSString *)lawyer{
    
    _searchName = caseName;
    _searchFile = fileName;
    
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
    
    if (fileName.length > 0) {
        _paperName = fileName;
    }
    else{
        _paperName = @"";
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
        
        _papercreator = lawyer;
    }
    else{
        _papercreator = @"";
    }
    if (_documentAuditType == DocumentAuditTypeUndone) {
        
        if (curTag == 0) {
            [_httpClient startRequest:[self param:@"" status:@"0"]];
        }
        else if (curTag == 1){
            [_httpClient startRequest:[self param:@"case" status:@"0"]];
        }
    }
    else if (_documentAuditType == DocumentAuditTypeDone){
        if (curTag == 0) {
            [_httpClient startRequest:[self param:@"" status:@"1"]];
        }
        else if (curTag == 1){
            [_httpClient startRequest:[self param:@"case" status:@"1"]];
        }
        
    }

}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    curTag = button.tag;
    if (_documentAuditType == DocumentAuditTypeUndone) {
        
        if (curTag == 0) {
            [_httpClient startRequest:[self param:@"" status:@"0"]];
        }
        else if (curTag == 1){
            [_httpClient startRequest:[self param:@"case" status:@"0"]];
        }
    }
    else if (_documentAuditType == DocumentAuditTypeDone){
        if (curTag == 0) {
            [_httpClient startRequest:[self param:@"" status:@"1"]];
        }
        else if (curTag == 1){
            [_httpClient startRequest:[self param:@"case" status:@"1"]];
        }

    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableDatas.count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (curTag == 0) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        return [temDic objectForKey:@"time"];
    }
    else if (curTag == 1){
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        return [item objectForKey:@"ca_case_name"];
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (curTag == 0) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
        return datas.count;
    }
    else if (curTag == 1){
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        return [[item objectForKey:@"doc_list"] count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DocumentAuditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DocumentAuditCell"];
    
    if (curTag == 0) {
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
        
        NSDictionary *item = [datas objectAtIndex:indexPath.row];
        cell.titleLabel.text = [item objectForKey:@"do_title"];
        cell.detailLabel.text = [NSString stringWithFormat:@"案件名称：%@",[item objectForKey:@"do_case_name"]];
        
        NSString *fileName = [NSString stringWithFormat:@"%@",[item objectForKey:@"do_title"]];
        NSRange range = [fileName rangeOfString:_searchFile];
        if (range.location != NSNotFound) {
            NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:fileName];
            [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            cell.titleLabel.attributedText = caseString;
        }
        else{
            cell.titleLabel.text = fileName;
        }
        
        NSString *caseName = [NSString stringWithFormat:@"%@",[item objectForKey:@"do_case_name"]];
        NSRange range1 = [caseName rangeOfString:_searchName];
        if (range1.location != NSNotFound) {
            NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:caseName];
            [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
            cell.detailLabel.attributedText = caseString;
        }
        else{
            cell.detailLabel.text = caseName;
        }
    }
    else if (curTag == 1){
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *list = [item objectForKey:@"doc_list"];
        NSDictionary *record = [list objectAtIndex:indexPath.row];
        //cell.titleLabel.text = [record objectForKey:@"do_title"];
        //cell.detailLabel.text = [NSString stringWithFormat:@"案件名称：%@",[item objectForKey:@"ca_case_name"]];
        
        NSString *fileName = [NSString stringWithFormat:@"%@",[record objectForKey:@"do_title"]];
        NSRange range = [fileName rangeOfString:_searchFile];
        if (range.location != NSNotFound) {
            NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:fileName];
            [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            cell.titleLabel.attributedText = caseString;
        }
        else{
            cell.titleLabel.text = fileName;
        }
        
        NSString *caseName = [NSString stringWithFormat:@"%@",[record objectForKey:@"do_creator_name"]];
        NSRange range1 = [caseName rangeOfString:_searchName];
        if (range1.location != NSNotFound) {
            NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:caseName];
            [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
            cell.detailLabel.attributedText = caseString;
        }
        else{
            cell.detailLabel.text = caseName;
        }
    }

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_documentAuditType == DocumentAuditTypeUndone) {
        _docuDetailViewController = [[DocuDetailViewController alloc] init];
        NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        
        if (curTag == 0) {
            NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
            
            NSDictionary *item = [datas objectAtIndex:indexPath.row];
            _docuDetailViewController.papered = [item objectForKey:@"do_doc_id"];
        }
        else if (curTag == 1){
            NSArray *datas = (NSArray*)[temDic objectForKey:@"doc_list"];
            NSDictionary *item = [datas lastObject];
            _docuDetailViewController.papered = [item objectForKey:@"do_doc_id"];
        }
        
        
    }
    else if (_documentAuditType == DocumentAuditTypeDone){
        _docuDetailViewController = [[DocuDetailViewController alloc] init];
        NSDictionary *record = nil;
        if (curTag == 0) {
            NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *datas = (NSArray*)[item objectForKey:@"data"];
            record = [datas objectAtIndex:indexPath.row];
        }
        else{
            NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            
            NSArray *list = [item objectForKey:@"doc_list"];
            record = [list objectAtIndex:indexPath.row];
        }
        
        _docuDetailViewController.papered = [record objectForKey:@"do_doc_id"];
        _docuDetailViewController.isHideButton = YES;
    }

    [self.navigationController pushViewController:_docuDetailViewController animated:YES];
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
            NSString *time = [item objectForKey:@"do_create_date"];
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
                NSString *time = [item objectForKey:@"do_create_date"];
                 
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
    
    
    
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}


/*
 {
 "ca_case_id" = FG2014BJ010;
 "ca_case_name" = "\U5fb7\U60524";
 "ca_doc_count" = 3;
 "doc_list" =             (
 {
 approveMemo = "";
 "do_case_id" = FG2014BJ010;
 "do_category" = "\U5f8b\U5e08\U5de5\U4f5c\U6587\U4ef6-\U8c03\U67e5\U62a5\U544a";
 "do_create_date" = "2015-01-22";
 "do_create_date_full" = "2015-01-22 12:56:06";
 "do_doc_id" = 0000005529;
 "do_iscollect" = 0;
 "do_location" = "";
 "do_status" = W;
 "do_title" = "\U8f6f\U4ef6\U5f00\U53d1\U9700\U6c42\U5206\U6790\U53c2\U8003\U6587\U6863.doc";
 "do_url" = "http://test.elinklaw.com/system/downloadfile.aspx?DownType=NEWCASE&DocumentID=0000005529";
 },
 
 
 approveMemo = "";
 "do_case_id" = FG2014BJ010;
 "do_case_name" = "\U5fb7\U60524";
 "do_category" = "\U5f8b\U5e08\U5de5\U4f5c\U6587\U4ef6-\U8c03\U67e5\U62a5\U544a";
 "do_create_date" = "2015-01-22";
 "do_create_date_full" = "2015-01-22 12:56:06";
 "do_doc_id" = 0000005529;
 "do_iscollect" = 0;
 "do_location" = "";
 "do_status" = W;
 "do_title" = "\U8f6f\U4ef6\U5f00\U53d1\U9700\U6c42\U5206\U6790\U53c2\U8003\U6587\U6863.doc";
 "do_url" = "http://test.elinklaw.com/system/downloadfile.aspx?Dow
 

 */
@end
