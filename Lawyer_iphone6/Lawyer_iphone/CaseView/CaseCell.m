//
//  CaseCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-3.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CaseCell.h"

@implementation CaseCell

@synthesize titleLabel = _titleLabel;
@synthesize caseLabel = _caseLabel;
@synthesize chargeLabel = _chargeLabel;
@synthesize dateLabel = _dateLabel;
@synthesize categoryLabel = _categoryLabel;
@synthesize clientLabel = _clientLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
