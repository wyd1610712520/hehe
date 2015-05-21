//
//  CustomSegment.m
//  Lawyer_Iphone
//
//  Created by 邬 明 on 14-4-21.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomSegment.h"

#import "NSString+Utility.h"

@interface CustomSegment (){
    CGRect _frame;
    UIImageView *imageView;
    
    UIButton *_firstButton;
}

@end

@implementation CustomSegment

@synthesize segmentDelegate = _segmentDelegate;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _frame = frame;
        self.backgroundColor = [@"E5F1FF" colorValue];
        self.showsHorizontalScrollIndicator = NO;
        
        

    }
    return self;
}

- (void)setSegmentWithTitles:(NSArray*)titles{
    _leftMargin = 0;
    _width = _frame.size.width/titles.count;
    _height = _frame.size.height;
    _hSpace = 0;
    float allWidth = 0.0f;
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.frame = CGRectMake(_leftMargin+i*_width+i*_hSpace, 0, _width, _height);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [self addSubview:button];
        [button addTarget:self action:@selector(clickSegments:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_slideBar.png"]];
            imageView.frame = button.frame;
            [self addSubview:imageView];
            _firstButton = button;
        }
        allWidth = button.frame.origin.x + button.frame.size.width;
    }
    [self setContentSize:CGSizeMake(allWidth, _height)];
    
}

- (void)clickFirstEvent{
    [self clickSegments:_firstButton];
}

- (void)clickSegments:(UIButton*)sender{
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = sender.frame;
    }];
    if ([_segmentDelegate respondsToSelector:@selector(touchSegment:tag:)]) {
        [_segmentDelegate touchSegment:self tag:sender.tag];
    }
}

@end
