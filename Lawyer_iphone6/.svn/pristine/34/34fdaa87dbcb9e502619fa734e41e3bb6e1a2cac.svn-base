//
//  CommentCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-9.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

@synthesize delegate = _delegate;

CommentCell *cell;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)isShowButton:(BOOL)show{
    _publicButton.hidden = show;
    _deleteButton.hidden = show;

}

+ (CGFloat)heightForRow:(NSString*)content show:(BOOL)show{
    cell = [self loadCell];

    CGFloat height = 0;
    if (show) {
        height = 50;
    }
    else{
        height = 80;
    }
    
    
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeZero;
    if (Iphone6) {
        size = CGSizeMake(315, 10000);
    }
    else if (Iphone6s){
        size = CGSizeMake(354, 10000);
    }
    else{
        size = CGSizeMake(cell.contentLabel.frame.size.width, 10000);
    }
    
    
    NSDictionary *textAttributes = @{NSFontAttributeName: font};
    
    
    CGRect labelsize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
    return height + labelsize.size.height;
}

- (IBAction)touchPublicEvent:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(publicCommentCell:tag:)]) {
        [_delegate publicCommentCell:self tag:self.tag];
    }
}

- (IBAction)touchDeleteEvent:(id)sender {
    if ([_delegate respondsToSelector:@selector(deleteCommentCell:tag:)]) {
        [_delegate deleteCommentCell:self tag:self.tag];
    }
}

+ (id)loadCell{
    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil];
    return [cells objectAtIndex:0];
}


@end
