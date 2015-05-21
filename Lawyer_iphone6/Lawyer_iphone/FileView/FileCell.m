//
//  FileCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "FileCell.h"

@implementation FileCell

@synthesize secondView;
@synthesize titleLabel;
@synthesize firstLabel;
@synthesize secondLabel;
@synthesize thirdLabel;
@synthesize foruthLabel;
@synthesize logoImageView;

@synthesize delegate = _delegate;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)touchBoxEvent:(UIButton *)sender {
    if (sender.selected) {
        if ([_delegate respondsToSelector:@selector(removeFileCell:tag:)]) {
            [_delegate removeFileCell:self tag:self.tag];
        }
        sender.selected = NO;
    }
    else{
        if ([_delegate respondsToSelector:@selector(addFileCell:tag:)]) {
            [_delegate addFileCell:self tag:self.tag];
        }
        sender.selected = YES;
    }
}
@end
