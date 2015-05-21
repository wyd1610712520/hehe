//
//  LawRuleCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-26.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LawRuleCell.h"

@implementation LawRuleCell

@synthesize titleLabel;
@synthesize companyLabel;
@synthesize timeLabel;
@synthesize logoImageView;

LawRuleCell *cell;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (CGFloat)heightForRow:(NSString*)titlte{
    cell = [self loadCell];
    CGFloat height = 40;
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CGSize size = CGSizeMake(cell.frame.size.width, 1000);
    NSDictionary *textAttributes = @{NSFontAttributeName: font};
    CGRect labelsize = [titlte boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
    return height + labelsize.size.height;
}

+ (id)loadCell{
    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"LawRuleCell" owner:self options:nil];
    return [cells objectAtIndex:0];
}

@end
