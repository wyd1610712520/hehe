//
//  ShareViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ShareViewController.h"

#import "ShareClient.h"


@interface ShareViewController ()<UIAlertViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>{
    UIWindow *_window;
    
    NSString *_title;
    NSString *_describe;
    NSString *_redict;
    NSData *_data;
    
}

@end

@implementation ShareViewController

@synthesize qqButton = _qqButton;
@synthesize yixinButton = _yixinButton;
@synthesize wFriendButton = _wFriendButton;
@synthesize wGroupButton = _wGroupButton;
@synthesize sinaButton = _sinaButton;
@synthesize messageButton = _messageButton;
@synthesize emailButton = _emailButton;

+ (ShareViewController *)sharedInstance
{
    __strong static ShareViewController *instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[ShareViewController alloc] init];
    });
    return instance;
}

- (id)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    }
    return self;
}

- (void)show{
    
    [_window addSubview:self.view];
}

- (IBAction)touchCancelEvent:(id)sender{
    [self.view removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([ShareClient checkQQShare]) {
        _qqButton.enabled = YES;
    }
    else{
        _qqButton.enabled = NO;
    }
    if ([ShareClient checkYXShare]) {
        _yixinButton.enabled = YES;
    }
    else{
        _yixinButton.enabled = NO;
    }
    
    if ([ShareClient checkSinaShare]) {
        _sinaButton.enabled = YES;
    }
    else{
        _sinaButton.enabled = NO;
    }
    
    if( [MFMessageComposeViewController canSendText] )
    {
        _messageButton.enabled = YES;
        
    }
    else
    {
        _messageButton.enabled = NO;
    }
    
    if ([MFMailComposeViewController canSendMail]) {
        _emailButton.enabled = YES;
    }
    else{
        _emailButton.enabled = NO;
    }
    
    if ([ShareClient checkWXShare]) {
        _wFriendButton.enabled = YES;
        _wGroupButton.enabled = YES;
    }
    else{
        _wFriendButton.enabled = NO;
        _wGroupButton.enabled = NO;
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _window = [[UIApplication sharedApplication] keyWindow];
    self.view.frame = _window.frame;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sinaWithError) name:SinaError object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sinaWithLogout) name:SinaLogoutSuccess object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sinaWithLogin) name:SinaLoginSuccess object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(YXWithError) name:YXError object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(YXWithLogout) name:YXLogoutSuccess object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(YXWithLogin) name:YXLoginSuccess object:nil];
    
}

- (void)sendInfo:(NSData*)data
           title:(NSString*)title
          descri:(NSString*)descri
       redictUrl:(NSString*)redictUrl{
    _data = data;
    _title = title;
    _describe =descri;
    _redict = redictUrl;
}

#pragma mark -- ShareEvent

- (IBAction)touchQQEvent:(UIButton*)sender{
    if (_shareType == ShareTypeCustom) {
        [[ShareClient sharedInstance] shareHtmlInQQ:_data title:_title descri:_describe redictUrl:_redict];
    }
    else if (_shareType == ShareTypeDefault){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSString *title = @"律师e通";
        NSString *descri = @"人性化交互设计，利用移动终端优势，实现快速拍照，录音，录像，定位等功能。专线VPN，保证移动互联数据安全，实现数据的快速获取、保存。";
        NSString *url = downloadUrl;
        [[ShareClient sharedInstance] shareHtmlInQQ:data title:title descri:descri redictUrl:url];

    }
}

- (IBAction)touchYixinEvent:(UIButton*)sender{
    if (_shareType == ShareTypeCustom) {
        [[ShareClient sharedInstance] shareWebInYX:_data title:_title descri:_describe redictUrl:_redict];
    }
    else if (_shareType == ShareTypeDefault){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSString *title = @"律师e通";
        NSString *descri = @"人性化交互设计，利用移动终端优势，实现快速拍照，录音，录像，定位等功能。专线VPN，保证移动互联数据安全，实现数据的快速获取、保存。";
        NSString *url = downloadUrl;
        [[ShareClient sharedInstance] shareWebInYX:data title:title descri:descri redictUrl:url];
    }
    
}

- (IBAction)touchWFriendEvent:(UIButton*)sender{
    if (_shareType == ShareTypeCustom) {
        [[ShareClient sharedInstance] shareHtmlInWX:_data title:_title descri:_describe redictUrl:_redict scene:0];
    }
    else if (_shareType == ShareTypeDefault){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSString *title = @"律师e通";
        NSString *descri = @"人性化交互设计，利用移动终端优势，实现快速拍照，录音，录像，定位等功能。专线VPN，保证移动互联数据安全，实现数据的快速获取、保存。";
        NSString *url = downloadUrl;
        [[ShareClient sharedInstance] shareHtmlInWX:data title:title descri:descri redictUrl:url scene:0];
    }
}

- (IBAction)touchWGroupEvent:(UIButton*)sender{
    if (_shareType == ShareTypeCustom) {
        [[ShareClient sharedInstance] shareHtmlInWX:_data title:_title descri:_describe redictUrl:_redict scene:1];
    }
    else if (_shareType == ShareTypeDefault){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSString *title = @"律师e通";
        NSString *descri = @"人性化交互设计，利用移动终端优势，实现快速拍照，录音，录像，定位等功能。专线VPN，保证移动互联数据安全，实现数据的快速获取、保存。";
        NSString *url = downloadUrl;
        [[ShareClient sharedInstance] shareHtmlInWX:data title:title descri:descri redictUrl:url scene:1];
    }
}

- (IBAction)touchSinaEvent:(UIButton*)sender{
    if (_shareType == ShareTypeCustom) {
        [[ShareClient sharedInstance] shareWebInSina:_data title:_title descri:_describe redictUrl:_redict];
    }
    else if (_shareType == ShareTypeDefault){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSString *title = @"律师e通";
        NSString *descri = @"人性化交互设计，利用移动终端优势，实现快速拍照，录音，录像，定位等功能。专线VPN，保证移动互联数据安全，实现数据的快速获取、保存。";
        NSString *url = downloadUrl;
        [[ShareClient sharedInstance] shareWebInSina:data title:title descri:descri redictUrl:url];
    }
    
}

- (IBAction)touchMessageEvent:(UIButton*)sender{
    
    
    MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
    //        controller.recipients = [NSArray arrayWithObject:phone];
    if (_shareType == ShareTypeCustom) {
        controller.body = [NSString stringWithFormat:@"%@ \n %@",_describe,_redict];
    }
    else if (_shareType == ShareTypeDefault){
        NSString *descri = @"人性化交互设计，利用移动终端优势，实现快速拍照，录音，录像，定位等功能。专线VPN，保证移动互联数据安全，实现数据的快速获取、保存。";
        NSString *url = [NSString stringWithFormat:@"下载地址：%@",downloadUrl];
        controller.body = [NSString stringWithFormat:@"%@ \n %@",descri,url];
    }
    controller.messageComposeDelegate = self;
    [self presentViewController:controller animated:YES completion:nil];

}


- (IBAction)touchEmailEvent:(UIButton*)sender{
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    if (_shareType == ShareTypeCustom) {
        [controller setSubject:@"律师e通"];
        [controller setMessageBody:[NSString stringWithFormat:@"%@ \n %@",_describe,_redict] isHTML:NO];
    }
    else if (_shareType == ShareTypeDefault){
        
        NSString *descri = @"人性化交互设计，利用移动终端优势，实现快速拍照，录音，录像，定位等功能。专线VPN，保证移动互联数据安全，实现数据的快速获取、保存。";
        NSString *url = [NSString stringWithFormat:@"下载地址：%@",downloadUrl];
        [controller setSubject:@"律师e通"];
        //[controller setToRecipients:@[@"4800607@gmail.com"]];
        [controller setMessageBody:[NSString stringWithFormat:@"%@ \n %@",descri,url] isHTML:NO];
        
    }
    [controller setMailComposeDelegate:self];
    
    // 显示控制器
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
