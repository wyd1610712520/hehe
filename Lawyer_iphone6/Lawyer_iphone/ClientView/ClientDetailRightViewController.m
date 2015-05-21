//
//  ClientDetailRightViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-9.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ClientDetailRightViewController.h"

#import "ClientDetailViewController.h"

#import "RevealViewController.h"

#import "ClientIncreaseViewController.h"

#import "ClientDetailViewController.h"
#import "ClientContactViewController.h"

#import "ClientDocViewController.h"

#import "ClientDocViewController.h"
#import "VisiteAndCaseViewController.h"

@interface ClientDetailRightViewController ()<UITableViewDataSource,UITableViewDelegate>{
    ClientDetailViewController *_clientDetailViewController;
    
    UIButton *backButton;
    NSArray *_datas;
    UIView *_lineView;
    
    ClientIncreaseViewController *_clientIncreaseViewController;
    ClientContactViewController *_clientContactViewController;
    
    ClientDocViewController *_clientDocViewController;
    
    
    VisiteAndCaseViewController *_visiteAndCaseViewController;
}

@end

@implementation ClientDetailRightViewController

@synthesize tableView = _tableView;

- (id)init
{
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ClientDetailRight" ofType:@"plist"];
        _datas = [[NSArray alloc] initWithContentsOfFile:plistPath];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    _clientDetailViewController.navigationController.view.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    _clientDetailViewController.navigationController.view.hidden = YES;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.navigationController.navigationBarHidden = YES;
    _clientDetailViewController.navigationController.view.hidden = NO;


}

- (void)setClientDetailView:(ClientDetailViewController*)clientDetailViewController{
    _clientDetailViewController = clientDetailViewController;
    
    self.navigationController.navigationBarHidden = YES;
    _clientDetailViewController.navigationController.view.hidden = NO;
}

- (void)touchBackEvent{
    [self.revealContainer clickBlackLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"left_arrow_logo.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(touchBackEvent) forControlEvents:UIControlEventTouchUpInside];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    [self.view addSubview:backButton];
    
    
    CGRect buttonFrame = backButton.frame;
    buttonFrame.origin.x = vectorx+20;
    buttonFrame.origin.y = 20;
    buttonFrame.size.width = vector_x;
    buttonFrame.size.height = 50;
    backButton.frame = buttonFrame;
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(13, 49, backButton.frame.size.width, 0.5)];
    _lineView.backgroundColor = [UIColor whiteColor];
    [backButton addSubview:_lineView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _lineView.frame.origin.y+1, backButton.frame.size.width, self.view.frame.size.height - _lineView.frame.origin.y)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view.frame = frame;
    frame.origin.x = vectorx+20;
    frame.origin.y = backButton.frame.size.height+backButton.frame.origin.y;
    frame.size.width = backButton.frame.size.width-10;
    self.tableView.frame = frame;
    

   // _clientIncreaseViewController = [[ClientIncreaseViewController alloc] init];
    _clientIncreaseViewController.clientIncreaseType = ClientIncreaseTypeEdit;
    
    
    _clientContactViewController = [[ClientContactViewController alloc] init];
    
    _clientDocViewController = [[ClientDocViewController alloc] init];
    
    _visiteAndCaseViewController = [[VisiteAndCaseViewController alloc] init];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientDetailRight"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ClientDetailRight"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [[_datas objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.textLabel.textColor = [UIColor whiteColor];
    NSString *imageName = [[_datas objectAtIndex:indexPath.row] objectForKey:@"image"];
    UIImage *image = [UIImage imageNamed:imageName];
    cell.imageView.image = image;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(13, 59, tableView.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:lineView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _clientDetailViewController.navigationController.view.hidden = YES;
    
    if (indexPath.row == 10) {
       // _clientIncreaseViewController.record = _clientDetailViewController.record;
        _clientIncreaseViewController.clientIncreaseType = ClientIncreaseTypeEdit;
        //[self.navigationController pushViewController:_clientIncreaseViewController animated:YES];
    }
    else if (indexPath.row == 0){
        _clientContactViewController.clientID = [_clientDetailViewController.record objectForKey:@"cl_client_id"];
        _clientContactViewController.clientContactType = ClientContactTypeNormal;
        [self.navigationController pushViewController:_clientContactViewController animated:YES];
        
    }
    else if (indexPath.row == 1){
        _clientContactViewController.clientID = [_clientDetailViewController.record objectForKey:@"cl_client_id"];
        _clientContactViewController.clientContactType = ClientContactTypeRelate;
        [self.navigationController pushViewController:_clientContactViewController animated:YES];
        
    }
    else if (indexPath.row == 2){
        _clientDocViewController.clientID = [_clientDetailViewController.record objectForKey:@"cl_client_id"];
        [self.navigationController pushViewController:_clientDocViewController animated:YES];
        
    }
    else if (indexPath.row == 3){
        _visiteAndCaseViewController.clientId = [_clientDetailViewController.record objectForKey:@"cl_client_id"];
        _visiteAndCaseViewController.visiteAndCaseType = VisiteType;
        [self.navigationController pushViewController:_visiteAndCaseViewController animated:YES];
        
    }
    else if (indexPath.row == 4){
        _visiteAndCaseViewController.clientId = [_clientDetailViewController.record objectForKey:@"cl_client_id"];
        _visiteAndCaseViewController.visiteAndCaseType = CaseStatType;
        [self.navigationController pushViewController:_visiteAndCaseViewController animated:YES];
        
    }

}

@end
