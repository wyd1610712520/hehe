//
//  ContactViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ContactViewController.h"

#import "ContactCell.h"



#import "HttpClient.h"

#import "CommomClient.h"
#import "Hanzi.h"
#import "NameIndex.h"

#import "ContactPersonViewController.h"

#import "NSString+Utility.h"

@interface ContactViewController ()<UITableViewDataSource,UITableViewDelegate,SegmentViewDelegate,UISearchDisplayDelegate,RequestManagerDelegate>{
    NSArray *_filterData;
    UISearchDisplayController *_searchDisplayController;
    UISearchBar *_searchBar;
    
    
    
    HttpClient *_clientHttpClient;
    
    HttpClient *_departHttpClient;
    UILocalizedIndexedCollation *_theCollation;
    
    NSMutableArray *_datas;
    
    NSInteger _tag;
    
    ContactPersonViewController *_contactPersonViewController;
}

@end

@implementation ContactViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _departHttpClient = [[HttpClient alloc] init];
    _departHttpClient.delegate = self;
    
    _clientHttpClient = [[HttpClient alloc] init];
    _clientHttpClient.delegate = self;

    
}

- (NSDictionary*)departParam{
    NSDictionary *fileds = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"searchName", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"deptcontactlist",@"requestKey",fileds,@"fields", nil];
    return param;
}

- (NSDictionary*)clientParam{
    NSDictionary *fileds = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"searchName", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"clientcontactlist",@"requestKey",fileds,@"fields", nil];
    return param;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setTitleView:[NSArray arrayWithObjects:@"客户通讯录",@"单位通讯录", nil]];
    self.titleSegment.delegate = self;
    
    self.navigationController.navigationBar.translucent = NO;
    
    _datas = [[NSMutableArray alloc] init];
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [@"#F9F9F9" colorValue];
    self.tableView.rowHeight = 60;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    UINib *cellNib = [UINib nibWithNibName:@"ContactCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ContactCell"];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,44)];
    _searchBar.placeholder = @"搜索";
    [self.view addSubview:_searchBar];
    
    CGRect frame = self.tableView.frame;
    frame.origin.y = _searchBar.frame.size.height+_searchBar.frame.origin.y;
    frame.size.height = self.view.frame.size.height - _searchBar.frame.size.height;
    self.tableView.frame = frame;
    
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    CGRect frame1 = _searchDisplayController.searchContentsController.view.frame;
    frame1.origin.y = 20;
    _searchDisplayController.searchContentsController.view.frame = frame1;
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    _searchDisplayController.delegate = self;
    
    

}


- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    _tag = button.tag;
    if (button.tag == 0) {
        [_clientHttpClient startRequest:[self clientParam]];
    }
    else if (button.tag == 1){
        [_departHttpClient startRequest:[self departParam]];
    }
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    [_searchBar setShowsCancelButton:YES animated:NO];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        for (UIView *subView in [[_searchBar.subviews objectAtIndex:0] subviews]){
            if([subView isKindOfClass:[UIButton class]]){
                [(UIButton*)subView setTitle:@"取消" forState:UIControlStateNormal];
            }
        }
    }
    else
    {
        for (UIView *subView in _searchBar.subviews){
            if([subView isKindOfClass:[UIButton class]]){
                [(UIButton*)subView setTitle:@"取消" forState:UIControlStateNormal];
            }
        }
    }
    CGRect frame = _searchBar.frame;
    frame.origin.y = 20;
    _searchBar.frame =frame;
}

- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    CGRect frame = _searchBar.frame;
    frame.origin.y = 0;
    _searchBar.frame =frame;
}

#pragma mark -UITableViewDataSource

- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (_tag == 0) {
        
    }
    else if (_tag == 1){
        
    }
    if (tableView == self.tableView) {
        return self.tableWords;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return [self.tableWords count];
    }
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (tableView == self.tableView) {
//        if ([self.tableWords  count] > 0) {
//            return [self.tableWords objectAtIndex:section];
//        }
//    }
//    
//    return nil;
//}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)];
    view.backgroundColor = [@"#F9F9F9" colorValue];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-10, 22)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    
    [view addSubview:titleLabel];
    
    if (tableView == self.tableView) {
        if ([self.tableWords  count] > 0) {
            titleLabel.text= [self.tableWords objectAtIndex:section];
        }
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == self.tableView) {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
        NSArray *values = [dic allValues];

        return [[values objectAtIndex:0] count];
    }else{
        NSString *searchKey = [NSString stringWithFormat:@"%@",_searchDisplayController.searchBar.text];
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        
        if (_tag == 0) {
            for (NSDictionary *mapping in _datas) {
                NSRange range = [[mapping objectForKey:@"clr_client_name"] rangeOfString:searchKey];
                if (range.length > 0) {
                    [temp addObject:mapping];
                }
                
            }
            _filterData =  temp;
        }
        else if (_tag == 1){
            for (NSDictionary *mapping in _datas) {
                NSRange range = [[mapping objectForKey:@"dept_name"] rangeOfString:searchKey];
                if (range.length > 0) {
                    [temp addObject:mapping];
                }
                
            }
            _filterData =  temp;
        }
        
        return _filterData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    
    if (_tag == 0) {
        if (tableView == self.tableView) {
            NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *values = [dic allValues];

            NSDictionary *mapping = (NSDictionary*)[[values objectAtIndex:0] objectAtIndex:indexPath.row];
            cell.titleLabel.text = [mapping objectForKey:@"clr_client_name"];
            cell.numLabel.text = [NSString stringWithFormat:@"客户编号:%@",[mapping objectForKey:@"clr_client_id"]];
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cells"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, cell.frame.size.width-20, 20)];
                hintLabel.textColor = [UIColor blackColor];
                hintLabel.font = [UIFont systemFontOfSize:16];
                hintLabel.tag = 1001;
                
                
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 34, 210, 15)];
                titleLabel.textColor = [UIColor darkGrayColor];
                titleLabel.font = [UIFont systemFontOfSize:12];
                titleLabel.tag = 1002;
                
                [cell addSubview:hintLabel];
                [cell addSubview:titleLabel];
            }
            
            UILabel *hintLabel = (UILabel*)[cell viewWithTag:1001];
            UILabel *titleLabel = (UILabel*)[cell viewWithTag:1002];

            NSDictionary *mapping = (NSDictionary*)[_filterData objectAtIndex:indexPath.row];
            NSString *searchKey = [NSString stringWithFormat:@"%@",_searchDisplayController.searchBar.text];
            
            NSString *name = [NSString stringWithFormat:@"%@",[mapping objectForKey:@"clr_client_name"]];
            NSRange range = [name rangeOfString:searchKey];
            
            if (range.location != NSNotFound) {
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:name];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
                hintLabel.attributedText = string;
            }
            else{
                hintLabel.text = name;
            }
            
            titleLabel.text = [NSString stringWithFormat:@"客户编号:%@",[mapping objectForKey:@"clr_client_id"]];
            
            return cell;
        }

    }
    else if (_tag == 1){
        if (tableView == self.tableView) {
            NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *values = [dic allValues];
            NSDictionary *mapping = (NSDictionary*)[[values objectAtIndex:0] objectAtIndex:indexPath.row];
            cell.titleLabel.text = [mapping objectForKey:@"dept_name"];
            cell.numLabel.text = [NSString stringWithFormat:@"部门编号:%@",[mapping objectForKey:@"dept_id"]];
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, cell.frame.size.width-20, 20)];
                hintLabel.textColor = [UIColor blackColor];
                hintLabel.font = [UIFont systemFontOfSize:16];
                hintLabel.tag = 1001;
                
                
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 34, 210, 15)];
                titleLabel.textColor = [UIColor darkGrayColor];
                titleLabel.font = [UIFont systemFontOfSize:12];
                titleLabel.tag = 1002;
                
                [cell addSubview:hintLabel];
                [cell addSubview:titleLabel];
            }
            UILabel *hintLabel = (UILabel*)[cell viewWithTag:1001];
            UILabel *titleLabel = (UILabel*)[cell viewWithTag:1002];
            
            NSDictionary *mapping = (NSDictionary*)[_filterData objectAtIndex:indexPath.row];
            NSString *searchKey = [NSString stringWithFormat:@"%@",_searchDisplayController.searchBar.text];
            
            NSString *name = [NSString stringWithFormat:@"%@",[mapping objectForKey:@"dept_name"]];
            NSRange range = [name rangeOfString:searchKey];
            
            if (range.location != NSNotFound) {
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:name];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
                hintLabel.attributedText = string;
            }
            else{
                hintLabel.text = name;
            }
            
            
            
            titleLabel.text = [NSString stringWithFormat:@"部门编号:%@",[mapping objectForKey:@"dept_id"]];
            
            return cell;
        }

    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _contactPersonViewController = [[ContactPersonViewController alloc] init];
    if (_tag == 0) {
        NSDictionary *mapping = nil;
        
        if (tableView == self.tableView) {
            NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *values = [dic allValues];
            if ([values count]> 0) {
                mapping = (NSDictionary*)[[values objectAtIndex:0] objectAtIndex:indexPath.row];
            }
            
        }
        else{
            mapping = (NSDictionary*)[_filterData objectAtIndex:indexPath.row];
            
        }
        _contactPersonViewController.contactType = ContactTypePerson;
        if ([[mapping objectForKey:@"contact_list"] count] > 0) {
            _contactPersonViewController.contactList = [mapping objectForKey:@"contact_list"];
            [self.navigationController pushViewController:_contactPersonViewController animated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"此客户没有相关联系人"];
        }
        
        
    }
    else if (_tag == 1){
        NSDictionary *mapping = nil;
        if (tableView == self.tableView) {
            NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *values = [dic allValues];
            if ([values count]> 0) {
                mapping = (NSDictionary*)[[values objectAtIndex:0] objectAtIndex:indexPath.row];
            }
            
        }
        else{
            mapping = (NSDictionary*)[_filterData objectAtIndex:indexPath.row];
            
        }
        _contactPersonViewController.contactType = ContactTypeDepart;
        _contactPersonViewController.departID = [mapping objectForKey:@"dept_id"];
        _contactPersonViewController.departTitle = [mapping objectForKey:@"dept_name"];
        _contactPersonViewController.derptDatas = mapping;
        [self.navigationController pushViewController:_contactPersonViewController animated:YES];
    }
    
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    [self clearTableData];
    [_datas removeAllObjects];
    if (request == _departHttpClient) {
        
        
        for (NSDictionary *mapping in [result objectForKey:@"record_list"]) {
            if (![self.indexSet containsObject:[mapping objectForKey:@"dept_id"]]) {
                [self.indexSet containsObject:[mapping objectForKey:@"dept_id"]];
                [_datas addObject:mapping];
            }
        }

        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int i = 0; i < [[result objectForKey:@"record_list"] count]; i++) {
            NSDictionary *mapping = (NSDictionary*)[[result objectForKey:@"record_list"] objectAtIndex:i];
            NSString *name = [mapping objectForKey:@"dept_name"];
            NSString *word = [name firstLetterWord:name];
            if (![temp containsObject:word]) {
                [temp addObject:word];
            }
        }

        self.tableWords = (NSMutableArray*)[temp sortedArrayUsingSelector:@selector(compare:)];
        
        for (NSString *word in self.tableWords) {
            NSMutableArray *item = [[NSMutableArray alloc] init];
            for (int i = 0; i < [[result objectForKey:@"record_list"] count]; i++) {
                NSDictionary *mapping = (NSDictionary*)[[result objectForKey:@"record_list"] objectAtIndex:i];
                NSString *name = [mapping objectForKey:@"dept_name"];
                if ([word isEqualToString:[name firstLetterWord:name]]) {
                    if (![item containsObject:mapping]) {
                        [item addObject:mapping];
                    }
                }
            }
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:item,word, nil];
            if (![self.tableDatas containsObject:dic]) {
                [self.tableDatas addObject:dic];
            }
        }
        [self.tableView reloadData];
    }
    else if (request == _clientHttpClient){
        [self.tableWords removeAllObjects];
        for (NSDictionary *mapping in [result objectForKey:@"record_list"]) {
            if (![self.indexSet containsObject:[mapping objectForKey:@"clr_client_id"]]) {
                [self.indexSet containsObject:[mapping objectForKey:@"clr_client_id"]];
                [_datas addObject:mapping];
            }
        }
        
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int i = 0; i < _datas.count; i++) {
            NSDictionary *mapping = (NSDictionary*)[_datas objectAtIndex:i];
            NSString *name = [mapping objectForKey:@"clr_client_name"];
            NSString *word = [name firstLetterWord:name];
            if (![temp containsObject:word]) {
                [temp addObject:word];
            }
        }
        
        self.tableWords = (NSMutableArray*)[temp sortedArrayUsingSelector:@selector(compare:)];
        
        for (NSString *word in self.tableWords) {
            NSMutableArray *item = [[NSMutableArray alloc] init];
            for (int i = 0; i < _datas.count; i++) {
                NSDictionary *mapping = (NSDictionary*)[_datas objectAtIndex:i];
                NSString *name = [mapping objectForKey:@"clr_client_name"];
                if ([word isEqualToString:[name firstLetterWord:name]]) {
                    if (![item containsObject:mapping]) {
                        [item addObject:mapping];
                    }
                }
            }
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:item,word, nil];
            if (![self.tableDatas containsObject:dic]) {
                [self.tableDatas addObject:dic];
            }
        }
        [self.tableView reloadData];
    }
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
