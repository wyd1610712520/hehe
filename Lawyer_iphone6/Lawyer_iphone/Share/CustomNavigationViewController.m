//
//  CustomNavigationViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-9-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "MenuView.h"

#import "NavigationTitleView.h"

#import "NavigationMenuViewController.h"

#import "NSString+Utility.h"

@interface CustomNavigationViewController (){
    MenuView *_menuView;
    
    NavigationMenuViewController *_navigationMenuViewController;
    
    NavigationTitleView *navigationTitleView;
}

@end

@implementation CustomNavigationViewController

@synthesize titleSegment = _titleSegment;


- (void)setLeftButton:(UIImage*)image target:(id)target action:(SEL)action{
    
    UIImage *backgroundImage = [image copy];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.frame = CGRectMake(0, 0, 60, 44);
    [button setImage:backgroundImage forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBar;
}

- (void)setCenterView:(UIImage*)image targer:(id)target action:(SEL)action{
    UIImage *backgroundImage = [image copy];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = button;
}

- (void)setTitleView:(NSArray*)titles{
    _titleSegment = [[SegmentView alloc] initWithTitle:titles];
    _titleSegment.frame = CGRectMake(0, 0,170,30);
    
    self.navigationItem.titleView = _titleSegment;
}

- (void)setRightButton:(UIImage*)image title:(NSString*)title target:(id)target action:(SEL)action{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    if (image) {
        UIImage *backgroundImage = [image copy];
        [button setImage:backgroundImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
     }
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 70, 44);
        [button setTitleColor:[@"3293FE" colorValue] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    }
    
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (UIButton*)setNavigationSegmentWithImages:(NSArray*)images target:(id)target action:(SEL)action{
    
    NavigationSegmentView *view = [[NavigationSegmentView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [view setImages:images target:target action:action];
    
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightBar;
    return view.firstButton;
}



- (void)setTitle:(NSString *)title color:(UIColor*)color{
    navigationTitleView = [[NavigationTitleView alloc] init];
    if (Iphone6) {
        navigationTitleView.frame = CGRectMake(0, 0, 170, 44);
    }
    else if (Iphone6s){
        navigationTitleView.frame = CGRectMake(0, 0, 220, 44);
    }
    else{
        navigationTitleView.frame = CGRectMake(0, 0, 140, 44);
    }
    [self.view bringSubviewToFront:navigationTitleView.arrowImageView];
    
    [navigationTitleView setTitle:title target:self action:@selector(touchAlertView)];
    self.navigationItem.titleView = navigationTitleView;
    
}

- (void)touchAlertView{
    _navigationMenuViewController.view.frame = self.navigationController.view.frame;
    _navigationMenuViewController.isSet = _isSet;
    [self.navigationController.view addSubview:_navigationMenuViewController.view];
    NSLog(@"%@===",[_navigationMenuViewController.view subviews]);
}



- (void)popSelf {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)setDismissButton{
    [self setLeftButton:[UIImage imageNamed:@"NavBackButton.png"] target:self action:@selector(dismiss)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *subviews = self.navigationController.viewControllers;
    if (subviews.count > 1) {
        [self setLeftButton:[UIImage imageNamed:@"NavBackButton.png"] target:self action:@selector(popSelf)];
    }
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    _navigationMenuViewController = [NavigationMenuViewController sharedInstance];
    
}



@end
