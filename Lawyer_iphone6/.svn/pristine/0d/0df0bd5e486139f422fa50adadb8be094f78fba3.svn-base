//
//  LawRuleRightViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-26.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LawRuleRightViewController.h"

#import "LawRuleViewController.h"

#import "RevealViewController.h"
#import "HttpClient.h"
#import "LibViewController.h"
#import "LawResultViewController.h"

#import "BeidaSearchViewController.h"

@interface LawRuleRightViewController ()<UITextFieldDelegate,RequestManagerDelegate,LibViewControllerDelegate>{
    LawRuleViewController *_lawRuleViewController;
    LawResultViewController *_lawResultViewController;
    
    HttpClient *_historyHttpClient;
    
    LibViewController *_libViewController;
    
    BeidaSearchViewController *_beidaSearchViewController;
    
    NSString *_lib;
    NSString *_code;
}

@end

@implementation LawRuleRightViewController

@synthesize delegate = _delegate;

@synthesize contentView = _contentView;

@synthesize seachField = _seachField;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    _lawRuleViewController.navigationController.view.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    _lawRuleViewController.navigationController.view.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lib = @"";
    _code = @"";
    
    _historyHttpClient = [[HttpClient alloc] init];
    _historyHttpClient.delegate = self;

    
    self.navigationController.navigationBarHidden = YES;
    _lawRuleViewController.navigationController.view.hidden = NO;
    
    CGRect frame = _contentView.frame;
    frame.origin.x = vectorx+20;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height * 0.04;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
    frame.size.height = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    _contentView.frame = frame;
    
    [self.view addSubview:_contentView];
    
}

- (void)setLawRuleView:(LawRuleViewController*)lawRuleViewController{
    _lawRuleViewController = lawRuleViewController;
}

- (IBAction)touchLibEvent:(id)sender{
    [_seachField resignFirstResponder];
    _libViewController = [[LibViewController alloc] init];
    
    _libViewController.delegate = self;
    
    [self.navigationController pushViewController:_libViewController animated:YES];
}

- (void)returnLib:(NSString *)lib code:(NSString *)code name:(NSString *)name{
    _lib = lib;
    _code = code;
    
    [_libButton setTitle:name forState:UIControlStateNormal];
    [_libButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)touchRecordEvent:(id)sender{
    _lawResultViewController = [[LawResultViewController alloc] init];
    _lawResultViewController.requestKey = @"Lawrulehistorylst";
    _lawResultViewController.lawResultType = LawResultTypeNormal;
    [self.navigationController pushViewController:_lawResultViewController animated:YES];
    
}

- (IBAction)touchKeyEvent:(id)sender{
    _lawResultViewController = [[LawResultViewController alloc] init];
    _lawResultViewController.requestKey = @"lawrulehotsearchlst";
    _lawResultViewController.lawResultType = LawResultTypeNormal;
    [self.navigationController pushViewController:_lawResultViewController animated:YES];
}

- (IBAction)touchLibraryEvent:(id)sender{
    _lawResultViewController = [[LawResultViewController alloc] init];
    _lawResultViewController.requestKey = @"Lawrulesearchhistorylst";
    _lawResultViewController.lawResultType = LawResultTypeNormal;
    [self.navigationController pushViewController:_lawResultViewController animated:YES];
}


- (IBAction)touchCloseEvent:(id)sender{
    [self.revealContainer clickBlackLayer];
}

- (NSDictionary*)loadParam:(NSString*)time
               lr_prov_lib:(NSString*)lr_prov_lib{
    NSString *search = @"";
    if ([_seachField hasText]) {
        search = _seachField.text;
    }
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"lr_id",
                            @"pkulaw",@"lr_provider",
                            @"",@"lr_prov_id",
                            lr_prov_lib,@"lr_prov_lib",
                            @"",@"lr_prov_category",
                            @"",@"lr_prov_title",
                            @"",@"lr_prov_issuedate",
                            @"",@"lr_prov_updatedate",
                            time,@"lr_search_date",
                            search,@"lr_search_key",
                            @"123.123.123.123",@"lr_ip_address",
                            @"232",@"lr_location",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"lawrulehistoryadd",@"requestKey",fields,@"fields", nil];
    return param;
}

- (IBAction)touchSureEvent:(id)sender{
    
    if (_lib.length == 0) {
        [self showHUDWithTextOnly:@"请选择相关法库"];
        return;
    }
    
    [_historyHttpClient startRequest:[self loadParam:[self.view getCurrentDate] lr_prov_lib:_lib]];
    
    _beidaSearchViewController = [[BeidaSearchViewController alloc] init];
    _beidaSearchViewController.lib = _lib;
    _beidaSearchViewController.category = _code;
    _beidaSearchViewController.searchKey = _seachField.text;
    [self.navigationController pushViewController:_beidaSearchViewController animated:YES];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    NSDictionary *dic = (NSDictionary*)responseObject;
    if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
        
    }
}

- (IBAction)touchClearEvent:(id)sender{
    _seachField.text = @"";
    [_libButton setTitle:@"请选择相关法库" forState:UIControlStateNormal];
    [_libButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

@end
