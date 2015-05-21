//
//  LawViewViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-24.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LawViewViewController.h"

#import "RootViewController.h"

#import "NSString+Utility.h"

@interface LawViewViewController ()<UITableViewDataSource,UITableViewDelegate>{
    RootViewController *_rootViewController;
}

@end

@implementation LawViewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    

    [self setTitle:[Utility localizedStringWithTitle:@"law_nav_title"] color:nil];
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [@"#F9F9F9" colorValue];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60;
    
    UINib *cellNib = [UINib nibWithNibName:@"LawCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawCell"];
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LawCell"];
  
//    if (indexPath.row == 0) {
//        cell.titleLabel.text = @"律师e通";
//        cell.logoImageView.image = [UIImage imageNamed:@"law_e_logo.png"];
//    }
//    else if (indexPath.row == 1){
//        
//    }
    
    cell.titleLabel.text = @"北大法宝";
    cell.logoImageView.image = [UIImage imageNamed:@"law_fa_logo.png"];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _rootViewController = [[RootViewController alloc] init];
    [self presentViewController:_rootViewController animated:YES completion:nil];
    [_rootViewController showInLawRule];
    
}

@end
