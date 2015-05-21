//
//  ClientDocCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ClientDocCell.h"

@implementation ClientDocCell

@synthesize logoImageView;
@synthesize titleLabel;
@synthesize nameLabel;
@synthesize dateLabel;
@synthesize sizeLabel;

- (IBAction)touchZhuanEvent:(id)sender{
    if ([_delegte respondsToSelector:@selector(didTouchZhuanEvent:)]) {
        [_delegte didTouchZhuanEvent:self.tag];
    }
}



@end
