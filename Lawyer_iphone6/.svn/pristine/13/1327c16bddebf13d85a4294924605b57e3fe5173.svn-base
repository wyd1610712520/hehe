//
//  WebViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-30.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>{
}

@end

@implementation WebViewController

@synthesize webView = _webView;
@synthesize path = _path;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_webView clearsContextBeforeDrawing];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_path]]];
    [self setTitle:self.title color:nil];
}

- (void)popSelf{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
    else{
        [super popSelf];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webView.delegate = self;
    _webView.scalesPageToFit = NO;
    _webView.allowsInlineMediaPlayback = YES;
    [self.view addSubview:_webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    //[self showProgressHUD:@""];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hideProgressHUD:0];
    
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self hideProgressHUD:0];
    [self showHUDWithTextOnly:@"打开失败"];
}



@end
