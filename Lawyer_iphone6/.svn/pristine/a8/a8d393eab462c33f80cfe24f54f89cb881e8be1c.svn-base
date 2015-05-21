//
//  CommentMenuViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-25.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommentMenuViewController.h"

#import "DocumentViewController.h"

#import "AttachViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"

@interface CommentMenuViewController ()<DocumentViewControllerDelegate,UIAlertViewDelegate,RequestManagerDelegate>{
    DocumentViewController *documentViewController;
    AttachViewController *_attachViewController;
    
    HttpClient *_httpClient;
}

@end

@implementation CommentMenuViewController

@synthesize record = _record;
@synthesize caseID = _caseID;
@synthesize cpr_ID = _cpr_ID;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    
    documentViewController = [[DocumentViewController alloc] init];
    
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

- (IBAction)touchCloseEvent:(id)sender {
    [self.view removeFromSuperview];
}

- (IBAction)touchReadEvent:(id)sender {
    documentViewController.pathString = [_record objectForKey:@"cpa_file_url"];
    documentViewController.type = [_record objectForKey:@"cpa_file_type"];
    documentViewController.name = [_record objectForKey:@"cpa_file_name"];
    documentViewController.delegate = self;
    documentViewController.view.tag = 100;
    [self presentViewController:documentViewController animated:YES completion:nil];
}

- (void)closeDocument{
}

- (IBAction)touchDeleteEvent:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [_httpClient startRequest:[self deleteParam]];
    }
}

- (NSDictionary*)deleteParam {
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getAccount],@"userID",_cpr_ID,@"ywcpID",[_record objectForKey:@"cpa_id"],@"cpaID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"processAttachmentDelete",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    if (request == _httpClient) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"删除成功"];
            [self.view removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteattach" object:nil];
        }
        else{
            [self showHUDWithTextOnly:@"删除失败"];
        }
    }
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

- (IBAction)touchSaveEvent:(id)sender {
    _attachViewController = [[AttachViewController alloc] init];
    _attachViewController.caseID = _caseID;
    _attachViewController.item = _record;
    _attachViewController.caseName = _caseName;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_attachViewController];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
