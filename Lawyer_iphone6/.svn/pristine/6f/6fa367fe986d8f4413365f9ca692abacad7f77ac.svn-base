//
//  ProcessModuleViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-18.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProcessModuleViewController.h"

#import "ProcessModuleSearchViewController.h"

#import "HttpClient.h"

@interface ProcessModuleViewController ()<UITableViewDelegate,RequestManagerDelegate,UITableViewDataSource,SegmentViewDelegate>{
    ProcessModuleSearchViewController *_processModuleSearchViewController;
    HttpClient *_httpClient;
}

@end

@implementation ProcessModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"进程模板搜素" color:nil];
    [self showSegment:[NSArray arrayWithObjects:@"全部模板",@"所内模板",@"个人模板",@"常用模板", nil]];
    [self setRightButton:nil title:@"搜索" target:self action:@selector(touchSearchEvent)];
    self.segmentView.delegate = self;
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
}

- (void)touchSearchEvent{
    [self.navigationController pushViewController:_processModuleSearchViewController animated:YES];
}



- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    if (button.tag == 0) {
       
    }
    else if (button.tag == 1){
        
    }
    else if (button.tag == 2){
        
    }
    else if (button.tag == 3){
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = @"进程模板名称";
    cell.detailTextLabel.text = @"邓天然   2014-09-19";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
