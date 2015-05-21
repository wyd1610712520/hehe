//
//  ModulePreviewCell.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-2-4.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ModulePreviewCell.h"

@implementation ModulePreviewCell

ModulePreviewCell *cell;

- (void)awakeFromNib {
    // Initialization code
}


+ (CGFloat)heightForRow:(NSString*)content{
    cell = [self loadCell];
    CGFloat height = 50;
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width-40, 1000);
    
    NSDictionary *textAttributes = @{NSFontAttributeName: font};
    
    
    CGRect labelsize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
    
    return height + labelsize.size.height;
}

+ (id)loadCell{
    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ModulePreviewCell" owner:self options:nil];
    return [cells objectAtIndex:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
