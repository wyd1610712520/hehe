//
//  LogCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-5.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LogCell.h"

@implementation LogCell


LogCell *cell;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForRow:(NSString*)content{
    cell = [self loadCell];
    cell.contentLabel.text = content;
    cell.contentLabel.numberOfLines = 2;
    [cell.contentLabel sizeToFit];
    return 80+cell.contentLabel.frame.size.height;
}

+ (id)loadCell{
    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"LogCell" owner:self options:nil];
    return [cells objectAtIndex:0];
}


@end
