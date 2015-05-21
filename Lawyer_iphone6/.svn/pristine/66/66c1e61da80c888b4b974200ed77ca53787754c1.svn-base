//
//  AuditViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "AuditViewController.h"
#import "NSString+Utility.h"

#import "AuditCell.h"
#import "HttpClient.h"

#import "RootViewController.h"

@interface AuditViewController ()<SegmentViewDelegate,RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    
    NSArray *_auditDatas;
    NSArray *_unAuditDatas;
    
    NSInteger curTag;
    
    NSDictionary *_record;
    
    RootViewController *_rootViewController;
}

@end

@implementation AuditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setTitle:@"审核" color:nil];
    
    [self showSegment:[NSArray arrayWithObjects:@"待审核",@"已审核", nil]];
    self.segmentView.isShow = NO;
    self.segmentView.isTouchEvent = YES;
    self.segmentView.backgroundColor = [@"#F9F9F9" colorValue];
    self.segmentView.delegate = self;
    
    CGRect frame = self.segmentView.frame;
    frame.origin.y = 5;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x*2;
    self.segmentView.frame = frame;
    
    
    _auditDatas = [[NSArray alloc] initWithObjects:@"待审核案件",@"待审核文书",@"待审核工作日志", nil];
    _unAuditDatas = [[NSArray alloc] initWithObjects:@"已审核案件",@"已审核文书",@"已审核工作日志", nil];
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 50;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *cellNib = [UINib nibWithNibName:@"AuditCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"AuditCell"];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;

    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"attation",@"requestKey", nil];
    [_httpClient startRequest:dic];
}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    curTag = button.tag;
    if (button.tag == 0) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"attation",@"requestKey", nil];
        [_httpClient startRequest:dic];
    }
    else if (button.tag == 1){
        
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AuditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AuditCell"];
    
    if (curTag == 0) {
        cell.titleLabel.text = [_auditDatas objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            NSString *num = [_record objectForKey:@"caseremindnum"];
            if (num.intValue > 0) {
                cell.noticeButton.hidden = NO;
                [cell.noticeButton setTitle:num forState:UIControlStateNormal];
            }
            else{
                cell.noticeButton.hidden = YES;
            }
        }
        else if (indexPath.row == 1){
            NSString *num = [_record objectForKey:@"documentremindnum"];
            if (num.intValue > 0) {
                cell.noticeButton.hidden = NO;
                [cell.noticeButton setTitle:num forState:UIControlStateNormal];
            }
            else{
                cell.noticeButton.hidden = YES;
            }
        }
        else if (indexPath.row == 2){
            NSString *num = [_record objectForKey:@"dailyremindnum"];
            if (num.intValue > 0) {
                cell.noticeButton.hidden = NO;
                [cell.noticeButton setTitle:num forState:UIControlStateNormal];
            }
            else{
                cell.noticeButton.hidden = YES;
            }
        }
    }
    else{
        cell.titleLabel.text = [_unAuditDatas objectAtIndex:indexPath.row];
        cell.noticeButton.hidden = YES;
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _rootViewController = [[RootViewController alloc] init];
   
    if (curTag == 0) {
        if (indexPath.row == 0) {
            
            [_rootViewController showInCaseAudit];
            _rootViewController.auditCaseViewController.auditCaseState = AuditCaseStateUndone;
            
        }
        else if (indexPath.row == 1) {
            [_rootViewController showInDocumentAudit];
            _rootViewController.documentAuditViewController.documentAuditType = DocumentAuditTypeUndone;
        }
        else if (indexPath.row == 2) {
            
            [_rootViewController showInLogAudit];
            _rootViewController.logAuditViewController.logAuditType = LogAuditTypeUndone;
            [_rootViewController.logAuditViewController setRootView:_rootViewController];
        }
    }
    else{
        if (indexPath.row == 0) {
            [_rootViewController showInCaseAudit];
            _rootViewController.auditCaseViewController.auditCaseState = AuditCaseStateDone;
        }
        else if (indexPath.row == 1) {
            
            [_rootViewController showInDocumentAudit];
            _rootViewController.documentAuditViewController.documentAuditType = DocumentAuditTypeDone;
        }
        else if (indexPath.row == 2) {
          
            [_rootViewController showInLogAudit];
            _rootViewController.logAuditViewController.logAuditType = LogAuditTypeDone;
            [_rootViewController.logAuditViewController setRootView:_rootViewController];
        }
    }
    [self presentViewController:_rootViewController animated:YES completion:nil];
}


#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    _record = [result objectForKey:@"record"];
    
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}


@end
