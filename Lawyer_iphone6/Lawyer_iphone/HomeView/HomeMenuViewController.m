//
//  HomeMenuViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "HomeMenuViewController.h"

#import "HomeViewController.h"

#import "UIViewController+Navigation.h"

#import "ResearchViewController.h"
#import "LawViewViewController.h"
#import "ContactViewController.h"
#import "BoxViewController.h"

#import "RootViewController.h"

@interface HomeMenuViewController (){
    ResearchViewController *_researchViewController;
//
    LawViewViewController *_lawViewViewController;
//
    BoxViewController *_boxViewController;
//
    ContactViewController *_contactViewController;
    
    RootViewController *_rootViewController;
    
    HomeViewController *_homeViewController;
    
    UINavigationController *_contactNav;
    UINavigationController *_boxNav;
}

@end

@implementation HomeMenuViewController


- (id)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    }
    return self;
}

- (void)setHomeView:(HomeViewController*)homeViewController{
    _homeViewController = homeViewController;
}

- (IBAction)touchCloseEvent:(id)sender{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = self.view.frame.size.height;
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lawViewViewController = [[LawViewViewController alloc] init];
    
    _boxViewController = [[BoxViewController alloc] init];
    
    _contactViewController = [[ContactViewController alloc] init];
    
    _rootViewController = [[RootViewController alloc] init];
    
    _contactNav = [[UINavigationController alloc] initWithRootViewController:_contactViewController];
    
    _boxNav = [[UINavigationController alloc] initWithRootViewController:_boxViewController];
}

- (IBAction)touchResearchEvent:(id)sender{
    _researchViewController = [[ResearchViewController alloc] init];
    [_homeViewController presentViewController:[self getNavigation:_researchViewController] animated:NO completion:nil];
}

- (IBAction)touchLawEvent:(id)sender{
    [_homeViewController presentViewController:[self getNavigation:_lawViewViewController] animated:NO completion:nil];
}

- (IBAction)touchBoxEvent:(id)sender{
    [_homeViewController presentViewController:_boxNav animated:NO completion:nil];
}

- (IBAction)touchContactEvent:(id)sender{
    [_homeViewController presentViewController:_contactNav animated:NO completion:nil];
}

@end
