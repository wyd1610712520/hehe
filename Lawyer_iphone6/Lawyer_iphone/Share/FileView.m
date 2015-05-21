//
//  FileView.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-1.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "FileView.h"

#import "DocumentViewController.h"


@interface FileView (){
}

@end


@implementation FileView

@synthesize delegate = _delegate;

@synthesize titleLabel = _titleLabel;
@synthesize nameLabel = _nameLabel;
@synthesize dateLabel = _dateLabel;
@synthesize logoImageView = _logoImageView;

@synthesize filePath = _filePath;

@synthesize button = _button;
@synthesize arrowImageView = _arrowImageView;
@synthesize lineView = _lineView;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow.png"]];
        _arrowImageView.frame = CGRectMake(self.frame.size.width-20,(frame.size.height-12)/2 , 9, 12);
        [self addSubview:_arrowImageView];
        
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (frame.size.height - 36)/2, 36, 36)];
        [self addSubview:_logoImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_logoImageView.frame.origin.x+_logoImageView.frame.size.width+8, 10, 200, 20)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLabel];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.size.height+_titleLabel.frame.origin.y, 200, 20)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_nameLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.size.width+_nameLabel.frame.origin.x+10, _nameLabel.frame.origin.y, 200, 20)];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textColor = [UIColor lightGrayColor];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_dateLabel];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = self.bounds;
        [_button addTarget:self action:@selector(touchDocEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        
        _lineView = [[LineView alloc] initWithFrame:CGRectMake(10, frame.size.height - 1, self.frame.size.width-20, 0.5)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineView];
    }
    return self;
}

- (void)touchDocEvent{
    if ([_delegate respondsToSelector:@selector(fileView:tag:)]) {
        [_delegate fileView:self tag:self.tag];
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

@end
