//
//  CloseView.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-9.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CloseView.h"

@implementation CloseView

@synthesize tapGesture = _tapGesture;


- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCloseEvent)];
        _tapGesture.numberOfTapsRequired = 1;
        _tapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:_tapGesture];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCloseEvent)];
        _tapGesture.numberOfTapsRequired = 1;
        _tapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:_tapGesture];
    }
    return self;
}

- (void)touchCloseEvent{
    [self removeFromSuperview];
}




@end
