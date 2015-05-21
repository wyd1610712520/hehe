//
//  PersonViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-23.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "PersonViewController.h"

#import "HttpClient.h"

#import "PersonCell.h"

#import "UIButton+AFNetworking.h"

@interface PersonViewController ()<RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    NSMutableArray *_tableDatas;
    
    NSDictionary *_singleDic;
    
    NSMutableArray *_groupArr;
}

@end

@implementation PersonViewController

@synthesize personType = _personType;

@synthesize caseID = _caseID;
@synthesize ywcpID = _ywcpID;

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _hintView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    
    if (_personType == PersonTypeNormal) {
        [self setTitle:@"选择负责人" color:nil];
        for (NSLayoutConstraint *layout in self.view.constraints) {
            if (layout.firstItem == _tableView && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 0;
            }
        }
        _hintView.hidden = YES;
    }
    else if (_personType == PersonTypeGroup){
        [self setTitle:@"选择小组成员" color:nil];
        for (NSLayoutConstraint *layout in self.view.constraints) {
            if (layout.firstItem == _tableView && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 90;
            }
        }
        _hintView.hidden = NO;
    }
    
    _groupArr = [[NSMutableArray alloc] init];
    
    
    
    
    _tableDatas = [[NSMutableArray alloc] init];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    [_httpClient startRequest:[self requestParam]];
    
    _tableView.tableFooterView = [[UIView alloc] init];
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    UINib *cellNib = [UINib nibWithNibName:@"PersonCell" bundle:nil];
    [_tableView registerNib:cellNib forCellReuseIdentifier:@"PersonCell"];

    if (_datas.count>0) {
        [_groupArr addObjectsFromArray:_datas];
        [self updateAvatorView];
    }
    
}

- (NSDictionary*)requestParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_caseID,@"caseID",_ywcpID,@"ywcpID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"caseprocessempllist",@"requestKey",fields,@"fields", nil];
    return param;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell"];
    NSDictionary *item = (NSDictionary*)[_tableDatas objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.avatorButton.layer.borderColor = [UIColor clearColor].CGColor;
    NSString *url = [item objectForKey:@"gc_photo"];
    [cell.avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:url]];
    cell.nameLabel.text = [item objectForKey:@"gc_name"];
    cell.dutyLabel.text = [item objectForKey:@"gc_category"];
    cell.addressLabel.text = [item objectForKey:@"gc_area"];
    cell.departLabel.text = [item objectForKey:@"gc_dept"];
    
    for (NSDictionary *temp in _groupArr) {
        if ([[temp objectForKey:@"ywcp_group_id"] isEqualToString:[item objectForKey:@"gc_id"]]) {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
        
        if ([[temp objectForKey:@"gc_id"] isEqualToString:[item objectForKey:@"gc_id"]]) {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_personType == PersonTypeNormal) {
        for (int i = 0; i < _tableDatas.count; i++) {
            UITableViewCell *cellView = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cellView.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        UITableViewCell *cellView = [tableView cellForRowAtIndexPath:indexPath];
        if (cellView.accessoryType == UITableViewCellAccessoryNone) {
            cellView.accessoryType=UITableViewCellAccessoryCheckmark;
        }
        else {
            cellView.accessoryType = UITableViewCellAccessoryNone;
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        NSDictionary *item = (NSDictionary*)[_tableDatas objectAtIndex:indexPath.row];
        _singleDic = item;
    }
    else if (_personType == PersonTypeGroup){
        NSDictionary *item = (NSDictionary*)[_tableDatas objectAtIndex:indexPath.row];
        
        UITableViewCell *cellView = [tableView cellForRowAtIndexPath:indexPath];
        if (cellView.accessoryType == UITableViewCellAccessoryNone) {
            cellView.accessoryType=UITableViewCellAccessoryCheckmark;
            [_groupArr addObject:item];
        }
        else {
            NSDictionary *tempDic = nil;
            
            NSString *tempId = [item objectForKey:@"gc_id"];
            for (NSDictionary *dicTemp in _groupArr) {
                if ([dicTemp objectForKey:@"ywcp_group_id"]) {
                    if ([tempId isEqualToString:[dicTemp objectForKey:@"ywcp_group_id"]]) {
                        tempDic = dicTemp;
                        continue;
                    }
                }
                else if ([dicTemp objectForKey:@"gc_id"]){
                    if ([tempId isEqualToString:[dicTemp objectForKey:@"gc_id"]]) {
                        tempDic = dicTemp;
                        continue;
                    }
                }
            }
            [_groupArr removeObject:tempDic];
            
            [item objectForKey:@""];
            
            cellView.accessoryType = UITableViewCellAccessoryNone;
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        [self updateAvatorView];
    }
}

- (void)updateAvatorView{
    
    _avatorView.textColor = [UIColor whiteColor];
    [_avatorView setAvators:_groupArr];
    _avatorView.managerLogo.hidden = YES;
}

- (IBAction)touchSureEvent:(id)sender{
    if (_personType == PersonTypeNormal) {
        [[NSNotificationCenter defaultCenter] postNotificationName:PersonNormal object:_singleDic];
    }
    else if (_personType == PersonTypeGroup){
        [[NSNotificationCenter defaultCenter] postNotificationName:PersonGroup object:_groupArr];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;

    for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
        [_tableDatas addObject:item];
    }
    [_tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
