//
//  ProcessDetailCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-10.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProcessDetailCell.h"

#import "NSString+Utility.h"

@implementation ProcessDetailCell

@synthesize delegate = _delegate;

UIImage *_planImage;
UIImage *_doneImage;
UIImage *_doingImage;
UIImage *_undoneImage;

ProcessDetailCell *cell;

+ (void)initialize{
    _planImage = [UIImage imageNamed:@"process_plan_logo.png"];
    _doneImage = [UIImage imageNamed:@"process_done_logo.png"];
    _doingImage = [UIImage imageNamed:@"process_doing_logo.png"];
    _undoneImage = [UIImage imageNamed:@"process_undone_logo.png"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStateFlag:(NSString*)flag{
    if ([flag isEqualToString:@"未设置"]) {
        _stateImageView.image = _undoneImage;
        _tittleLabel.textColor = [@"#E88D0A" colorValue];
    }
    else if ([flag isEqualToString:@"正在进行"]) {
        _stateImageView.image = _doingImage;
        _tittleLabel.textColor = [@"#72BE4F" colorValue];
    }
    else if ([flag isEqualToString:@"计划中"]) {
        _stateImageView.image = _planImage;
        _tittleLabel.textColor = [@"#00ADEE" colorValue];
    }
    else if ([flag isEqualToString:@"已完成"]) {
        _stateImageView.image = _doneImage;
        _tittleLabel.textColor = [@"#ED3B75" colorValue];
    }
    
}

+ (CGFloat)heightForHeight:(NSString*)content{
    cell = [self loadCell];
    CGFloat height = 170;
    UIFont *font = [UIFont systemFontOfSize:17.0f];
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, 1000);
    
    NSDictionary *textAttributes = @{NSFontAttributeName: font};
    
    
    CGRect labelsize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
    if (labelsize.size.height > 39) {
        return height +40;
    }
    return height + 20;
}

+ (id)loadCell{
    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ProcessDetailCell" owner:self options:nil];
    return [cells objectAtIndex:0];
}

- (IBAction)touchCommentEvent:(id)sender{
    if ([_delegate respondsToSelector:@selector(processDetailCell:didTouchComment:)]) {
        [_delegate processDetailCell:self didTouchComment:self.tag];
    }
}

- (IBAction)touchDeleteEvent:(id)sender{
    if ([_delegate respondsToSelector:@selector(processDetailCell:didTouchDelegate:)]) {
        [_delegate processDetailCell:self didTouchDelegate:self.tag];
    }
}

- (IBAction)touchMoveEvent:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(processDetailCell:didTouchMove:)]) {
        [_delegate processDetailCell:self didTouchMove:sender];
    }
}

- (IBAction)touchCancelEvent:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(processDetailCell:didTouchCancel:)]) {
        [_delegate processDetailCell:self didTouchCancel:sender];
    }
}


- (IBAction)touchDownEvent:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(processDetailCell:didTouchDown:)]) {
        [_delegate processDetailCell:self didTouchDown:sender];
    }
}

@end
