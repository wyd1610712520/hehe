//
//  BeidaLibViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "BeidaLibViewController.h"

#import "LawCell.h"
#import "HttpClient.h"

@interface BeidaLibViewController ()<RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    
    NSDictionary *_beidaDic;
    
    int paper;
    
    NSMutableArray *_selectArr;
}

@end

@implementation BeidaLibViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    paper = 1;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"北大法宝" color:nil];
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UINib *cellNib = [UINib nibWithNibName:@"LawCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _selectArr = [[NSMutableArray alloc] init];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    [_httpClient startBeidaRequest:[self beidaParam:_lib key:@""] path:@"GetCategory"];
}

- (void)popSelf{
    paper--;
    if (paper<0) {
        paper = 0;
    }
    if (paper == 0) {
        [super popSelf];
    }
    else{
        
        if (_selectArr.count > 1) {
            NSDictionary *dic = [_selectArr lastObject];
            [_httpClient startBeidaRequest:[self beidaParam:_lib key:[dic objectForKey:@"key"]] path:@"GetCategory"];
            
            [_selectArr removeLastObject];
        }
        else if ( _selectArr.count == 1){
            [_httpClient startBeidaRequest:[self beidaParam:_lib key:@""] path:@"GetCategory"];
            
            [_selectArr removeLastObject];
            
            
        }
        else{
            [_selectArr removeAllObjects];
            paper = 0;
        }

    }
}

- (NSDictionary*)beidaParam:(NSString*)lib key:(NSString*)key{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:lib,@"Library",@"Category",@"Property",key,@"ParentKey", nil];
    return param;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _beidaDic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LawCell"];
    NSArray *titles = [_beidaDic allValues];
    cell.titleLabel.text = [titles objectAtIndex:indexPath.row];
    cell.logoImageView.image = [UIImage imageNamed:@"law_fa_logo.png"];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    paper ++;
    NSArray *titles = [_beidaDic allKeys];
    NSArray *values = [_beidaDic allValues];
    [_httpClient startBeidaRequest:[self beidaParam:_lib key:[titles objectAtIndex:indexPath.row]] path:@"GetCategory"];
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:[titles objectAtIndex:indexPath.row],@"key",[values objectAtIndex:indexPath.row],@"value", nil];
    [_selectArr addObject:dic];
    
    
    
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    
    
    NSDictionary *result = (NSDictionary*)responseObject;
    if (request == _httpClient){
        if ([[result objectForKey:@"Data"] count] == 0) {
            paper--;
            [_selectArr removeLastObject];
            [self showHUDWithTextOnly:@"该法库下没有内容!"];
            
        }
        else{
            
            _beidaDic = [result objectForKey:@"Data"];
            [self.tableView reloadData];
        }
    }
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}



@end
