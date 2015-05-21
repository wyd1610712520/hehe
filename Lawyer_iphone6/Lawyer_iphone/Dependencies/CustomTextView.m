//
//  CustomTextView.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomTextView.h"

@interface CustomTextView (){
    UILabel *PlaceholderLabel;
}

@end

@implementation CustomTextView

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}


- (void)awakeFromNib {
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5f;
    self.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
    
    float left=5,top=2,hegiht=30;
    
    self.placeholderColor = [UIColor lightGrayColor];
    PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                               , CGRectGetWidth(self.frame)-2*left, hegiht)];
    PlaceholderLabel.font=self.placeholderFont?self.placeholderFont:self.font;
    PlaceholderLabel.textColor=self.placeholderColor;
    [self addSubview:PlaceholderLabel];
    PlaceholderLabel.text=self.placeholder;
    
}

-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""] || [self hasText]) {
        PlaceholderLabel.hidden=YES;
    }
    else
        PlaceholderLabel.text=placeholder;
    _placeholder=placeholder;
    
    
}

- (void)setText:(NSString *)text{
    [super setText:text];
    self.placeholder = @"";
}

-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        PlaceholderLabel.hidden=YES;
    }
    else{
        PlaceholderLabel.hidden=NO;
    }
    
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [PlaceholderLabel removeFromSuperview];
}

@end
