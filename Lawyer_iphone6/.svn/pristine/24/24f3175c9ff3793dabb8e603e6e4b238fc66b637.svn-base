//
//  LineImageView.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-2.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LineImageView.h"

#import "NSString+Utility.h"
@implementation LineImageView

- (id)init{
    self = [super init];
    if (self) {
        [self changeHeight];
        
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self changeHeight];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self changeHeight];
}

- (void)awakeFromNib{
    [super awakeFromNib];
   // [self changeHeight];
}


- (void)changeHeight{
    for (NSLayoutConstraint *constraint in self.constraints) {
        
        if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = (1.0 / [UIScreen mainScreen].scale);
        }
        
    }
    self.backgroundColor = [@"#dddddd" colorValue];
    
}

@end
