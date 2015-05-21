//
//  BoxViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "BoxViewController.h"

#import "LawCell.h"

#import "NSString+Utility.h"

#import "PreCheckViewController.h"
#import "CounterViewController.h"

@interface BoxViewController ()<UITableViewDataSource,UITableViewDelegate>{
    PreCheckViewController *_preCheckViewController;
    CounterViewController *_counterViewController;
}

@end

@implementation BoxViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:[Utility localizedStringWithTitle:@"box_nav_title"] color:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [@"#F9F9F9" colorValue];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60;
    
    UINib *cellNib = [UINib nibWithNibName:@"LawCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawCell"];
    
    
    _preCheckViewController = [[PreCheckViewController alloc] init];
    _counterViewController = [[CounterViewController alloc] init];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LawCell"];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"利益冲突预检";
        cell.logoImageView.image = [UIImage imageNamed:@"box_precheck_logo.png"];
    }
    else if (indexPath.row == 1){
        cell.titleLabel.text = @"诉讼费计算器";
        cell.logoImageView.image = [UIImage imageNamed:@"box_counter_logo.png"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:_preCheckViewController animated:YES];
    }
    else if (indexPath.row == 1){
        [self.navigationController pushViewController:_counterViewController animated:YES];
    }
}

@end
