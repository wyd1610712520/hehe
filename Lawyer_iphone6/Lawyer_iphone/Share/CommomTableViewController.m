//
//  CommomTableViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-9-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"



@interface CommomTableViewController (){
    

}

@end

@implementation CommomTableViewController

@synthesize topRefreshIndicator = _topRefreshIndicator;
@synthesize bottomRefreshIndicator = _bottomRefreshIndicator;

@synthesize tableDatas = _tableDatas;
@synthesize indexSet = _indexSet;

@synthesize searchField = _searchField;
@synthesize segmentView = _segmentView;
@synthesize customSegment = _customSegment;
@synthesize tableDic = _tableDic;
@synthesize tableWords = _tableWords;

- (void)showSearchBar{
    _searchField = [[SearchField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [self.view addSubview:_searchField];

    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, _searchField.frame.size.height-1, self.view.frame.size.width, 1);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_searchField addSubview:lineView];
    
    
    
}

- (void)hideSearchBar{
    [_searchField removeFromSuperview];
    _searchField = nil;
    
    CGRect frame = _tableView.frame;
    frame.origin.y = 0;
    frame.size.height = self.view.frame.size.height;
    _tableView.frame = frame;
}

- (void)showSegment:(NSArray*)titles{
    _segmentView = [[SegmentView alloc] initWithTitle:titles];
    _segmentView.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 35);

    [self.view addSubview:_segmentView];
    
}

- (void)setSegmentTitles:(NSArray*)titles frame:(CGRect)frame{
    NSArray *datas = [[NSArray alloc] initWithArray:titles];
    _customSegment = [[CustomSegment alloc] initWithFrame:frame];
    [_customSegment setSegmentWithTitles:datas];
    [self.view addSubview:_customSegment];
  
}

- (void)showTable{
    if (_segmentView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _segmentView.frame.size.height + _segmentView.frame.origin.y + 10, self.view.frame.size.width, self.view.frame.size.height - _segmentView.frame.size.height-_segmentView.frame.origin.y-10) style:UITableViewStylePlain];
        
    }
    else if (_customSegment){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _customSegment.frame.size.height + _customSegment.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - _customSegment.frame.size.height-_customSegment.frame.origin.y) style:UITableViewStylePlain];

    }
    else if (_searchField){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchField.frame.size.height+_searchField.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-_searchField.frame.size.height-_searchField.frame.origin.y-1) style:UITableViewStylePlain];
    }
    else{
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    }
    
    
    [self.view addSubview:_tableView];
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    UIColor* textColor = [UIColor blackColor];
    _topRefreshIndicator = [[PullToRefreshIndicator alloc] initWithPosition:PullPositionAtTop scrollView:_tableView];
    [_topRefreshIndicator setupTipFontSize:14 color:textColor];
    [_topRefreshIndicator setupArrow:[UIImage imageNamed:@"PullToRefreshArrorw.png"] offset:5 spacing:15];
    [_topRefreshIndicator setActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_topRefreshIndicator setupTip:@"下拉刷新..." forState:PullStatePulling];
    [_topRefreshIndicator setupTip:@"释放即可刷新..." forState:PullStateRelease];
    [_topRefreshIndicator setupTip:@"载入中..." forState:PullStateLoading];
    [_topRefreshIndicator setupTip:@"载入失败..." forState:PullStateError];
    NSDateFormatter *defaultDateFormatter = [[NSDateFormatter alloc] init];
    [defaultDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    _topRefreshIndicator.lastUpdateTip = @"上次刷新时间";
    _topRefreshIndicator.relativeDate = YES;
    [_topRefreshIndicator enableLastUpdateTip:textColor fontSize:10.0 dateFormatter:defaultDateFormatter];
    
    
    [_bottomRefreshIndicator removeFromSuperview];
    _bottomRefreshIndicator = [[PullToRefreshIndicator alloc] initWithPosition:PullPositionAtBottom scrollView:_tableView];
    _bottomRefreshIndicator.isDirectLoad = NO;
    [_bottomRefreshIndicator setupTipFontSize:14 color:textColor];
    [_bottomRefreshIndicator setupArrow:nil offset:0 spacing:15 + 13];
    [_bottomRefreshIndicator setActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_bottomRefreshIndicator setupTip:@"查看更多" forState:PullStateRelease];
    [_bottomRefreshIndicator setupTip:@"载入中..." forState:PullStateLoading];
    [_bottomRefreshIndicator setupTip:@"载入失败..." forState:PullStateError];
    _bottomRefreshIndicator.tipLabel.hidden = YES;
    [self clearTableData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)clearTableData{
    [_tableDatas removeAllObjects];
    [_indexSet removeAllObjects];
    [_tableDic removeAllObjects];
    _tableWords = nil;
    _tableDatas = nil;
    _tableDic = nil;
    _indexSet = nil;
    _tableWords = [[NSMutableArray alloc] init];
    _tableDic = [[NSMutableDictionary alloc] init];
    _tableDatas = [[NSMutableArray alloc] init];
    _indexSet = [[NSMutableSet alloc] init];
    
}



@end
