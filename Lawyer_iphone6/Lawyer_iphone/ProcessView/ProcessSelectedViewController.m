//
//  ProcessSelectedViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-18.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProcessSelectedViewController.h"

#import "ProcessModuleViewController.h"

#import "CommomClient.h"

#import "HttpClient.h"

@interface ProcessSelectedViewController ()<UITableViewDataSource,UITableViewDelegate,RequestManagerDelegate>{
    NSArray *_datas;
    ProcessModuleViewController *_processModuleViewController;
    
    NSIndexPath *selectIndexPath;
    
    HttpClient *_httpClient;
    
    HttpClient *_commomClient;
    
    NSInteger _paper;
    
    NSMutableArray *_tableDatas;
    
    NSMutableArray *_selectPathArr;
    NSString *_currSelectString;
    
    NSString *_curSelectId;
    NSMutableArray *_selectIdArr;
    
    NSString *_fisrID;
    NSString *_fisrname;
    
    NSString *_secID;
    NSString *_secName;
}


@end

@implementation ProcessSelectedViewController

@synthesize processSelect = _processSelect;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_processSelect == ProcessSelectProcess) {
        _datas = [NSArray arrayWithObjects:@"按模板创建",@"自定义进程", nil];
    }
    else if (_processSelect == ProcessSelectModule){
        _datas = [NSArray arrayWithObjects:@"所内模板",@"个人模板",@"常用模板", nil];
    }
    
    _paper = 0;
}



- (void)popSelf{
    if (_paper == 0) {
        [super popSelf];
    }
    else{
        _paper--;
        if (_paper == 1) {
            [self startCommom];
        }
        else if (_paper > 1){
                [_httpClient startRequest:[self requesParam:[_selectIdArr lastObject]]];
        }
        else if (_paper == 0){
            [_tableview reloadData];
        }
        else{
            [super popSelf];
        }
        
        
        [_selectIdArr removeLastObject];
        [_selectPathArr removeLastObject];
        NSMutableString *tempS = [[NSMutableString alloc] init];
        for (NSString *s in _selectPathArr) {
            [tempS appendFormat:@"%@>",s];
        }
        [self updateHit:tempS];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    
    _tableDatas = [[NSMutableArray alloc] init];
    _selectPathArr = [[NSMutableArray alloc] init];
    _selectIdArr = [[NSMutableArray alloc] init];
    
    [self setTitle:@"模板分类选择" color:nil];
    
    _hintView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"o_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    
    _commomClient = [[HttpClient alloc] init];
    _commomClient.delegate = self;
     
    _tableview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.backgroundView = nil;
    _tableview.tableFooterView = [[UIView alloc] init];
    _processModuleViewController = [[ProcessModuleViewController alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_processSelect == ProcessSelectProcess) {
        return _datas.count;
    }
    else if (_processSelect == ProcessSelectModule){
        
        if (_paper == 0) {
            return _datas.count;
        }
        else{
            return _tableDatas.count;
        }
        
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.backgroundColor = [UIColor clearColor];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    if (_processSelect == ProcessSelectProcess) {
        cell.textLabel.text = [_datas objectAtIndex:indexPath.row];
    }
    else if (_processSelect == ProcessSelectModule){
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (_paper == 0) {
            cell.textLabel.text = [_datas objectAtIndex:indexPath.row];
        }
        else {
            NSDictionary *item = (NSDictionary*)[_tableDatas objectAtIndex:indexPath.row];
            if (_paper == 1) {
                cell.textLabel.text = [item objectForKey:@"gc_name"];
            }
            else{
                cell.textLabel.text = [item objectForKey:@"kind_name"];
            }
            
            
        }
        
    }

    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_processSelect == ProcessSelectProcess) {
        [self.navigationController pushViewController:_processModuleViewController animated:YES];
    }
    else if (_processSelect == ProcessSelectModule){
        selectIndexPath = indexPath;
        if (_paper == 0) {
            for (int i = 0; i < _datas.count; i++) {
                UITableViewCell *cellView = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                cellView.accessoryType = UITableViewCellAccessoryNone;
                
            }
            _currSelectString = [_datas objectAtIndex:indexPath.row];
            if ([_currSelectString isEqualToString:@"所内模板"]) {
                _fisrID = @"public";
                _fisrname = @"所内模板";
            }
            else if ([_currSelectString isEqualToString:@"个人模板"]) {
                _fisrID = @"person";
                _fisrname = @"个人模板";
            }
            else if ([_currSelectString isEqualToString:@"常用模板"]) {
                _fisrID = @"often";
                _fisrname = @"常用模板";
            }
        }
        else{
            for (int i = 0; i < _tableDatas.count; i++) {
                UITableViewCell *cellView = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                cellView.accessoryType = UITableViewCellAccessoryNone;
                
            }
            NSDictionary *item = (NSDictionary*)[_tableDatas objectAtIndex:indexPath.row];
            if (_paper == 1) {
                _currSelectString = [item objectForKey:@"gc_name"];
                _curSelectId  = [item objectForKey:@"gc_id"];
            }
            else{
                _currSelectString = [item objectForKey:@"kind_name"];
                _curSelectId  = [item objectForKey:@"kind_id"];
            }
            
            
            
        }
        
        
        
        UITableViewCell *cellView = [tableView cellForRowAtIndexPath:indexPath];
        if (cellView.accessoryType == UITableViewCellAccessoryNone) {
            cellView.accessoryType=UITableViewCellAccessoryCheckmark;
        }
        else {
            cellView.accessoryType = UITableViewCellAccessoryNone;
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
      
    }
    
}


- (IBAction)touchSureEvent:(id)sender {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_fisrID,@"first",_fisrname,@"_fisrname",_curSelectId,@"secondId",_currSelectString,@"secondName", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"muban" object:dic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)touchNextEvent:(id)sender {
    if (_paper == 0) {
        [_selectPathArr addObject:_currSelectString];
        if (_paper >1) {
            [_selectIdArr addObject:_curSelectId];
        }
        
        _paper++;
        if (_paper == 1) {
            [self startCommom];
        }
        else if (_paper > 1){
            [_httpClient startRequest:[self requesParam:_curSelectId]];
        }
        _currSelectString = nil;
        _curSelectId = nil;
    }
    else{
        if (_currSelectString && _curSelectId) {
            [_selectPathArr addObject:_currSelectString];
            if (_paper >1) {
                [_selectIdArr addObject:_curSelectId];
            }
            
            _paper++;
            if (_paper == 1) {
                [self startCommom];
            }
            else if (_paper > 1){
                [_httpClient startRequest:[self requesParam:_curSelectId]];
            }
            _currSelectString = nil;
            _curSelectId = nil;
        }
    }
    
    
    
    
    
}

- (NSDictionary*)requesParam:(NSString*)categoryID{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:categoryID,@"categoryID",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"processtmplcategory",@"requestKey", nil];
    return param;
}

- (void)startCommom{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:@"CACT",@"gc_code_group", nil];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"generalcode",@"requestKey",fields,@"fields", nil];
    [_commomClient startRequestAtCommom:param];
}

- (void)updateHit:(NSString*)hint{
    _hintLabel.text = hint;
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];

    NSDictionary *dic = (NSDictionary*)responseObject;
    if (request == _commomClient) {
        _paper = 1;
        [_tableDatas removeAllObjects];
        for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
            [_tableDatas addObject:item];
        }
        NSMutableString *tempS = [[NSMutableString alloc] init];
        for (NSString *s in _selectPathArr) {
            [tempS appendFormat:@"%@>",s];
        }
        [self updateHit:tempS];
     }
    else{
        NSDictionary *item = [[dic objectForKey:@"record_list"] lastObject];
        if ([[item objectForKey:@"kind_list"] count] > 0) {
                [_tableDatas removeAllObjects];
            for (NSDictionary *temp in [item objectForKey:@"kind_list"]) {
                [_tableDatas addObject:temp];
            }
            NSMutableString *tempS = [[NSMutableString alloc] init];
            for (NSString *s in _selectPathArr) {
                [tempS appendFormat:@"%@>",s];
            }
            [self updateHit:tempS];
        }
        else{
            [self showHUDWithTextOnly:@"没有数据"];
            _paper --;
            [_selectIdArr removeLastObject];
            [_selectPathArr removeLastObject];
        }
        
        
    }
    
   
    
    
    [_tableview reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
