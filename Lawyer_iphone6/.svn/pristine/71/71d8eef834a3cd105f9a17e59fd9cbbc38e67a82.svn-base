//
//  CheckResultViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CheckResultViewController.h"

#import "CaseCell.h"

#import "HttpClient.h"
#import "CommomClient.h"

#import "RootViewController.h"

@interface CheckResultViewController ()<UITableViewDelegate,UITableViewDataSource,PullToRefreshDelegate,SegmentViewDelegate,RequestManagerDelegate,UITextFieldDelegate>{
    UISearchBar *_searchBar;
    
    HttpClient *_httpClient;
    int _currentPage;
    NSInteger _buttonIndex;
    
    RootViewController *_rootViewController;
}

@end

@implementation CheckResultViewController

@synthesize searchTextField = _searchTextField;
@synthesize cancelButton = _cancelButton;
@synthesize searchKey = _searchKey;
@synthesize alertView = _alertView;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (NSDictionary*)searchParam:(NSString*)type{
    NSDictionary *fileds = [NSDictionary dictionaryWithObjectsAndKeys:_searchTextField.text,@"checkKeyWord",type,@"case_type",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"caseConflictPreflight",@"requestKey",[NSString stringWithFormat:@"%d",_currentPage],@"currentPage",@"10",@"pageSize",fileds,@"fields", nil];
    return param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
        
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    [self showSegment:[NSArray arrayWithObjects:@"正式案件",@"流程中案件", nil]];
    self.segmentView.delegate = self;
    
    CGRect frame = self.segmentView.frame;
    frame.origin.y = 70;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x*2;
    self.segmentView.frame = frame;
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 130;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    UINib *cellNib = [UINib nibWithNibName:@"CaseCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CaseCell"];
    
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    self.bottomRefreshIndicator.pullToRefreshDelegate = self;
    
    UIImageView *leftImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_gray_logo.png"]];
    _searchTextField.leftView=leftImageView;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    _rootViewController = [[RootViewController alloc] init];
    

}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    _currentPage = 1;
    _buttonIndex = button.tag;
    [self clearTableData];
    [self.tableView reloadData];
    if (button.tag == 0) {
        [_httpClient startRequest:[self searchParam:@"1"]];
    }
    else if (button.tag == 1){
        [_httpClient startRequest:[self searchParam:@"0"]];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _currentPage = 1;
    _searchKey = textField.text;
    [self clearTableData];
    [self.tableView reloadData];
    if (_buttonIndex == 0) {
        [_httpClient startRequest:[self searchParam:@"1"]];
    }
    else if (_buttonIndex == 1){
        [_httpClient startRequest:[self searchParam:@"0"]];
    }
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)touchCancelEvent:(id)sender{
    [self.view removeFromSuperview];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tableDatas.count > 0) {
        return self.tableDatas.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CaseCell"];

    if (self.tableDatas.count > 0) {
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        NSString *name = [NSString stringWithFormat:@"%@",[item objectForKey:@"ca_case_name"]];
        NSRange range = [name rangeOfString:_searchKey];
        if (range.location != NSNotFound) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:name];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            cell.titleLabel.attributedText = string;
        }
        else{
            cell.titleLabel.text = name;
        }
        
        NSString *string1 = [NSString stringWithFormat:@"案件编号:%@",[item objectForKey:@"ca_case_id"]];
        NSRange range1 = [string1 rangeOfString:_searchKey];
        if (range1.location != NSNotFound) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:string1];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
            cell.caseLabel.attributedText = string;
        }
        else{
            cell.caseLabel.text = string1;
        }
        
        NSString *string2 = [NSString stringWithFormat:@"客户:%@",[item objectForKey:@"cl_client_name"]];
        NSRange range2 = [string2 rangeOfString:_searchKey];
        if (range2.location != NSNotFound) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:string2];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
            cell.clientLabel.attributedText = string;
        }
        else{
            cell.clientLabel.text = string2;
        }
        
        NSDictionary *person = (NSDictionary*)[[item objectForKey:@"ccri_list"] lastObject];
        if (person.count > 0) {
            
            NSString *string3 = [NSString stringWithFormat:@"对方当事人:%@",[person objectForKey:@"ccri_name"]];
            NSRange range3 = [string3 rangeOfString:_searchKey];
            if (range3.location != NSNotFound) {
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:string3];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range3];
                cell.categoryLabel.attributedText = string;
            }
            else{
                cell.categoryLabel.text = string3;
            }
        }
        
        NSString *string4 = [NSString stringWithFormat:@"负责人:%@",[item objectForKey:@"ca_manager_name"]];
        NSRange range4 = [string4 rangeOfString:_searchKey];
        if (range4.location != NSNotFound) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:string4];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range4];
            cell.chargeLabel.attributedText = string;
        }
        else{
            cell.chargeLabel.text = string4;
        }
        
        NSString *string5 = [NSString stringWithFormat:@"主办律师:%@",[item objectForKey:@"ca_lawyer"]];
        NSRange range5 = [string5 rangeOfString:_searchKey];
        if (range4.location != NSNotFound) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:string5];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range5];
            cell.dateLabel.attributedText = string;
        }
        else{
            cell.dateLabel.text = string5;
        }

        
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    for (NSDictionary *item in [result objectForKey:@"record_list"]) {
        if (![self.indexSet containsObject:[item objectForKey:@"ca_case_id"]]) {
            [self.indexSet addObject:[item objectForKey:@"ca_case_id"]];
            [self.tableDatas addObject:item];
        }
    }
    if (self.tableDatas.count == 0) {
        _alertView.frame = CGRectMake(0, 200, self.view.frame.size.width, 60);
        [self.view addSubview:_alertView];
        self.tableView.hidden = YES;
    }
    else{
        [_alertView removeFromSuperview];
        self.tableView.hidden = NO;
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
    
    
    if (_buttonIndex == 0) {
        [_httpClient startRequest:[self searchParam:@"1"]];
    }
    else if (_buttonIndex == 1){
        [_httpClient startRequest:[self searchParam:@"0"]];
    }
    
    
}


@end
