//
//  SearchField.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-9-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "SearchField.h"

#import "NSString+Utility.h"

@implementation SearchField

@synthesize textField = _textField;
@synthesize tintLabel;
@synthesize searchImageView;
@synthesize closeButton;
@synthesize deleteButton = _deleteButton;

@synthesize delegate;

- (id)init{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

- (void)drawRect:(CGRect)rect {
    
}

- (void)initView{
    self.backgroundColor = [@"#EEEEEE" colorValue];
    
    UIImage *backImage = [UIImage imageNamed:@"search_background_white.png"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    backImageView.frame = CGRectMake(10, 5, self.frame.size.width - 20, self.frame.size.height-10);
    backImageView.center = self.center;
    [self addSubview:backImageView];
    
    
    UIImage *searchImage = [UIImage imageNamed:@"search_gray_logo.png"];
    searchImageView = [[UIImageView alloc] initWithImage:searchImage];
    searchImageView.frame = CGRectMake(0, 10, searchImage.size.width, searchImage.size.height);
    searchImageView.center = CGPointMake(self.center.x-30,self.center.y);
    [self addSubview:searchImageView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 10, self.frame.size.width-80,self.frame.size.height-20)];

    _textField.returnKeyType = UIReturnKeySearch;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.delegate = self;
    [self addSubview:_textField];
    
    
    tintLabel = [[UILabel alloc] initWithFrame:CGRectMake(searchImageView.frame.origin.x+searchImageView.frame.size.width+5,10, 150, self.textField.frame.size.height)];
    tintLabel.textColor = [UIColor grayColor];
    tintLabel.text = @"搜 索";
    [self addSubview:tintLabel];
    
    _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-40, 0, 30, self.frame.size.height)];
    [_deleteButton setImage:[UIImage imageNamed:@"close_logo.png"] forState:UIControlStateNormal];
    _deleteButton.hidden = YES;
    _deleteButton.contentMode = UIViewContentModeCenter;
    [_deleteButton addTarget:self action:@selector(deleteChar) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_deleteButton];
}


- (void)deleteChar{
    _textField.text = @"";
    
    if ([delegate respondsToSelector:@selector(searchStart:)]) {
        [delegate searchStart:@""];
    }
    _deleteButton.hidden = YES;

}


- (void)setTitle:(NSString*)title{
    
    if (title.length > 0 && ![title isEqualToString:@""]) {
        _textField.text = title;
        _deleteButton.hidden = NO;
        [self textFieldShouldBeginEditing:_textField];
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = searchImageView.frame;
            frame.origin.x = 20;
            searchImageView.frame = frame;
            [tintLabel removeFromSuperview];
            tintLabel = nil;
        }];
        
    }
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = searchImageView.frame;
        frame.origin.x = 20;
        searchImageView.frame = frame;
        [tintLabel removeFromSuperview];
        tintLabel = nil;
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([delegate respondsToSelector:@selector(searchStart:)]) {
        [delegate searchStart:textField.text];
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length == 0 && range.location == 0) {
        _deleteButton.hidden = YES;
        if ([delegate respondsToSelector:@selector(searchStart:)]) {
            [delegate searchStart:@""];
        }

    }
    else{
        _deleteButton.hidden = NO;
    }
    return YES;
}




@end
