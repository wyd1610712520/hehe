//
//  BeidaResultViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "BeidaResultViewController.h"

#import "HttpClient.h"

@interface BeidaResultViewController ()<RequestManagerDelegate>{
    HttpClient *_httpClient;
}

@end

@implementation BeidaResultViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"法库正文" color:nil];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    [_httpClient startBeidaRequest:[self param] path:@"GetSingleRecord"];
}

- (NSDictionary*)param{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:_lib,@"library",_gid,@"gid",_searchKey,@"word", nil];
    return param;
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    NSDictionary *record = [result objectForKey:@"Data"];
    _titleLabel.text = [record objectForKey:@"Title"];
    NSString *content = [record objectForKey:@"FullText"];
    [_webView loadHTMLString:content baseURL:nil];
    }

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}
@end
