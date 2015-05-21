//
//  ClientVisiteCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ClientVisiteCell.h"

@implementation ClientVisiteCell

@synthesize titleLabel = _titleLabel;
@synthesize nameLabel = _nameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize typeLabel = _typeLabel;
@synthesize contentLabel = _contentLabel;

ClientVisiteCell *cell;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForRow:(NSString*)content{
    cell = [self loadCell];
    CGFloat height = 80;
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    CGSize size = CGSizeMake(cell.frame.size.width, 1000);
    NSDictionary *textAttributes = @{NSFontAttributeName: font};
    
    
    CGRect labelsize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
    
    if (labelsize.size.height > 18) {
            return height + labelsize.size.height+10;
    }
    return height + labelsize.size.height-5;

}

+ (id)loadCell{
    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ClientVisiteCell" owner:self options:nil];
    return [cells objectAtIndex:0];
}

@end
