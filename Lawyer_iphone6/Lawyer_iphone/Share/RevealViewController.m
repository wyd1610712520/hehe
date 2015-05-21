//
//  RevealViewController.m
//  Lawyer_Iphone
//
//  Created by 邬 明 on 14-4-14.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "RevealViewController.h"



@interface RevealViewController ()<UIGestureRecognizerDelegate>{
    CGFloat beginPoint;
    
    UIView *touchView;
}

@end

@implementation RevealViewController

@synthesize centerViewController = _centerViewController;
@synthesize leftViewController = _leftViewController;
@synthesize rightViewController = _rightViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setCenterViewController:(UIViewController *)centerViewController{
    _centerViewController = centerViewController;
    _centerViewController.view.frame = self.view.bounds;
    [self.view addSubview:_centerViewController.view];
    [self addChildViewController:_centerViewController];
    touchView = _centerViewController.view;
    [touchView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setRightViewController:(UIViewController *)rightViewController{
    _rightViewController = rightViewController;
    _rightViewController.view.frame = self.view.bounds;
    [self.view insertSubview:_rightViewController.view atIndex:0];
    [self addChildViewController:_rightViewController];
    _rightViewController.view.hidden = YES;
}

- (void)setLeftViewController:(UIViewController *)leftViewController{
    _leftViewController = leftViewController;
    _leftViewController.view.frame = self.view.bounds;
    [self.view insertSubview:_leftViewController.view atIndex:0];
    [self addChildViewController:_leftViewController];
    _leftViewController.view.hidden = YES;

}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showRight{
    _rightViewController.view.hidden = NO;
    _leftViewController.view.hidden = YES;
    [UIView animateWithDuration:animationTime animations:^{
        CGRect frame = touchView.frame;
        float x = frame.origin.x;
        if (x == 0) {
            x = -vector_x;
        }
        else{
            x = 0.0;
        }
        frame.origin.x = x;
        touchView.frame = frame;
        
        CGAffineTransform affine = CGAffineTransformMakeScale(1, scale_x);
        touchView.transform = affine;
        
    } completion:^(BOOL finished) {
        beginPoint = touchView.frame.origin.x;
       // [[NSNotificationCenter defaultCenter] postNotificationName:RevealViewSlideEnd object:nil];
    }];

}

- (void)showLeft{
    _rightViewController.view.hidden = YES;
    _leftViewController.view.hidden = NO;
    [UIView animateWithDuration:animationTime animations:^{
        CGRect frame = touchView.frame;
        float x = frame.origin.x;
        if (x == 0) {
            x = vector_x;
        }
        else{
            x = 0.0;
        }
        frame.origin.x = x;
        touchView.frame = frame;
        
        CGAffineTransform affine = CGAffineTransformMakeScale(1, scale_x);
        touchView.transform = affine;
    } completion:^(BOOL finished) {
        beginPoint = touchView.frame.origin.x;
    }];

}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [_centerViewController.view removeFromSuperview];
//    [_leftViewController.view removeFromSuperview];
//    [_rightViewController.view removeFromSuperview];
//}

- (void)showCenter{
    [UIView animateWithDuration:animationTime animations:^{
        CGRect frame = touchView.frame;
        float x = frame.origin.x;
        if (x != 0) {
            x = 0;
        }
        frame.origin.x = x;
        touchView.frame = frame;
        
        CGAffineTransform affine = CGAffineTransformMakeScale(1, 1);
        touchView.transform = affine;
        
    } completion:^(BOOL finished) {
        beginPoint = touchView.frame.origin.x;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_leftViewController) {
            }
    
    
    
    if (_centerViewController) {
        
    }
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    pan.delegate = self;
    [touchView addGestureRecognizer:pan];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]) {
        NSValue *frame =  (NSValue*)[change objectForKey:@"new"];
        if (frame.CGRectValue.origin.x != 0) {
            [self addBlackLayer];
        }
        else{
            [self removeBlackLayer];
        }
        
        if (frame.CGRectValue.origin.x > 0) {
            _rightViewController.view.hidden = YES;
            _leftViewController.view.hidden = NO;
        }
        else if (frame.CGRectValue.origin.x < 0){
            _rightViewController.view.hidden = NO;
            _leftViewController.view.hidden = YES;
        }
    }
}

- (void)addBlackLayer{
    UIView *backview = (UIView*)[touchView viewWithTag:backviewTag];
    if (!backview) {
        backview = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        backview.backgroundColor = [UIColor clearColor];
        
        backview.tag = backviewTag;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBlackLayer)];
        [backview addGestureRecognizer:tap];
    }
    [touchView addSubview:backview];
}

- (void)clickBlackLayer{
    [self showCenter];
}

- (void)removeBlackLayer{
    UIView *view= (UIView*)[touchView viewWithTag:backviewTag];
    if (view) {
        [view removeFromSuperview];
    }
}


- (void)viewDidUnload{
    [touchView removeObserver:self forKeyPath:@"frame"];
}

- (void)dealloc{
    [touchView removeObserver:self forKeyPath:@"frame"];
}

- (void)handlePan:(UIPanGestureRecognizer*)panGesture{
//    CGPoint vectorPoint = [panGesture translationInView:touchView];
//    
//
//    
//    CGRect frame = touchView.frame;
//    if (!_leftViewController && vectorPoint.x > 0 && frame.origin.x >= 0) {
//        return ;
//    }
//    
//    if (!_rightViewController && vectorPoint.x < 0 && frame.origin.x <= 0) {
//        return ;
//    }
//    
//    frame.origin.x = vectorPoint.x + beginPoint;
//    touchView.frame = frame;
//    
//    float scale = 0.0;
//    
//    if (vectorPoint.x >0) {
//        
//        if (touchView.frame.origin.x > 0) {
//            scale = (vector_x - fabs(vectorPoint.x)*0.1)/vector_x;
//        }
//        else{
//            scale = fabs(vectorPoint.x)*0.1/vector_x + scale_x;
//        }
//    }
//    else{
//        if (touchView.frame.origin.x > 0) {
//            
//            scale = fabs(vectorPoint.x)*0.1/vector_x + scale_x;
//        }
//        else{
//            scale = (vector_x - fabs(vectorPoint.x)*0.1)/vector_x;
//        }
//    }
//    
//    if (scale < scale_x) {
//        scale = scale_x;
//    }
//    else if (scale > 1.0){
//        scale = 1.0;
//    }
//    NSLog(@"scale==%f",scale);
//    CGAffineTransform affine = CGAffineTransformMakeScale(1, scale);
//    _centerViewController.view.transform = affine;
//
//    
//    if (panGesture.state == UIGestureRecognizerStateEnded){
//        if (vectorPoint.x > 0 && fabs(touchView.frame.origin.x) > 100 ) {
//            [UIView animateWithDuration:animationTime animations:^{
//                CGRect frame = touchView.frame;
//                if (frame.origin.x < 0) {
//                    frame.origin.x = -vector_x;
//                }
//                else{
//                    frame.origin.x = vector_x;
//                }
//                touchView.frame = frame;
//                
//                CGAffineTransform affine = CGAffineTransformMakeScale(1, scale_x);
//                _centerViewController.view.transform = affine;
//            } completion:^(BOOL finished) {
//                beginPoint = touchView.frame.origin.x;
//            }];
//        }
//        else if (vectorPoint.x < 0 && fabs(touchView.frame.origin.x) > 100) {
//            [UIView animateWithDuration:animationTime animations:^{
//                CGRect frame = touchView.frame;
//                if (frame.origin.x > 0) {
//                    frame.origin.x = vector_x;
//                }
//                else{
//                    frame.origin.x = -vector_x;
//                }
//                touchView.frame = frame;
//                
//                CGAffineTransform affine = CGAffineTransformMakeScale(1, scale_x);
//                _centerViewController.view.transform = affine;
//            } completion:^(BOOL finished) {
//                beginPoint = touchView.frame.origin.x;
//                //[[NSNotificationCenter defaultCenter] postNotificationName:RevealViewSlideEnd object:nil];
//            }];
//        }
//        else if (fabs(touchView.frame.origin.x) <= 100){
//            [UIView animateWithDuration:animationTime animations:^{
//                CGRect frame = touchView.frame;
//                frame.origin.x = 0;
//                touchView.frame = frame;
//                
//                CGAffineTransform affine = CGAffineTransformMakeScale(1, 1);
//                _centerViewController.view.transform = affine;
//            } completion:^(BOOL finished) {
//                beginPoint = touchView.frame.origin.x;
//            }];
//        }
//
//    }

}



@end


@implementation UIViewController (RevealViewController)

- (RevealViewController*)revealContainer{
    RevealViewController *revealContainer = nil;
    UIViewController *attempt = self.parentViewController;
    while (true) {
        if (!attempt) break;
        if ([attempt isKindOfClass:[RevealViewController class]]) {
            revealContainer = (RevealViewController *) attempt;
            break;
        } else {
            attempt = attempt.parentViewController;
            
        }
    }
    return revealContainer;
}

@end
