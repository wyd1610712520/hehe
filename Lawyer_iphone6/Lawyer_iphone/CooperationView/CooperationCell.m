//
//  CooperationCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CooperationCell.h"

@implementation CooperationCell

@synthesize delegate = _delegate;

UIImage *_unImage = nil;
UIImage *_doneImage = nil;
UIImage *_passImage = nil;
UIImage *_doImage = nil;

+ (void)initialize{
    _unImage = [UIImage imageNamed:@"cooperation_guo_logo.png"];
    _doneImage = [UIImage imageNamed:@"cooperation_done_logo.png"];
    _passImage = [UIImage imageNamed:@"cooperation_guo_logo.png"];
    _doImage = [UIImage imageNamed:@"cooperation_jin_logo.png"];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setState:(NSString*)state{
    if ([state isEqualToString:@"B"]) {
        //已过期
        _stateImageView.image = _passImage;
    }
    else if ([state isEqualToString:@"A"]) {
        //已合作
        _stateImageView.image = _doneImage;
    }
    else if ([state isEqualToString:@"N"]) {
        //未合作
        _stateImageView.image = _doImage;
    }
}

- (IBAction)touchEditEvent:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(editCooperationCell:tag:)]) {
        [_delegate editCooperationCell:self tag:self.tag];
    }
}

- (IBAction)touchDeleteEvent:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(deleteCooperationCell:tag:)]) {
        [_delegate deleteCooperationCell:self tag:self.tag];
    }
}

- (IBAction)touchShareEvent:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(shareCooperationCell:tag:)]) {
        [_delegate shareCooperationCell:self tag:self.tag];
    }
}

@end
