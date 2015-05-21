//
//  ClientContactPersonCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 15-1-2.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ClientContactPersonCell.h"

@implementation ClientContactPersonCell

@synthesize delegate = _delegate;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)touchPhoneEvent:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(didPhoneEvent:)]) {
        if (![_thirdLabel.text isEqualToString:@"无"]) {
            [_delegate didPhoneEvent:_thirdLabel.text];
        }
    }
}

- (IBAction)touchLocationEvent:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(didLocationEvent:)]) {
        if (![_fourthLabel.text isEqualToString:@"无"]) {
            [_delegate didLocationEvent:_fourthLabel.text];
        }
    }
}

- (IBAction)touchEmailEvent:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(didEmailEvent:)]) {
        if (![_sixLabel.text isEqualToString:@"无"]) {
            [_delegate didEmailEvent:_sixLabel.text];
        }
    }
}

@end
