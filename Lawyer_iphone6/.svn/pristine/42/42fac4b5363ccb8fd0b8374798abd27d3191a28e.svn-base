//
//  ClientViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-9.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ClientViewController.h"

#import "NSString+Utility.h"

#import "HttpClient.h"

#import "ClientCell.h"

#import "RootViewController.h"
#import "ClientIncreaseViewController.h"


@interface ClientViewController ()<RequestManagerDelegate,PullToRefreshDelegate,SearchFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_searchHttpClient;
    
    ClientIncreaseViewController *_clientIncreaseViewController;
    RootViewController *_rootViewController;
}

@end

@implementation ClientViewController

@synthesize searchKey = _searchKey;


- (NSDictionary*)requestParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"fastquery",
                            @"",@"cl_client_id",
                            @"",@"cl_area",
                            @"",@"cl_import_client",
                            @"",@"sortField",
                            _searchKey,@"cl_client_name",
                            @"",@"cl_type",
                            @"",@"cl_guojia",
                            @"",@"cl_create_date_b",
                            @"",@"cl_create_date_e",
                            @"",@"cl_address",
                            @"",@"cl_industry",
                            @"",@"last_request_date",nil];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"clientquery",@"requestKey",@"1",@"currentPage",@"1000",@"pageSize",fields,@"fields", nil];
    return params;
}


- (void)touchAddEvent{
    //_clientIncreaseViewController = [[ClientIncreaseViewController alloc] initWithNibName:@"ClientIncreaseViewController" bundle:nil];
    _clientIncreaseViewController.clientIncreaseType = ClientIncreaseTypeNormal;
    [self.navigationController pushViewController:_clientIncreaseViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"客户" color:nil];
    
    [self setDismissButton];
   // [self setRightButton:[UIImage imageNamed:@"nav_add_btn.png"] title:nil target:self action:@selector(touchAddEvent)];
    
    [self showSearchBar];
    self.searchField.delegate = self;
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    self.bottomRefreshIndicator.pullToRefreshDelegate = self;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    UINib *nib = [UINib nibWithNibName:@"ClientCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ClientCell"];

    
    _searchHttpClient = [[HttpClient alloc] init];
    _searchHttpClient.delegate = self;
    
    if (_searchKey.length == 0) {
        _searchKey = @"";
    }
    [self.searchField setTitle:_searchKey];
    [_searchHttpClient startRequest:[self requestParam]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

#pragma mark -- SearchFieldDelegate

- (void)searchStart:(NSString*)key{
    [self clearTableData];
    [self.tableView reloadData];
    _searchKey = key;
    if (_searchKey.length == 0) {
        _searchKey = @"";
    }
    
    [_searchHttpClient startRequest:[self requestParam]];
}

#pragma mark - UITableViewDataSource

- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.tableWords;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableWords count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.tableWords  count] > 0) {
        return [self.tableWords objectAtIndex:section];
    }
    return @"";
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 23)];
    view.backgroundColor = [@"f1f1f1" colorValue];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 23)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    [view addSubview:titleLabel];
    
    if ([self.tableWords  count] > 0) {
        NSString *title = [self.tableWords objectAtIndex:section];
        titleLabel.text = title;
        return view;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 23;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
    NSArray *values = [dic allValues];
    
    return [[values objectAtIndex:0] count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientCell"];
    
    NSDictionary *item = nil;
    cell.textLabel.attributedText = nil;
    cell.contentView.backgroundColor = [@"#f9f9f9" colorValue];
    if (self.tableDatas.count > 0) {
        NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        NSArray *values = [dic allValues];
        
        item = (NSDictionary*)[[values objectAtIndex:0] objectAtIndex:indexPath.row];
        cell.detailLabel.text = [NSString stringWithFormat:@"客户编号：%@",[item objectForKey:@"cl_client_id"]];
        if (_searchKey.length > 0) {
            NSString *name = [NSString stringWithFormat:@"%@",[item objectForKey:@"cl_client_name"]];
            NSRange range = [name rangeOfString:_searchKey];
            if (range.location != NSNotFound) {
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[item objectForKey:@"cl_client_name"]];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
                cell.titleLabel.attributedText = string;
            }
        }
        else{
            cell.titleLabel.text = [item objectForKey:@"cl_client_name"];
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
    NSArray *values = [dic allValues];
    
    NSDictionary *item = (NSDictionary*)[[values objectAtIndex:0] objectAtIndex:indexPath.row];
    
    _rootViewController = [[RootViewController alloc] init];
    
    [self presentViewController:_rootViewController animated:YES completion:nil];
    [_rootViewController showInClientDetail];
    _rootViewController.clientDetailViewController.clientId = [item objectForKey:@"cl_client_id"];
    
}

#pragma mark -- RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    NSString *mgid = [result objectForKey:@"mgid"];
    if (request == _searchHttpClient) {
        if ([mgid isEqualToString:@"true"]) {
            if ([[result objectForKey:@"record_list"] count] > 0) {
                NSArray *datas = [result objectForKey:@"record_list"];
                
                NSMutableArray *temp = [[NSMutableArray alloc] init];
                for (int i = 0; i < datas.count; i++) {
                    NSDictionary *item = (NSDictionary*)[datas objectAtIndex:i];
                    NSString *name = (NSString*)[item objectForKey:@"cl_client_name"];
                    if (name.length != 0) {
                        NSString *word = [name firstLetterWord:name];
                        if (![temp containsObject:word]) {
                            [temp addObject:word];
                        }
                    }
                    
                }
                self.tableWords = (NSMutableArray*)[temp sortedArrayUsingSelector:@selector(compare:)];
                
                for (NSString *word in self.tableWords) {
                    NSMutableArray *item = [[NSMutableArray alloc] init];
                    for (int i = 0; i < datas.count; i++) {
                        NSDictionary *itemTemp = (NSDictionary*)[datas objectAtIndex:i];
                        NSString *name = (NSString*)[itemTemp objectForKey:@"cl_client_name"];
                        if (name.length > 0) {
                            if ([word isEqualToString:[name firstLetterWord:name]]) {
                                if (![item containsObject:itemTemp]) {
                                    [item addObject:itemTemp];
                                }
                            }
                        }
                       
                    }
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:item,word, nil];
                    if (![self.tableDatas containsObject:dic]) {
                        [self.tableDatas addObject:dic];
                    }
                }
                [self.topRefreshIndicator didLoadComplete:nil];
                [self.bottomRefreshIndicator didLoadComplete:nil];
                [self.tableView reloadData];
                
            }
            else{
                [self showHUDWithTextOnly:@"无相关数据"];
                [self clearTableData];
                [self.tableView reloadData];
            }
            
        }
        else{
            [self showHUDWithTextOnly:@"请求失败"];
        }
    }
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
        [_searchHttpClient startRequest:[self requestParam]];
        
    }
    else{

        [self.bottomRefreshIndicator didLoadComplete:nil];
    }
    
    
}


@end
