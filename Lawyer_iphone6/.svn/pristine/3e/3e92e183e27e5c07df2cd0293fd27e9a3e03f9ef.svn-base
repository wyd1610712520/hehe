//
//  ContactPersonViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-23.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ContactPersonViewController.h"

#import "Hanzi.h"
#import "ContactCell.h"
#import "NSString+Utility.h"
#import "CommomClient.h"

#import "ContactDetailViewController.h"

#import "PersonDetailViewController.h"


@interface ContactPersonViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,RequestManagerDelegate>{
    NSArray *_filterData;
    UISearchDisplayController *_searchDisplayController;
    UISearchBar *_searchBar;
    
    HttpClient *_httpClient;
    
    NSMutableArray *_datas;
    
    ContactDetailViewController *_contactDetailViewController;
    
    PersonDetailViewController *_personDetailViewController;
}

@end

@implementation ContactPersonViewController

@synthesize contactType = _contactType;

@synthesize contactList = _contactList;

@synthesize departID = _departID;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    if (_contactType == ContactTypePerson) {
        if ([_contactList count] > 0) {
            
        }
        NSDictionary *mapping = (NSDictionary*)[_contactList objectAtIndex:0];
        
        [self setTitle:[mapping objectForKey:@"clr_client_name"] color:nil];
        
        
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int i = 0; i < _contactList.count; i++) {
            NSDictionary *mapping = (NSDictionary*)[_contactList objectAtIndex:i];
            NSString *name = [mapping objectForKey:@"clr_name"];
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
            for (int i = 0; i < _contactList.count; i++) {
                NSDictionary *mapping = (NSDictionary*)[_contactList objectAtIndex:i];
                NSString *name = [mapping objectForKey:@"clr_name"];
                if (name.length != 0) {
                    if ([word isEqualToString:[name firstLetterWord:name]]) {
                        if (![item containsObject:mapping]) {
                            [item addObject:mapping];
                        }
                    }
                }
                
            }
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:item,word, nil];
            if (![self.tableDatas containsObject:dic]) {
                [self.tableDatas addObject:dic];
            }
        }
        
    }
    else if (_contactType == ContactTypeDepart){
        [self setTitle:_departTitle color:nil];
        [self clearTableData];
        [_datas removeAllObjects];
        
        for (NSDictionary *maping in [_derptDatas objectForKey:@"contact_list"]) {
            if (![self.indexSet containsObject:[maping objectForKey:@"user_id"]]) {
                [self.indexSet containsObject:[maping objectForKey:@"user_id"]];
                [_datas addObject:maping];
            }
        }
        
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int i = 0; i < [[_derptDatas objectForKey:@"contact_list"] count]; i++) {
            NSDictionary *mapping = (NSDictionary*)[[_derptDatas objectForKey:@"contact_list"] objectAtIndex:i];
            NSString *name = [mapping objectForKey:@"user_name"];
            NSString *word = [name firstLetterWord:name];
            if (![temp containsObject:word]) {
                [temp addObject:word];
            }
        }
        
        self.tableWords = (NSMutableArray*)[temp sortedArrayUsingSelector:@selector(compare:)];
        
        for (NSString *word in self.tableWords) {
            NSMutableArray *item = [[NSMutableArray alloc] init];
            for (int i = 0; i < [[_derptDatas objectForKey:@"contact_list"] count]; i++) {
                NSDictionary *mapping = (NSDictionary*)[[_derptDatas objectForKey:@"contact_list"]  objectAtIndex:i];
                NSString *name = [mapping objectForKey:@"user_name"];
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

        
//        _httpClient = [[HttpClient alloc] init];
//        _httpClient.delegate = self;
       // [_httpClient startRequest:[self departParam]];
    }
    

}

//- (NSDictionary*)departParam{
//    NSDictionary *fileds = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getAccount],@"userID",_departID,@"deptId",@"",@"searchName", nil];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"addressUserListQuery",@"requestKey",fileds,@"fields", nil];
//    return param;
//}


         

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [@"#F9F9F9" colorValue];
    self.tableView.rowHeight = 60;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    _searchDisplayController.delegate = self;
    
    
    _datas = [[NSMutableArray alloc] init];
    
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

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

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == self.tableView) {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_contactType == ContactTypePerson) {
        if (tableView == self.tableView) {
            NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
            NSArray *values = [dic allValues];
            return [[values objectAtIndex:0] count];
        }
        else{
            NSString *searchKey = [NSString stringWithFormat:@"%@",_searchDisplayController.searchBar.text];
            NSMutableArray *temp = [[NSMutableArray alloc] init];
            for (NSDictionary *mapping in _contactList) {
                NSRange range = [[mapping objectForKey:@"clr_name"] rangeOfString:searchKey];
                if (range.length > 0) {
                    [temp addObject:mapping];
                }
                
            }
            _filterData =  temp;
            return _filterData.count;
        }
    }
    else if (_contactType == ContactTypeDepart){
        if (tableView == self.tableView) {
            NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
            NSArray *values = [dic allValues];
            return [[values objectAtIndex:0] count];
        }
        else{
            NSString *searchKey = [NSString stringWithFormat:@"%@",_searchDisplayController.searchBar.text];
            NSMutableArray *temp = [[NSMutableArray alloc] init];
             for (NSDictionary *mapping in _datas) {
                NSRange range = [[mapping objectForKey:@"user_name"] rangeOfString:searchKey];
                if (range.length > 0) {
                    [temp addObject:mapping];
                }
                
            }
            _filterData =  temp;
            return _filterData.count;
        }

        
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    
    if (_contactType == ContactTypePerson) {
        if (tableView == self.tableView) {
            NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *values = [dic allValues];
            NSDictionary *mapping = (NSDictionary*)[[values objectAtIndex:0] objectAtIndex:indexPath.row];
            cell.titleLabel.text = [mapping objectForKey:@"clr_name"];
            cell.phoneLabel.text = [mapping objectForKey:@"clr_phone"];
            cell.numLabel.text = [NSString stringWithFormat:@"职位类别：%@",[mapping objectForKey:@"clr_duty"]];
            return cell;

        }
        else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cells"];
                
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
                
                UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-150, 10, 120, 15)];
                phoneLabel.textColor = [UIColor blackColor];
                phoneLabel.font = [UIFont systemFontOfSize:14];
                phoneLabel.tag = 1003;
                [cell addSubview:phoneLabel];
                phoneLabel.textAlignment = NSTextAlignmentRight;
            }
            
            UILabel *hintLabel = (UILabel*)[cell viewWithTag:1001];
            UILabel *titleLabel = (UILabel*)[cell viewWithTag:1002];
            UILabel *phoneLabel = (UILabel*)[cell viewWithTag:1003];
            
            NSDictionary *mapping = (NSDictionary*)[_filterData objectAtIndex:indexPath.row];
            NSString *searchKey = [NSString stringWithFormat:@"%@",_searchDisplayController.searchBar.text];
            
            NSString *name = [NSString stringWithFormat:@"%@",[mapping objectForKey:@"clr_name"]];
            NSRange range = [name rangeOfString:searchKey];
            
            if (range.location != NSNotFound) {
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:name];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
                hintLabel.attributedText = string;
            }
            else{
                hintLabel.text = name;
            }
            
            titleLabel.text = [NSString stringWithFormat:@"职位类别：%@",[mapping objectForKey:@"clr_duty"]];
            
             phoneLabel.text = [mapping objectForKey:@"clr_phone"];
            
            return cell;

        }
    }
    else if (_contactType == ContactTypeDepart){
        if (tableView == self.tableView) {
            NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *values = [dic allValues];
            NSDictionary *mapping = (NSDictionary*)[[values objectAtIndex:0] objectAtIndex:indexPath.row];
            cell.titleLabel.text = [mapping objectForKey:@"user_name"];
            cell.numLabel.text = [NSString stringWithFormat:@"%@",[mapping objectForKey:@"user_category"]];
            cell.phoneLabel.text = [mapping objectForKey:@"user_phone"];
            cell.mobileLabel.text = [mapping objectForKey:@"user_telephone"];
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
                
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
                
                UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-150, 10, 120, 15)];
                phoneLabel.textColor = [UIColor blackColor];
                phoneLabel.font = [UIFont systemFontOfSize:14];
                phoneLabel.tag = 1003;
                phoneLabel.textAlignment = NSTextAlignmentRight;
                [cell addSubview:phoneLabel];
            }
            UILabel *hintLabel = (UILabel*)[cell viewWithTag:1001];
            UILabel *titleLabel = (UILabel*)[cell viewWithTag:1002];
            UILabel *phoneLabel = (UILabel*)[cell viewWithTag:1003];
            
            NSDictionary *mapping = (NSDictionary*)[_filterData objectAtIndex:indexPath.row];
            NSString *searchKey = [NSString stringWithFormat:@"%@",_searchDisplayController.searchBar.text];
            
            NSString *name = [NSString stringWithFormat:@"%@",[mapping objectForKey:@"user_name"]];
            NSRange range = [name rangeOfString:searchKey];
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:name];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            hintLabel.attributedText = string;
            phoneLabel.text = [mapping objectForKey:@"user_phone"];
            titleLabel.text = [NSString stringWithFormat:@"人员编号:%@",[mapping objectForKey:@"user_id"]];
            
            return cell;
        }

    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_contactType == ContactTypePerson) {
        _personDetailViewController = [[PersonDetailViewController alloc] init];
        NSDictionary *mapping = nil;
        
        if (tableView == self.tableView) {
            NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *values = [dic allValues];
            mapping = (NSDictionary*)[[values objectAtIndex:0] objectAtIndex:indexPath.row];

        }
        else{
            mapping = (NSDictionary*)[_filterData objectAtIndex:indexPath.row];
        }
         _personDetailViewController.record = mapping;
        [self.navigationController pushViewController:_personDetailViewController animated:YES];
        
    }
    else if (_contactType == ContactTypeDepart){
        _contactDetailViewController = [[ContactDetailViewController alloc] init];
        NSDictionary *mapping = nil;
        
        if (tableView == self.tableView) {
            NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
            NSArray *values = [dic allValues];
            mapping = (NSDictionary*)[[values objectAtIndex:0] objectAtIndex:indexPath.row];
        }
        else{
            mapping = (NSDictionary*)[_filterData objectAtIndex:indexPath.row];
        }
        _contactDetailViewController.departPersonMapping = mapping;
        
        [self.navigationController pushViewController:_contactDetailViewController animated:YES];
    }
    
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *commomMapping = (NSDictionary*)responseObject;
    if (request == _httpClient) {
        [self clearTableData];
        [_datas removeAllObjects];
        
        for (NSDictionary *mapping in [commomMapping objectForKey:@"record_list"]) {
            if (![self.indexSet containsObject:[mapping objectForKey:@"user_id"]]) {
                [self.indexSet containsObject:[mapping objectForKey:@"user_id"]];
                [_datas addObject:mapping];
            }
        }
        
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int i = 0; i < [[commomMapping objectForKey:@"record_list"] count]; i++) {
            NSDictionary *mapping = (NSDictionary*)[[commomMapping objectForKey:@"record_list"] objectAtIndex:i];
            NSString *name = [mapping objectForKey:@"user_name"];
            NSString *word = [name firstLetterWord:name];
            if (![temp containsObject:word]) {
                [temp addObject:word];
            }
        }
        
        self.tableWords = (NSMutableArray*)[temp sortedArrayUsingSelector:@selector(compare:)];
        
        for (NSString *word in self.tableWords) {
            NSMutableArray *item = [[NSMutableArray alloc] init];
            for (int i = 0; i < [[commomMapping objectForKey:@"record_list"] count]; i++) {
                NSDictionary *mapping = (NSDictionary*)[[commomMapping objectForKey:@"record_list"]  objectAtIndex:i];
                NSString *name = [mapping objectForKey:@"user_name"];
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
