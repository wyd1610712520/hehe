//
//  LibViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-18.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "LibViewController.h"

#import "HttpClient.h"

@interface LibViewController ()<RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    HttpClient *_beidaHttpClient;
    
    NSMutableArray *_tableDatas;
    
    NSMutableArray *_selectDatas;
    
    NSDictionary *_curSelectData;
    
    NSDictionary *_beidaDic;
    
    NSInteger _paper;
    
    NSString *_firstLib;
    
    NSString *_beidaSelectID;
    NSString *_beidaSelectName;
    
    NSMutableArray *_pathDic;
    
    NSIndexPath *_selectIndex;
}

@end

@implementation LibViewController

@synthesize delegate = _delegate;

- (NSDictionary*)lawParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:@"LAWMODEL",@"gc_code_group", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"generalcode",@"requestKey",fields,@"fields", nil];
    return param;
}


- (void)popSelf {
    if (_paper == 0) {
        [super popSelf];
    }
    else if (_paper > 0){
        
        
        if (_pathDic.count > 3) {
            NSDictionary *dic = [_pathDic objectAtIndex:(_pathDic.count - 3)];
            [_beidaHttpClient startBeidaRequest:[self beidaParam:_firstLib key:[dic objectForKey:@"key"]] path:@"GetCategory"];
            
            [_pathDic removeLastObject];
            
            
            
            NSMutableString *str = [[NSMutableString alloc] init];;
            for (NSDictionary *item in _pathDic) {
                [str appendFormat:@"%@ > ",[item objectForKey:@"value"]];
            }
            
            _hintLabel.text = str;
            
            _paper--;
        }
        else if ( _pathDic.count == 3 || _pathDic.count == 2){
             [_beidaHttpClient startBeidaRequest:[self beidaParam:_firstLib key:@""] path:@"GetCategory"];
            
            [_pathDic removeLastObject];
            
            
            
            NSMutableString *str = [[NSMutableString alloc] init];;
            for (NSDictionary *item in _pathDic) {
                [str appendFormat:@"%@ > ",[item objectForKey:@"value"]];
            }
            
            _hintLabel.text = str;
            
            _paper--;
        }
        else{
            [_pathDic removeAllObjects];
            _paper = 0;
            [_httpClient startRequestAtCommom:[self lawParam]];
            _hintLabel.text = @"";
        }
        
        
        
        
    }
}

- (void)touchCancelEvent{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightButton:nil title:@"取消" target:self action:@selector(touchCancelEvent)];
    
    _paper = 0;
    [self setTitle:@"选择法库" color:nil];
    
    _hintView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    [_httpClient startRequestAtCommom:[self lawParam]];
    
    _beidaHttpClient = [[HttpClient alloc] init];
    _beidaHttpClient.delegate = self;
    
    _tableDatas = [[NSMutableArray alloc] init];
    _selectDatas = [[NSMutableArray alloc] init];
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.tableFooterView = [[UIView alloc] init];
    
    _pathDic = [[NSMutableArray alloc] init];
}

- (NSDictionary*)beidaParam:(NSString*)lib key:(NSString*)key{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:lib,@"Library",@"Category",@"Property",key,@"ParentKey", nil];
    return param;
}

- (IBAction)touchNextEvent:(id)sender {
    
    if (!_selectIndex) {
        return;
    }
    
    _selectIndex = nil;
    
    if (_paper == 0) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[_curSelectData objectForKey:@"gc_id"],@"key",[_curSelectData objectForKey:@"gc_name"],@"value", nil];
        
        [_pathDic insertObject:dic atIndex:_paper];
        
        
        NSMutableString *str = [[NSMutableString alloc] init];;
        for (NSDictionary *item in _pathDic) {
            [str appendFormat:@"%@ > ",[item objectForKey:@"value"]];
        }
        
        _hintLabel.text = str;
        
        [_beidaHttpClient startBeidaRequest:[self beidaParam:_firstLib key:@""] path:@"GetCategory"];
    }
    else if (_paper >0){
        NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:_beidaSelectID,@"key",_beidaSelectName,@"value", nil];
        [_pathDic insertObject:dic atIndex:_paper];
        
        NSMutableString *str = [[NSMutableString alloc] init];;
        for (NSDictionary *item in _pathDic) {
            [str appendFormat:@"%@ > ",[item objectForKey:@"value"]];
        }
        
        _hintLabel.text = str;
        [_beidaHttpClient startBeidaRequest:[self beidaParam:_firstLib key:_beidaSelectID] path:@"GetCategory"];
    }
    _paper++;
    
}

- (IBAction)touchSureEvent:(id)sender {
    if ([_delegate respondsToSelector:@selector(returnLib:code:name:)]) {
        if (_paper > 0) {
            
            
            if (_pathDic.count > 1) {
                
                if (_beidaSelectID.length > 0) {
                    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:_beidaSelectID,@"key",_beidaSelectName,@"value", nil];
                     [_pathDic insertObject:dic atIndex:_paper];
                }
                
               
                
                
                NSDictionary *item = [_pathDic lastObject];
                [_delegate returnLib:_firstLib code:[item objectForKey:@"key"] name:[item objectForKey:@"value"]];
            }
            else{
                [_delegate returnLib:_firstLib code:@"" name:[_curSelectData objectForKey:@"gc_name"]];
            }

        }
        else{
            [_delegate returnLib:_firstLib code:@"" name:[_curSelectData objectForKey:@"gc_name"]];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_paper == 0) {
        return _tableDatas.count;
    }
    else{
        return _beidaDic.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (_paper == 0) {
        
        if (_tableDatas.count > 0) {
            NSDictionary *dic = (NSDictionary*)[_tableDatas objectAtIndex:indexPath.row];
            cell.textLabel.text = [dic objectForKey:@"gc_name"];

        }
    }
    else if (_paper > 0){
        NSArray *titles = [_beidaDic allValues];
        
        if (titles.count > 0) {
            cell.textLabel.text = [titles objectAtIndex:indexPath.row];
            
            if ([_beidaSelectName isEqualToString:[titles objectAtIndex:indexPath.row]]) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
            else{
                cell.accessoryType=UITableViewCellAccessoryNone;
            }

        }
        
    }
    

    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _curSelectData = nil;
    
  
    
    _selectIndex = indexPath;

    if (_paper == 0) {
        for (int i = 0; i < _tableDatas.count; i++) {
            UITableViewCell *cellView = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cellView.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        UITableViewCell *cellView = [tableView cellForRowAtIndexPath:indexPath];
        if (cellView.accessoryType == UITableViewCellAccessoryNone) {
            cellView.accessoryType=UITableViewCellAccessoryCheckmark;
            
        }
        
        NSDictionary *dic = (NSDictionary*)[_tableDatas objectAtIndex:indexPath.row];
        _curSelectData = dic;
 
        _firstLib = [dic objectForKey:@"gc_id"];

    }
    else if (_paper > 0){
        for (int i = 0; i < _beidaDic.count; i++) {
            UITableViewCell *cellView = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cellView.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        UITableViewCell *cellView = [tableView cellForRowAtIndexPath:indexPath];
        if (cellView.accessoryType == UITableViewCellAccessoryNone) {
            cellView.accessoryType=UITableViewCellAccessoryCheckmark;
            
        }

        NSArray *titles = [_beidaDic allValues];
        NSArray *ids = [_beidaDic allKeys];
        _beidaSelectName = [titles objectAtIndex:indexPath.row];
        _beidaSelectID = [ids objectAtIndex:indexPath.row];
        
      
        
        NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:_beidaSelectID,@"gc_id",_beidaSelectName,@"gc_name", nil];
        
        _curSelectData = temp;
    }
    
}


#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    
    
    NSDictionary *result = (NSDictionary*)responseObject;
    if (request == _httpClient) {
        [_tableDatas removeAllObjects];
        for (NSDictionary *item in [result objectForKey:@"record_list"]) {
            [_tableDatas addObject:item];
        }
        [self.tableView reloadData];
    }
    else if (request == _beidaHttpClient){
        
        if ([[result objectForKey:@"Data"] count] == 0) {
            [self showHUDWithTextOnly:@"该法库下没有内容!"];
            [_pathDic removeLastObject];
            _paper--;
        }
        else{
            
            _beidaSelectName = nil;
            _beidaSelectID = nil;
            if (_paper > 0) {
                _beidaDic = [result objectForKey:@"Data"];
                
                
                
            }
            [self.tableView reloadData];
        }
    }
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}
@end
