//
//  ProcessDetailRightViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProcessDetailRightViewController.h"

#import "ProcessFragmentViewController.h"

#import "RootViewController.h"

#import "CommomClient.h"
#import "ResearchViewController.h"
@interface ProcessDetailRightViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_datas;
    ProcessFragmentViewController *_processFragmentViewController;
    
    ProcessDetailViewController *_processDetailViewController;
    
    RootViewController *rootViewController;
    ResearchViewController *_researchViewController;
}

@end

@implementation ProcessDetailRightViewController

@synthesize tableView = _tableView;

- (id)init
{
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ProcessDetailRight" ofType:@"plist"];
        _datas = [[NSArray alloc] initWithContentsOfFile:plistPath];
    }
    return self;
}

- (void)setProcessDetailView:(ProcessDetailViewController*)processDetailViewController{
    _processDetailViewController = processDetailViewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    _processDetailViewController.navigationController.view.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    _processDetailViewController.navigationController.view.hidden = YES;
}

- (void)touchBackEvent{
     [self.revealContainer clickBlackLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightbackground.png"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:imageView atIndex:0];
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"left_arrow_logo.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(touchBackEvent) forControlEvents:UIControlEventTouchUpInside];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    [self.view addSubview:backButton];
    
    
    CGRect buttonFrame = backButton.frame;
    buttonFrame.origin.x = vectorx;
    buttonFrame.origin.y = 20;
    buttonFrame.size.width = vector_x;
    buttonFrame.size.height = 50;
    backButton.frame = buttonFrame;
    
    UIView* _lineView = [[UIView alloc] initWithFrame:CGRectMake(13, 49, backButton.frame.size.width, 0.5)];
    _lineView.backgroundColor = [UIColor whiteColor];
    [backButton addSubview:_lineView];
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.rowHeight = 50.0;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view.frame = frame;
    frame.origin.x = vectorx;
    frame.origin.y = backButton.frame.origin.y+backButton.frame.size.height;
    frame.size.width = vector_x;
    self.tableView.frame = frame;
    
     
    _processFragmentViewController = [[ProcessFragmentViewController alloc] initWithNibName:@"ProcessFragmentViewController" bundle:nil];
    
    
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
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.frame = CGRectMake(10, cell.frame.size.height-1, self.view.frame.size.width-20, 0.4);
    [cell addSubview:lineView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        rootViewController = [[RootViewController alloc] init];
        [self presentViewController:rootViewController animated:YES completion:nil];

        [rootViewController showInCaseDetail];
        [rootViewController.caseDetatilViewController setCaseId:_caseID];
    }
    else if (indexPath.row == 1){
        rootViewController = [[RootViewController alloc] init];
        [self presentViewController:rootViewController animated:YES completion:nil];

        [rootViewController showInClientDetail];
        rootViewController.clientDetailViewController.clientId = _clientID;
    }
    else if (indexPath.row == 2){
        rootViewController = [[RootViewController alloc] init];
        [self presentViewController:rootViewController animated:YES completion:nil];

        NSString *string = [[CommomClient sharedInstance] getValueFromUserInfo:@"docClassSplit"];
        NSString *clssid = [NSString stringWithFormat:@"M4%@%@",string,_caseID];
        [rootViewController showInFile];
        rootViewController.fileViewController.caseClassId =clssid;
        rootViewController.fileViewController.fileOperation = FileOperationRead;
        rootViewController.fileViewController.titleStr = @"";

    }
    else if (indexPath.row == 3){
        _researchViewController = [[ResearchViewController alloc] init];
        _researchViewController.record = _record;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_researchViewController];
        [self presentViewController:nav animated:NO completion:nil];
    }
    
}

@end
