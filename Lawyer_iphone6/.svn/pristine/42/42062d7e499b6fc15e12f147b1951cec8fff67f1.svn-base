//
//  ClientContactCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-5.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ClientContactCell.h"

@implementation ClientContactCell

@synthesize clientContactType = _clientContactType;

@synthesize namaLabel = _namaLabel;
@synthesize positionLabel = _positionLabel;
@synthesize phoneHintLabel = _phoneHintLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize telePhoneHintLabel = _telePhoneHintLabel;
@synthesize telePhoneLabel = _telePhoneLabel;
@synthesize emailHintLabel = _emailHintLabel;
@synthesize emailLabel = _emailLabel;
@synthesize commentHintLabel = _commentHintLabel;
@synthesize commentLabel = _commentLabel;

@synthesize delegate = _delegate;

@synthesize faxLabel = _faxLabel;

@synthesize mobileButton = _mobileButton;
@synthesize messageButton = _messageButton;
@synthesize mailButton = _mailButton;

ClientContactCell *cell;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setClientContactType:(ClientContactType)clientContactType{
    _clientContactType = clientContactType;
    if (clientContactType == ClientContactTypeNormal) {
        _phoneHintLabel.text = @"电话";
        _telePhoneHintLabel.text = @"手机";
        _emailHintLabel.text = @"邮箱";
        _commentHintLabel.text = @"备注";
        _mobileButton.hidden = NO;
        _mobileButton.hidden = NO;
        _mobileButton.hidden = NO;
    }
    else if (clientContactType == ClientContactTypeRelate){
        _phoneHintLabel.text = @"关系";
        _telePhoneHintLabel.text = @"联系人";
        _emailHintLabel.text = @"总机";
        _commentHintLabel.text = @"地址";
        _mobileButton.hidden = YES;
        _messageButton.hidden = YES;
        _mailButton.hidden = YES;
        
    }
}

+ (CGFloat)heightForRow:(NSString*)comment{
    cell = [self loadCell];
    CGFloat height = 330;
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CGSize size = CGSizeMake(cell.commentLabel.frame.size.width, 1000);
    
    NSDictionary *textAttributes = @{NSFontAttributeName: font};

    
    CGRect labelsize = [comment boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];

    return height + labelsize.size.height;
}

+ (id)loadCell{
    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ClientContactCell" owner:self options:nil];
    return [cells objectAtIndex:0];
}

- (IBAction)touchMobleEvent:(UIButton*)sender{
    
    if ([_delegate respondsToSelector:@selector(didTouchMobleEvent:)]) {
        if (![_phoneLabel.text isEqualToString:@"无"]) {
            [_delegate didTouchMobleEvent:_phoneLabel.text];
        }
        
    }
}

- (IBAction)touchPhoneEvent:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(didTouchPhoneEvent:)]) {
        if (![_telePhoneLabel.text isEqualToString:@"无"]) {
            [_delegate didTouchPhoneEvent:_telePhoneLabel.text];
        }
        
    }
}

- (IBAction)touchMessageEvent:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(didTouchMessageEvent:)]) {
        if (![_telePhoneLabel.text isEqualToString:@"无"]) {
            [_delegate didTouchMessageEvent:_telePhoneLabel.text];
        }
        
    }
}

- (IBAction)touchEmailEvent:(UIButton*)sender{
    NSLog(@"1");
    if ([_delegate respondsToSelector:@selector(didTouchEmailEvent:)]) {
        if (![_emailLabel.text isEqualToString:@"无"]) {
            [_delegate didTouchEmailEvent:_emailLabel.text];
        }
        
    }
}

@end
