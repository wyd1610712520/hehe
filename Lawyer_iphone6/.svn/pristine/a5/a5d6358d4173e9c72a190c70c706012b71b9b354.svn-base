//
//  GeneralViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "GeneralViewController.h"

#import "HttpClient.h"

@interface GeneralViewController ()<RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    
    NSDictionary *_selectDic;
    NSIndexPath *_indexPath;
    
}

@end

@implementation GeneralViewController

@synthesize delegate = _delegate;

@synthesize commomCode = _commomCode;

@synthesize datas = _datas;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
   
    self.navigationController.navigationBar.translucent = NO;
   
    if (_datas.count > 0) {
        [self.tableView reloadData];
    }
    else{
        _httpClient = [[HttpClient alloc] init];
        _httpClient.delegate = self;
        [_httpClient startRequestAtCommom:[self param]];
        
    }

    
}





- (NSDictionary*)param{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_commomCode,@"gc_code_group", nil];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"generalcode",@"requestKey",fields,@"fields", nil];
    return param;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"请选择" color:nil];
    

    [self showTable];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 50;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.tableFooterView = [[UIView alloc] init];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_datas.count  > 0) {
        return _datas.count;
    }
    return self.tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath == _indexPath) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.textColor = [UIColor blackColor];
    if (_datas.count > 0) {
        NSDictionary *dic = (NSDictionary*)[_datas objectAtIndex:indexPath.row];
        cell.textLabel.text = [dic objectForKey:@"gc_name"];
    }
    else{
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        cell.textLabel.text = [item objectForKey:@"gc_name"];
    }
    
    
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = (NSDictionary*)[_datas objectAtIndex:indexPath.row];
    if (_datas.count > 0) {
        _selectDic = dic;
    }
    else{
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        _selectDic = [NSDictionary dictionaryWithObjectsAndKeys:[item objectForKey:@"gc_name"],@"gc_name",[item objectForKey:@"gc_id"],@"gc_id", nil];

    }
    
    for (int i = 0; i < self.tableDatas.count; i++) {
        UITableViewCell *cellView = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cellView.accessoryType = UITableViewCellAccessoryNone;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    for (int i = 0; i < _datas.count; i++) {
        UITableViewCell *cellView = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cellView.accessoryType = UITableViewCellAccessoryNone;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    UITableViewCell *cellView = [tableView cellForRowAtIndexPath:indexPath];
    if (cellView.accessoryType == UITableViewCellAccessoryNone) {
        cellView.accessoryType=UITableViewCellAccessoryCheckmark;
        _indexPath = indexPath;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else {
        cellView.accessoryType = UITableViewCellAccessoryNone;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    if ([_delegate respondsToSelector:@selector(general:data:)]) {
        
        
        [_delegate general:self data:_selectDic];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

#pragma mark - RequestManagerDelegate
- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;

    [self clearTableData];
    

   
//    NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:@"空",@"gc_name",@"",@"gc_id", nil];
//    
//    [self.indexSet addObject:@""];
//    [self.tableDatas addObject:tempDic];
    for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
        if (![self.indexSet containsObject:[item objectForKey:@"gc_id"]]) {
            [self.indexSet addObject:item];
            [self.tableDatas addObject:item];
            
        }
    }
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
