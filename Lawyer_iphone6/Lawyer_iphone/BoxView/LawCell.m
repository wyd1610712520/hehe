//
//  LawCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-26.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LawCell.h"

@implementation LawCell

@synthesize titleLabel = _titleLabel;
@synthesize logoImageView = _logoImageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
