//
//  HomeViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-8.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "HomeViewController.h"


#import "ClientViewController.h"

#import "RootViewController.h"

#import "NewsViewController.h"

#import "UIViewController+Navigation.h"

#import "HomeMenuViewController.h"

#import "CooperationViewController.h"
#import "CollectViewController.h"
#import "AuditViewController.h"

#import "HttpClient.h"

@interface HomeViewController ()<UITextFieldDelegate,RequestManagerDelegate>{
    NSArray *_buttons;
    
    ClientViewController *_clientViewController;
    UINavigationController *_clientNav;
    
    RootViewController *_rootViewController;
    
    NewsViewController *_newsViewController;
    
    HomeMenuViewController *_homeMenuViewController;
    
    CollectViewController *_collectViewController;
    
    AuditViewController *_auditViewController;
    
    HttpClient *_httpClient;
}

@end

@implementation HomeViewController

@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize backgroundView = _backgroundView;
@synthesize topView = _topView;
@synthesize centerView = _centerView;

@synthesize searchField = _searchField;

@synthesize logButton = _logButton;
@synthesize schemaButton = _schemaButton;
@synthesize processButton = _processButton;
@synthesize cooperationButton = _cooperationButton;
@synthesize newsButton = _newsButton;
@synthesize docButton = _docButton;

+ (HomeViewController *)sharedInstance
{
    __strong static HomeViewController *instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[HomeViewController alloc] init];
    });
    return instance;
}

- (IBAction)touchClientEvent:(id)sender {
    _clientViewController = [[ClientViewController alloc] init];
    _clientNav = [[UINavigationController alloc] initWithRootViewController:_clientViewController];
    _clientViewController.searchKey = _searchField.text;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:_clientNav animated:NO completion:nil];

    
}

- (IBAction)touchCaseEvent:(id)sender {
    _rootViewController = [[RootViewController alloc] init];
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController showInCase];
    [_rootViewController.caseViewController setRootView:_rootViewController];
    _rootViewController.caseViewController.searchKey = _searchField.text;

}

- (IBAction)touchLogEvent:(id)sender{
    _rootViewController = [[RootViewController alloc] init];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController showInLog];
    [_rootViewController.logViewController setRootView:_rootViewController];

}

- (IBAction)touchCooperationEvent:(id)sender{
    _rootViewController = [[RootViewController alloc] init];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController showCooperation];
    [_rootViewController.cooperationViewController setRootView:_rootViewController];

}

- (IBAction)touchFileView:(id)sender{
    _rootViewController = [[RootViewController alloc] init];
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController showInFile];
    [_rootViewController.fileViewController setRootView:_rootViewController];
    _rootViewController.fileViewController.fileOperation = FileOperationNormal;
    _rootViewController.fileViewController.fileState = FileStateNormal;
}

- (IBAction)touchSchemaEvent:(id)sender{
    
    _rootViewController = [[RootViewController alloc] init];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController showInSchema];
    
}

- (IBAction)touchCollectEvent:(id)sender{
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:[self getNavigation:_collectViewController] animated:YES completion:nil];
}

- (IBAction)touchNewsEvent:(id)sender {
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:[self getNavigation:_newsViewController] animated:YES completion:nil];
}

- (IBAction)touchLeftEvent:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AvatorUpdate" object:nil];
    [[RootViewController sharedInstance].setupViewController.navigationController popToRootViewControllerAnimated:YES];
    [self.revealContainer showLeft];
}

- (IBAction)touchProcessView:(id)sender{
    _rootViewController = [[RootViewController alloc] init];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:_rootViewController animated:NO completion:nil];
    [_rootViewController.processViewController setRootView:_rootViewController];
    [_rootViewController showInProcess];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"attationcnt",@"requestKey", nil];
    [_httpClient startRequest:dic];

    _collectViewController = [[CollectViewController alloc] init];
    
    _buttons = [NSArray arrayWithObjects:_logButton,_schemaButton,_processButton,_cooperationButton,_newsButton,_docButton, nil];
    
    UIImage *leftImage = [UIImage imageNamed:@"search_white_logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:leftImage];
    
    _searchField.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    _searchField.leftView = imageView;
    _searchField.leftViewMode = UITextFieldViewModeAlways;
    _searchField.leftMargin = 17;
    
    //
    _newsViewController = [[NewsViewController alloc] init];
    
    _homeMenuViewController = [[HomeMenuViewController alloc] init];
    _homeMenuViewController.view.frame = [UIScreen mainScreen].bounds;
    [_homeMenuViewController setHomeView:self];
    
}

- (void)request:(id)request didCompleted:(id)responseObject{
    NSDictionary *result = (NSDictionary*)responseObject;
    NSDictionary *record = [result objectForKey:@"record"];
    NSString *num = (NSString*)[record objectForKey:@"workattcnt"];
    if ([num integerValue] > 0) {
        _hotImageView.hidden = NO;
    }
    else{
        _hotImageView.hidden = YES;
    }
}

- (void)requestFailed:(id)request{
    _hotImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_searchField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_searchField resignFirstResponder];
    return YES;
}


- (IBAction)touchAuditEvent:(id)sender{
    _auditViewController = [[AuditViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_auditViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)touchMenuEvent:(id)sender{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = _homeMenuViewController.view.frame;
        frame.origin.y = 0;
        _homeMenuViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    [self.view addSubview:_homeMenuViewController.view];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if (Iphone6) {
        for (OBShapedButton *button in _buttons) {
            for (NSLayoutConstraint *layout in button.constraints) {
                if (layout.firstAttribute == NSLayoutAttributeHeight) {
                    layout.constant = 183;
                }
                if (layout.firstAttribute == NSLayoutAttributeWidth) {
                    layout.constant = 183;
                }
                
            }
        }
        
        for (NSLayoutConstraint *layout in _contentView.constraints) {
            //log
            if (layout.firstItem == _logButton && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 27;
            }
            if (layout.firstItem == _logButton && layout.firstAttribute == NSLayoutAttributeLeading) {
                layout.constant = 95;
            }
            //schema
            if (layout.firstItem == _schemaButton && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 122;
            }
            if (layout.firstItem == _schemaButton && layout.firstAttribute == NSLayoutAttributeLeading) {
                layout.constant = 0;
            }
            //process
            if (layout.firstItem == _processButton && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 122;
            }
            if (layout.firstItem == _processButton && layout.firstAttribute == NSLayoutAttributeTrailing) {
                layout.constant = 0;
            }
            
            //news
            if (layout.firstItem == _newsButton && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 8;
            }
            if (layout.firstItem == _newsButton && layout.firstAttribute == NSLayoutAttributeLeading) {
                layout.constant = 0;
            }
            
            //doc
            if (layout.firstItem == _docButton && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 8;
            }
            if (layout.firstItem == _docButton && layout.firstAttribute == NSLayoutAttributeTrailing) {
                layout.constant = 0;
            }
            
        }
        
    }
    if (Iphone6s) {
        
        for (OBShapedButton *button in _buttons) {
            for (NSLayoutConstraint *layout in button.constraints) {
                if (layout.firstAttribute == NSLayoutAttributeHeight) {
                    layout.constant = 203;
                }
                if (layout.firstAttribute == NSLayoutAttributeWidth) {
                    layout.constant = 203;
                }
                
            }
        }
        
        for (NSLayoutConstraint *layout in _contentView.constraints) {
            //log
            if (layout.firstItem == _logButton && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 27;
            }
            if (layout.firstItem == _logButton && layout.firstAttribute == NSLayoutAttributeLeading) {
                layout.constant = 105;
            }
            //schema
            if (layout.firstItem == _schemaButton && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 134;
            }
            if (layout.firstItem == _schemaButton && layout.firstAttribute == NSLayoutAttributeLeading) {
                layout.constant = 0;
            }
            //process
            if (layout.firstItem == _processButton && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 134;
            }
            if (layout.firstItem == _processButton && layout.firstAttribute == NSLayoutAttributeTrailing) {
                layout.constant = 0;
            }
            
            //news
            if (layout.firstItem == _newsButton && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 8;
            }
            if (layout.firstItem == _newsButton && layout.firstAttribute == NSLayoutAttributeLeading) {
                layout.constant = 0;
            }
            
            //doc
            if (layout.firstItem == _docButton && layout.firstAttribute == NSLayoutAttributeTop) {
                layout.constant = 8;
            }
            if (layout.firstItem == _docButton && layout.firstAttribute == NSLayoutAttributeTrailing) {
                layout.constant = 0;
            }
            
        }
    }
    
    if (unIphone4) {
        NSMutableArray *temp = [[NSMutableArray alloc] init];
    
        for (NSLayoutConstraint *layout in _contentView.constraints) {
            if (layout.firstItem == _contentView && layout.firstAttribute == NSLayoutAttributeHeight) {
                [temp addObject:layout];
            }
            if (layout.firstItem == _contentView && layout.firstAttribute == NSLayoutAttributeWidth) {
                [temp addObject:layout];
            }
        }
        
        [_contentView removeConstraints:temp];
        

        
        [self.view addConstraint:[NSLayoutConstraint
                                  constraintWithItem:_contentView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                  multiplier:1
                                  constant:0]];
        [self.view addConstraint:[NSLayoutConstraint
                                  constraintWithItem:_contentView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                  multiplier:1
                                  constant:0]];

        
     }
    
    
}



@end
