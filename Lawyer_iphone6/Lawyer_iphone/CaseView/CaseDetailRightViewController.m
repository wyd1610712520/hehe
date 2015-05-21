//
//  CaseDetailRightViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-3.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CaseDetailRightViewController.h"

#import "RootViewController.h"
#import "CaseDetatilViewController.h"

#import "RootViewController.h"

#import "ResearchViewController.h"

#import "ProfileViewController.h"
#import "CommomClient.h"
@interface CaseDetailRightViewController (){
    CaseDetatilViewController *_caseDetatilViewController;
    ResearchViewController *_researchViewController;
    RootViewController *_rootViewController;
    
    ProfileViewController *_profileViewController;
}

@end

@implementation CaseDetailRightViewController

@synthesize contentView = _contentView;


- (void)setCaseDetailView:(CaseDetatilViewController*)caseDetatilViewController{
    _caseDetatilViewController = caseDetatilViewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    _caseDetatilViewController.navigationController.view.hidden = NO;
    
   
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.navigationController.navigationBarHidden = YES;
    _caseDetatilViewController.navigationController.view.hidden = NO;
    
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    _caseDetatilViewController.navigationController.view.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightbackground.png"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:imageView atIndex:0];
    
    CGRect frame = _contentView.frame;
    frame.origin.x = vectorx;
    frame.origin.y = 20;
    frame.size.width = vector_x;
    frame.size.height = [UIScreen mainScreen].bounds.size.height * 0.8;
    _contentView.frame = frame;
    
    [self.view addSubview:_contentView];

    
}

- (IBAction)touchClientEvent:(id)sender{
    _rootViewController = [[RootViewController alloc] init];
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController showInClientDetail];
    _rootViewController.clientDetailViewController.clientId = [_record objectForKey:@"cl_client_id"];

}

- (IBAction)touchCaseProcessEvent:(id)sender{
    _rootViewController = [[RootViewController alloc] init];
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController showInProcessDetail];
    _rootViewController.processDetailViewController.caseID = _caseid;
}

- (IBAction)touchCaseSearchEvent:(id)sender{
    _researchViewController = [[ResearchViewController alloc] init];
    _researchViewController.record = _record;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_researchViewController];
    [self presentViewController:nav animated:NO completion:nil];
}

- (IBAction)touchCaseLogEvent:(id)sender{
    _rootViewController = [[RootViewController alloc] init];
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController showInLog];
    _rootViewController.logViewController.caseId = _caseid;

}

- (IBAction)touchCasedocEvent:(id)sender{
    _rootViewController = [[RootViewController alloc] init];
    
    NSString *string = [[CommomClient sharedInstance] getValueFromUserInfo:@"docClassSplit"];
    
    
    NSString *clssid = [NSString stringWithFormat:@"M4%@%@",string,_caseid];
    
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController showInFile];
    _rootViewController.fileViewController.caseClassId =clssid;
}

- (IBAction)touchCloseEvent:(id)sender{
    [self.revealContainer clickBlackLayer];
}



@end
