//
//  FileResultViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-1.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "FileResultViewController.h"

#import "HttpClient.h"

#import "RevealViewController.h"

@interface FileResultViewController ()<RequestManagerDelegate>{
    HttpClient *_searchHttpClient;
}

@end

@implementation FileResultViewController

@synthesize alertView = _alertView;
@synthesize searchDic = _searchDic;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_searchHttpClient startRequest:_searchDic];
}

- (void)touchRightEvent{
    [self.revealContainer showRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"搜索结果" color:nil];
    [self setRightButton:[UIImage imageNamed:@"nav_right_btn.png"] title:nil target:self action:@selector(touchRightEvent)];
    
    _searchHttpClient = [[HttpClient alloc] init];
    _searchHttpClient.delegate = self;
    
}


#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    if (request == _searchHttpClient) {
    }
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}


@end
