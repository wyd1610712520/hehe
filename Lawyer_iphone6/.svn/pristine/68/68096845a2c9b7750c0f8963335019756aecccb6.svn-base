//
//  UIViewController+Navigation.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-5.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "UIViewController+Navigation.h"



@implementation UIViewController (Navigation)

- (UIViewController*)getNavigation:(UIViewController*)viewController{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    nav.navigationBar.translucent = NO;
    return nav;
}

- (UIViewController *)viewController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
