//
//  NewsViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "NewsViewController.h"

#import "HttpClient.h"
#import "CommomClient.h"
#import "NSString+Utility.h"

#import "NewsCell.h"

#import "NewsDetailViewController.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate,SegmentViewDelegate,RequestManagerDelegate,PullToRefreshDelegate>{
    NewsDetailViewController *_newsDetailViewController;
    
    HttpClient *_newsHttpClient;
    HttpClient *_noticeHttpClient;
    
    int currentPage;
    NSInteger curTag;
}

@end

@implementation NewsViewController

@synthesize newType = _newType;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    [self setDismissButton];
    [self setTitleView:[NSArray arrayWithObjects:@"新闻",@"公告", nil]];
    self.titleSegment.delegate = self;
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [@"#F9F9F9" colorValue];
    self.tableView.rowHeight = 60;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UINib *cellNib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"NewsCell"];
    
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    self.bottomRefreshIndicator.pullToRefreshDelegate = self;
    
    
    
    _newsHttpClient = [[HttpClient alloc] init];
    _newsHttpClient.delegate = self;
    
    _noticeHttpClient = [[HttpClient alloc] init];
    _noticeHttpClient.delegate = self;
}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    [self clearTableData];
    curTag = button.tag;
    
    [self.tableView reloadData];
    
    if (button.tag == 0) {
        _newType = NewTypeNews;
        [_newsHttpClient startRequest:[self listParam:@"newsgetList"]];
    }
    else if (button.tag == 1){
        _newType = NewTypeNotice;
        [_noticeHttpClient startRequest:[self listParam:@"noticegetList"]];
    }
}


- (NSDictionary*)listParam:(NSString*)key{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            [[CommomClient sharedInstance] getAccount], @"userID",
                            nil];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            key,@"requestKey",
                            fields,@"fields",
                            @"15",@"pageSize",
                            [NSString stringWithFormat:@"%d",currentPage],@"currentPage",
                            nil];
    return params;
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    if (self.tableDatas.count > 0) {
        NSDictionary *mapping = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        cell.titleLabel.text = [mapping objectForKey:@"blt_title"];
        cell.statusLabel.text = [mapping objectForKey:@"blt_type"];
        cell.timeLabel.text = [mapping objectForKey:@"blt_date"];
        
        
        if ([[mapping objectForKey:@"blt_is_important"] isEqualToString:@"False"]) {
            cell.importImageView.hidden = YES;
        }
        else{
            cell.importImageView.hidden = NO;
        }
        
        NSInteger count = [[mapping objectForKey:@"blt_attachment_cnt"] integerValue];
        
        if (count > 0) {
            cell.attachImageView.hidden = NO;
            if (cell.importImageView.hidden) {
                cell.left1.constant = 25;
            }
            else {
                cell.left1.constant = 36;
            }
        }
        else{
            cell.attachImageView.hidden = YES;
        }
        
        if (cell.importImageView.hidden && !cell.attachImageView.hidden) {
            cell.titleLayoutRight.constant = 60;
            
            
            for (NSLayoutConstraint *layout in cell.contentView.constraints) {
                if (layout.firstItem == cell.attachImageView && layout.secondItem == cell.titleLabel) {
                    layout.constant = 11;
                }
            }
        }
        else if (cell.importImageView.hidden && cell.attachImageView.hidden){
            cell.titleLayoutRight.constant = 20;
        }
        else{
            cell.titleLayoutRight.constant = 80;
        }
        
        
        if (![[mapping objectForKey:@"blt_status"] isEqualToString:@"X"]) {
            cell.titleLabel.textColor = [UIColor grayColor];
            cell.statusLabel.textColor = [UIColor grayColor];
            cell.timeLabel.textColor = [UIColor grayColor];
        }
        else{
            cell.titleLabel.textColor = [UIColor blackColor];
            cell.statusLabel.textColor = [UIColor blackColor];
            cell.timeLabel.textColor = [UIColor blackColor];
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *mapping = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    _newsDetailViewController = [[NewsDetailViewController alloc] init];
    if (_newType == NewTypeNews) {
        _newsDetailViewController.key = @"newsgetDetail";
        _newsDetailViewController.newType = NewTypeNews;
    }
    else if (_newType == NewTypeNotice){
        _newsDetailViewController.newType = NewTypeNotice;
        _newsDetailViewController.key = @"noticegetDetail";
    }

    _newsDetailViewController.titleID = [mapping objectForKey:@"blt_bulletin_id"];
    [self.navigationController pushViewController:_newsDetailViewController animated:YES];
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    
    if (request == _newsHttpClient || request == _noticeHttpClient) {
        for (NSDictionary *item in [result objectForKey:@"record_list"]) {
            if (![self.indexSet containsObject:[item objectForKey:@"blt_bulletin_id"]]) {
                [self.indexSet addObject:[item objectForKey:@"blt_bulletin_id"]];
                [self.tableDatas addObject:item];
            }
        }
    }
    else if (request == _noticeHttpClient) {
        
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
        currentPage = 1;
        [self clearTableData];
    }
    else{
        currentPage = 1 + currentPage;
    }
    
    
    if (_newType == NewTypeNews) {
        [_newsHttpClient startRequest:[self listParam:@"newsgetList"]];
    }
    else if (_newType == NewTypeNotice){
        [_noticeHttpClient startRequest:[self listParam:@"noticegetList"]];
    }
}

@end
