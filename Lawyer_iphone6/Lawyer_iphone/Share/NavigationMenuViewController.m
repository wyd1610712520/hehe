//
//  NavigationMenuViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-1.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "NavigationMenuViewController.h"

#import "HomeViewController.h"

#import "LoginViewController.h"
#import "RevealViewController.h"

#import "RootViewController.h"

#import "CollectViewController.h"
#import "AuditViewController.h"

#import "UIViewController+Navigation.h"



@interface NavigationMenuViewController (){
    
    HomeViewController *_homeViewController;
    RootViewController *_rootViewController;
    
    CollectViewController *_collectViewController;
    
    AuditViewController *_auditViewController;
    
    UINavigationController *_auditNav;
    UINavigationController *_colloectNav;
}

@end

@implementation NavigationMenuViewController



+ (NavigationMenuViewController *)sharedInstance
{
    __strong static NavigationMenuViewController *instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[NavigationMenuViewController alloc] init];
    });
    return instance;
}

- (IBAction)touchCloseEvent:(id)sender{
    [self.view removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _homeViewController = [HomeViewController sharedInstance];
    _rootViewController = [RootViewController sharedInstance];

    
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
}




- (IBAction)touchHomeEvent:(UIButton*)sender{
    [self.view removeFromSuperview];
    if (_isSet) {
        [self backCenterView];
    }
    else{
        [_homeViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)backCenterView{
    [_rootViewController.view bringSubviewToFront:_homeViewController.view];
    _homeViewController.view.hidden = NO;
    [_rootViewController clickBlackLayer];
}

- (IBAction)touchMessageEvent:(id)sender{
    
}

- (IBAction)touchAuditEvent:(id)sender{
    UIViewController *viewcontroller = (UIViewController*)[[[self viewController] childViewControllers] lastObject];
    
    UIViewController *lastViewController = (UIViewController*)[viewcontroller.presentingViewController.childViewControllers lastObject];
    
    
    if (viewcontroller == _auditViewController) {
        [self showHUDWithTextOnly:@"您当前已在我的审核"];
    }
    else if (viewcontroller == _collectViewController && lastViewController == _auditViewController) {
        [viewcontroller dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self backCenterView];
        _auditViewController = [[AuditViewController alloc] init];
        _auditNav = [[UINavigationController alloc] initWithRootViewController:_auditViewController];
        
        
        if (viewcontroller == _collectViewController) {
            [_colloectNav presentViewController:_auditNav animated:YES completion:nil];
        }
        else{
            [viewcontroller presentViewController:_auditNav animated:YES completion:nil];
        }

    }

    
}



- (IBAction)touchFavoriteEvent:(id)sender{
    
    UIViewController *viewcontroller = (UIViewController*)[[[self viewController] childViewControllers] lastObject];
    
    UIViewController *lastViewController = (UIViewController*)[viewcontroller.presentingViewController.childViewControllers lastObject];
    
    
    if (viewcontroller == _collectViewController) {
        [self showHUDWithTextOnly:@"您当前已在我的审核"];
    }
    else if (viewcontroller == _auditViewController && lastViewController == _collectViewController){
        [viewcontroller dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        _collectViewController = [[CollectViewController alloc] init];
        [self backCenterView];
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        _colloectNav = [[UINavigationController alloc] initWithRootViewController:_collectViewController];
        
        if (viewcontroller == _auditViewController ) {
            [_auditNav presentViewController:_colloectNav animated:YES completion:nil];
        }
        else{
            [viewcontroller presentViewController:_colloectNav animated:YES completion:nil];
        }
        
    }
}


@end
