//
//  LanguageViewController.m
//  Lawyer_iphone
//
//  Created by bitzsoft_mac on 15/3/21.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "LanguageViewController.h"

#import "HttpClient.h"

@interface LanguageViewController ()<UITableViewDataSource,UITableViewDelegate,RequestManagerDelegate>{
    HttpClient *_httpClient;
    
    HttpClient *_commomHttCLient;
    
    NSMutableArray *_datas;
    
    NSMutableArray *_lans;
}

@end

@implementation LanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _commomHttCLient = [[HttpClient alloc] init];
    _commomHttCLient.delegate = self;
    [_commomHttCLient startRequestAtCommom:[self lanRequest]];
    
    _lans = [[NSMutableArray alloc] init];
    _datas = [[NSMutableArray alloc] init];

    [_lans addObjectsFromArray:_array];
    [self updateView];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lan" object:_lans];
}

- (NSDictionary*)lanRequest{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:@"CAYY",@"gc_code_group", nil];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"generalcode",@"requestKey",fields,@"fields", nil];
    return param;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *item = (NSDictionary*)[_datas objectAtIndex:indexPath.row];
    cell.textLabel.text = [item objectForKey:@"gc_name"];
    NSString *name = [item objectForKey:@"gc_name"];
    
    

    for (NSDictionary *dic in _lans) {
        NSString *name1 = [dic objectForKey:@"gc_name"];
        if ([name isEqualToString:name1]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            continue;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = (NSDictionary*)[_datas objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (![_lans containsObject:item]) {
            [_lans addObject:item];
        }
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        NSString *name = [item objectForKey:@"gc_name"];
        
        NSMutableArray *temp = [_lans mutableCopy];
        
        for (int i = 0; i < temp.count; i++) {
            NSDictionary *dic = (NSDictionary*)[_lans objectAtIndex:i];
            NSString *name1 = [dic objectForKey:@"gc_name"];
            if ([name isEqualToString:name1]) {
                [temp removeObjectAtIndex:i];
                continue;
            }
        }
     
        _lans = temp;
    }
    [self updateView];
    
}

- (void)updateView{
    NSMutableString *titles = [[NSMutableString alloc] init];
    for (NSDictionary *item in _lans) {
        NSString *name = [item objectForKey:@"gc_name"];
        [titles appendFormat:@"%@,",name];
    }
    _textView.text = titles;
}

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    
    
    
    //    NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:@"空",@"gc_name",@"",@"gc_id", nil];
    //
    //    [self.indexSet addObject:@""];
    //    [self.tableDatas addObject:tempDic];
    for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
        [_datas addObject:item];
    }
    [_tableVIew reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
