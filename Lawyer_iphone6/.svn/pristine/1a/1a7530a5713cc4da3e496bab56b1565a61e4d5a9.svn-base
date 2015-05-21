//
//  ModuleCell.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-23.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ModuleCell.h"

@implementation ModuleCell

ModuleCell *cell;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForRow:(NSString*)content{
    cell = [self loadCell];
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 1000);
    
    NSDictionary *textAttributes = @{NSFontAttributeName: font};
    
    
    CGRect labelsize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
    
    if (labelsize.size.height > 45) {
        return 81;
    }
    
    return 64;
}

+ (id)loadCell{
    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ModuleCell" owner:self options:nil];
    return [cells objectAtIndex:0];
}

@end
