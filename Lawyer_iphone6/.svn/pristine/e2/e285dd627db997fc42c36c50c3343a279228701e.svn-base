//
//  LineView.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-21.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "LineView.h"

#import "NSString+Utility.h"

@implementation LineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init{
    self = [super init];
    if (self) {
        for (NSLayoutConstraint *constraint in self.constraints) {
            
            if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = (1.0 / [UIScreen mainScreen].scale);
            }
            
        }
        self.backgroundColor = [@"#dddddd" colorValue];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        for (NSLayoutConstraint *constraint in self.constraints) {
            
            if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = (1.0 / [UIScreen mainScreen].scale);
            }
            
        }
        self.backgroundColor = [@"#dddddd" colorValue];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    

}

- (void)awakeFromNib{
    for (NSLayoutConstraint *constraint in self.constraints) {
        
        if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = (1.0 / [UIScreen mainScreen].scale);
        }
        
    }
    self.backgroundColor = [@"#dddddd" colorValue];
}




@end



@implementation DashLineView


- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    CGFloat lengths[] = {4,2};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, self.frame.size.width, 0.0);
    CGContextStrokePath(context);
}

@end
