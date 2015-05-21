//
//  SegmentView.m
//  AirportService
//
//  Created by sugar on 13-9-14.
//  Copyright (c) 2013年 cares. All rights reserved.
//

#import "SegmentView.h"

#import "NSString+Utility.h"

@interface SegmentView (){
    NSArray *_titles;
    UIImageView *_imageview;
    UIImageView *_sliderView;
    
}

@end

@implementation SegmentView

@synthesize delegate = _delegate;
@synthesize isShow = _isShow;
@synthesize isTouchEvent = _isTouchEvent;
@synthesize buttons = _buttons;

@synthesize arrowImageView = arrowImageView;

static UIImage *_leftSelect;
static UIImage *_centerSelect;
static UIImage *_rightSelect;

static UIImage *_leftNormal;
static UIImage *_centerNormal;
static UIImage *_rightNormal;

static UIImage *bottom_arrow;



+ (void)initialize{
    _leftSelect = [UIImage imageNamed:@"left_select.png"];
    _centerSelect = [UIImage imageNamed:@"center_select.png"];
    _rightSelect = [UIImage imageNamed:@"right_select.png"];
    
    _leftNormal = [UIImage imageNamed:@"left_normal.png"];
    _centerNormal = [UIImage imageNamed:@"center_normal.png"];
    _rightNormal = [UIImage imageNamed:@"right_normal.png"];
    
    bottom_arrow = [UIImage imageNamed:@"nav_bottom_arrow.png"];

}

- (id)initWithTitle:(NSArray*)titles{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titles = titles;
        _buttons = [[NSMutableArray alloc] init];
        self.layer.borderWidth = 0.4f;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.cornerRadius = 5.0f;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    UIImage *image = [UIImage imageNamed:@"white_btn_ground.png"];
    image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:8];
    _imageview = [[UIImageView alloc] initWithFrame:self.frame];
    _imageview.image = image;
    _imageview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_imageview];
    
    int height = self.frame.size.height;
    float buttonWidth = self.frame.size.width/_titles.count;

    
    UIButton *firstButton = nil;
    for (int i = 0; i < _titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[_titles objectAtIndex:i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        if (_titles.count == 3) {
            if (i == 0) {
                [button setBackgroundImage:_leftNormal forState:UIControlStateNormal];
                [button setBackgroundImage:_leftSelect forState:UIControlStateSelected];
            }
            else if (i == 1){
                [button setBackgroundImage:_centerNormal forState:UIControlStateNormal];
                [button setBackgroundImage:_centerSelect forState:UIControlStateSelected];
            }
            else if (i == 2){
                [button setBackgroundImage:_rightNormal forState:UIControlStateNormal];
                [button setBackgroundImage:_rightSelect forState:UIControlStateSelected];
            }
        }
        else if (_titles.count ==2){
            if (i == 0) {
                [button setBackgroundImage:_leftNormal forState:UIControlStateNormal];
                [button setBackgroundImage:_leftSelect forState:UIControlStateSelected];
            }
            else if (i == 1){
                [button setBackgroundImage:_rightNormal forState:UIControlStateNormal];
                [button setBackgroundImage:_rightSelect forState:UIControlStateSelected];
            }
            
        }
        else if (_titles.count ==4){
            if (i == 0) {
                [button setBackgroundImage:_leftNormal forState:UIControlStateNormal];
                [button setBackgroundImage:_leftSelect forState:UIControlStateSelected];
            }
            else if (i == 1){
                [button setBackgroundImage:_centerNormal forState:UIControlStateNormal];
                [button setBackgroundImage:_centerSelect forState:UIControlStateSelected];
            }
            else if (i == 2){
                [button setBackgroundImage:_centerNormal forState:UIControlStateNormal];
                [button setBackgroundImage:_centerSelect forState:UIControlStateSelected];
            }
            else if (i == 3){
                [button setBackgroundImage:_rightNormal forState:UIControlStateNormal];
                [button setBackgroundImage:_rightSelect forState:UIControlStateSelected];
            }

            
        }
        
        [button addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(buttonWidth * i, 0, buttonWidth, height);
        [self addSubview:button];
        
        if (i ==0) {
            firstButton = button;
        }
        if (_isShow) {
            arrowImageView = [[UIImageView alloc] initWithImage:bottom_arrow];
            arrowImageView.contentMode = UIViewContentModeCenter;
            
            
            arrowImageView.frame = CGRectMake(button.frame.size.width - 10 -bottom_arrow.size.width, 0, bottom_arrow.size.width, self.frame.size.height);
            [button addSubview:arrowImageView];
        }
        
        
        
        [_buttons insertObject:button atIndex:i];
        
        
    }
    
    if (!_isTouchEvent) {
        [self clickSegment:firstButton];
    }
    else{
        firstButton.selected = YES;
    }
    
}

- (void)clickSegment:(UIButton*)button{
    for (UIButton *btn in _buttons) {
        if (btn.tag == button.tag) {
            btn.selected = YES;
        }
        else{
            
        }
        btn.selected = NO;
    }
    button.selected = YES;

    if ([_delegate respondsToSelector:@selector(didClickSegment:button:)]) {
        [_delegate didClickSegment:self button:button];
    }
}

@end
