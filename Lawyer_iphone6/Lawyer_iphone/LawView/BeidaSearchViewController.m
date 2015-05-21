//
//  BeidaSearchViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "BeidaSearchViewController.h"

#import "HttpClient.h"

#import "NSString+Utility.h"

#import "LawRuleCell.h"

#import "BeidaResultViewController.h"

@interface BeidaSearchViewController ()<UITableViewDataSource,UITableViewDelegate,PullToRefreshDelegate,RequestManagerDelegate,UISearchBarDelegate,SearchFieldDelegate>{
    NSMutableArray *_filterData;
    UISearchDisplayController *_searchDisplayController;
    UISearchBar *_searchBar;
    
    HttpClient *_searchHttpClient;
    HttpClient *_httpClient;
    
    BeidaResultViewController *_beidaResultViewController;
    int curPage;
}

@end

@implementation BeidaSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"搜索结果" color:nil];
    
    [self showSearchBar];
    self.searchField.delegate = self;
    self.searchField.tintLabel.text = @"在结果中搜索";
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [@"#F9F9F9" colorValue];
    self.tableView.rowHeight = 75;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *cellNib = [UINib nibWithNibName:@"LawRuleCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawRuleCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    self.bottomRefreshIndicator.pullToRefreshDelegate = self;

//    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,44)];
//    _searchBar.placeholder = @"在结果中搜索";
//    _searchBar.delegate = self;
//    [self.view addSubview:_searchBar];
//    
//    CGRect frame = self.tableView.frame;
//    frame.origin.y = _searchBar.frame.size.height+_searchBar.frame.origin.y;
//    frame.size.height = self.view.frame.size.height - _searchBar.frame.size.height;
//    self.tableView.frame = frame;
    
    
//    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
//    CGRect frame1 = _searchDisplayController.searchContentsController.view.frame;
//    frame1.origin.y = 20;
//    _searchDisplayController.searchContentsController.view.frame = frame1;
//    _searchDisplayController.searchResultsDataSource = self;
//    _searchDisplayController.searchResultsDelegate = self;
//    _searchDisplayController.delegate = self;
//
    curPage = 0;
    
    _filterData = [[NSMutableArray alloc] init];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _searchHttpClient = [[HttpClient alloc] init];
    _searchHttpClient.delegate = self;
    [_searchHttpClient startBeidaRequest:[self searchParam] path:@"LibraryRecordList"];
}

- (NSDictionary*)searchParam{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"20",@"PageSize",[NSString stringWithFormat:@"%d",curPage],@"PageIndex",_lib,@"Library",_category,@"Model.Category",_searchKey,@"Model.Title", nil];
    return param;
}

//- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
//    [_searchBar setShowsCancelButton:YES animated:NO];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
//        for (UIView *subView in [[_searchBar.subviews objectAtIndex:0] subviews]){
//            if([subView isKindOfClass:[UIButton class]]){
//                [(UIButton*)subView setTitle:@"取消" forState:UIControlStateNormal];
//            }
//        }
//    }
//    else
//    {
//        for (UIView *subView in _searchBar.subviews){
//            if([subView isKindOfClass:[UIButton class]]){
//                [(UIButton*)subView setTitle:@"取消" forState:UIControlStateNormal];
//            }
//        }
//    }
//    CGRect frame = _searchBar.frame;
//    frame.origin.y = 20;
//    _searchBar.frame =frame;
//}
//
//- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
//    CGRect frame = _searchBar.frame;
//    frame.origin.y = 0;
//    _searchBar.frame =frame;
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

}

- (void)searchStart:(NSString*)key{
    [self clearTableData];
    if (key.length > 0) {
        _searchKey = [_searchKey stringByAppendingFormat:@"*%@",key];
    }
    else{
        _searchKey = @"";
    }
    
    
    [_httpClient startBeidaRequest:[self searchParam] path:@"LibraryRecordList"];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return self.tableDatas.count;
    }
    else{
//        NSString *searchKey = [NSString stringWithFormat:@"%@",_searchDisplayController.searchBar.text];
//        NSMutableArray *temp = [[NSMutableArray alloc] init];
//        for (NSDictionary *mapping in self.tableDatas) {
//            NSRange range = [[mapping objectForKey:@"Title"] rangeOfString:searchKey];
//            if (range.length > 0) {
//                [temp addObject:mapping];
//            }
//            
//        }
//        _filterData =  temp;
//        return _filterData.count;
        return _filterData.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        LawRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LawRuleCell"];
        if (self.tableDatas.count > 0) {
            NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
            
            NSString *title = [NSString stringWithFormat:@"<font size='4'>%@</font>",[item safeObjectForKey:@"Title"]];
            NSDictionary *textAttributes = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
            
            
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[title dataUsingEncoding:NSUnicodeStringEncoding] options:textAttributes documentAttributes:nil error:nil];
            
            cell.titleLabel.attributedText = attrStr;
            cell.timeLabel.text = [item objectForKey:@"IssueDate"];
        }
        
        
        
        return cell;

    }
    else{
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"law_fa_logo.png"]];
            logoImageView.frame = CGRectMake(10, 13, 41, 41);
            logoImageView.contentMode = UIViewContentModeCenter;
            [cell addSubview:logoImageView];
            
            UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 56,100, 17)];
            hintLabel.textColor = [UIColor lightGrayColor];
            hintLabel.font = [UIFont systemFontOfSize:12];
            hintLabel.tag = 1001;
            
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(61, 13, cell.frame.size.width-100, 39)];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.numberOfLines = 2;
            titleLabel.tag = 1002;
            
            [cell addSubview:hintLabel];
            [cell addSubview:titleLabel];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            

        }
        
        UILabel *hintLabel = (UILabel*)[cell viewWithTag:1001];
        UILabel *titleLabel = (UILabel*)[cell viewWithTag:1002];
        
        NSDictionary *item = (NSDictionary*)[_filterData objectAtIndex:indexPath.row];
        
       // NSString *searchKey = [NSString stringWithFormat:@"%@",_searchDisplayController.searchBar.text];
        
        
        
        NSString *title = [NSString stringWithFormat:@"%@",[item objectForKey:@"Title"]];
       
        
        NSDictionary *textAttributes = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
        
        
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[title dataUsingEncoding:NSUnicodeStringEncoding] options:textAttributes documentAttributes:nil error:nil];
        titleLabel.attributedText = attrStr;
     

        hintLabel.text = [item objectForKey:@"IssueDate"];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
      
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        NSString *gid = [item objectForKey:@"Gid"];
        _beidaResultViewController = [[BeidaResultViewController alloc] init];
        _beidaResultViewController.searchKey = _searchKey;
        _beidaResultViewController.gid = gid;
        _beidaResultViewController.lib = _lib;
        [self.navigationController pushViewController:_beidaResultViewController animated:YES];
    }
    else{
        NSDictionary *item = (NSDictionary*)[_filterData objectAtIndex:indexPath.row];
        NSString *gid = [item objectForKey:@"Gid"];
        _beidaResultViewController.searchKey = _searchKey;
        _beidaResultViewController.gid = gid;
        _beidaResultViewController.lib = _lib;
        [self.navigationController pushViewController:_beidaResultViewController animated:YES];
    }
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    NSDictionary *record = [result objectForKey:@"Data"];
    if (request == _httpClient) {
        for (NSDictionary *item in [record objectForKey:@"Collection"]) {
            [self.tableDatas addObject:item];
        }
    }
    else if (request == _searchHttpClient){
        for (NSDictionary *item in [record objectForKey:@"Collection"]) {
            [self.tableDatas addObject:item];
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
        curPage = 0;
        [self clearTableData];
    }
    else{
        curPage = 1 + curPage;
    }
    
    
    [_searchHttpClient startBeidaRequest:[self searchParam] path:@"LibraryRecordList"];
}
@end
