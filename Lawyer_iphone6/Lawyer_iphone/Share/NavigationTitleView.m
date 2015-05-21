//
//  NavigationTitleView.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-31.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "NavigationTitleView.h"

#import "NSString+Utility.h"

@implementation NavigationTitleView

@synthesize titleButton = _titleButton;
@synthesize titleLabel = _titleLabel;
@synthesize tap = _tap;
@synthesize arrowImageView = arrowImageView;

UIImage *bottom_arrow;


+ (void)initialize{
    bottom_arrow = [UIImage imageNamed:@"nav_bottom_arrow.png"];

    
}

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)setTitle:(NSString*)title target:(id)target action:(SEL)action{
//    _titleButton = [TitleButton buttonWithType:UIButtonTypeCustom];
//    
//    [_titleButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    _titleButton.translatesAutoresizingMaskIntoConstraints = NO;
//    [_titleButton setTitleColor:[@"#3293FE" colorValue] forState:UIControlStateNormal];
//    [self addSubview:_titleButton];
//    
//    [_titleButton showBorder:[UIColor redColor]];
//    
//    [_titleButton sizeToFit];
//    
//    [_titleButton addConstraint:[NSLayoutConstraint constraintWithItem:_titleButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.frame.size.width]];
//    [_titleButton addConstraint:[NSLayoutConstraint constraintWithItem:_titleButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.frame.size.height]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
//   
//    
//    [_titleButton setTitle:title forState:UIControlStateNormal];
    
    _titleLabel = [[UILabel alloc] initWithFrame:self.frame];
    [_titleLabel setTextColor:[@"#3293FE" colorValue]];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _titleLabel.text = title;
    [self addSubview:_titleLabel];
    _titleLabel.numberOfLines = 1;
    //[_titleLabel sizeToFit];
    _titleLabel.center = self.center;
    
    arrowImageView = [[UIImageView alloc] initWithImage:bottom_arrow];
    arrowImageView.contentMode = UIViewContentModeCenter;
    
    CGRect frame = [_titleLabel textRectForBounds:self.frame limitedToNumberOfLines:1];
    
    arrowImageView.frame = CGRectMake(frame.origin.x+frame.size.width, 0, bottom_arrow.size.width, self.frame.size.height);
    [self addSubview:arrowImageView];
    
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    _tap.numberOfTapsRequired = 1;
    _tap.delegate = self;
    _tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:_tap];
    
}

- (CABasicAnimation *)rotation:(float)dur start:(float)start end:(float)end
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = dur;
    animation.repeatCount = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber numberWithFloat:start];
    animation.toValue = [NSNumber numberWithFloat: end];
    
    return animation;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    if (_tap == gestureRecognizer) {
//        if (isRotation) {
//            isRotation = NO;
//            [arrowImageView.layer addAnimation:[self rotation:0.3 start:M_PI end:0] forKey:nil];
//        }
//        else{
//            isRotation = YES;
//            [arrowImageView.layer addAnimation:[self rotation:0.3 start:0 end:M_PI] forKey:nil];
//        }
//    }
    return YES;
}

@end



@implementation TitleButton

UIImage *bottom_arrow;
UIImageView *arrowImageView;

TitleButton *btn;

+ (void)initialize{
    bottom_arrow = [UIImage imageNamed:@"nav_bottom_arrow.png"];
    arrowImageView = [[UIImageView alloc] initWithImage:bottom_arrow];
    arrowImageView.contentMode = UIViewContentModeCenter;
    
}

+ (id)buttonWithType:(UIButtonType)buttonType{
    btn = [super buttonWithType:buttonType];
    [btn addSubview:arrowImageView];
    return btn;
}

- (void)didAddSubview:(UIView *)subview{
    arrowImageView.frame = CGRectMake(self.frame.size.width-bottom_arrow.size.width, 0, bottom_arrow.size.width, self.frame.size.height);
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [super sendAction:action to:target forEvent:event];
    if (isRotation) {
        isRotation = NO;
        [arrowImageView.layer addAnimation:[self rotation:0.3 start:M_PI end:0] forKey:nil];
    }
    else{
        isRotation = YES;
        [arrowImageView.layer addAnimation:[self rotation:0.3 start:0 end:M_PI] forKey:nil];
    }
}

- (CABasicAnimation *)rotation:(float)dur start:(float)start end:(float)end
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = dur;
    animation.repeatCount = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber numberWithFloat:start];
    animation.toValue = [NSNumber numberWithFloat: end];
    
    return animation;
}


@end