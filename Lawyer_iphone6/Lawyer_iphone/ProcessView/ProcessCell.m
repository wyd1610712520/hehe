//
//  ProcessCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProcessCell.h"

@implementation ProcessCell

@synthesize avatorImageView;
@synthesize nameLabel;
@synthesize titleLabel;
@synthesize commentLabel;
@synthesize companyLabel;
@synthesize dateLabel;
@synthesize flagLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
