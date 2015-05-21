//
//  CustomTextField.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomTextField.h"

#import "NSString+Utility.h"

@interface CustomTextField (){
    BOOL isHome;
}

@end

@implementation CustomTextField

@synthesize leftMargin = _leftMargin;

- (void)drawPlaceholderInRect:(CGRect)rect {
    if (isHome) {
        self.placeholderTextColor = [UIColor whiteColor];
    
    }
    else{
        self.placeholderTextColor = [@"#A6A8AB" colorValue];
    }
    
    
    self.placeholderFont = self.font;
    if (self.placeholderTextColor != nil || self.placeholderFont != nil) {

    NSDictionary *textAttributes = @{NSFontAttributeName: self.placeholderFont,
                                     NSForegroundColorAttributeName: self.placeholderTextColor};
    
        
    CGFloat y = (rect.size.height - self.placeholderFont.lineHeight)/2;
    CGFloat x = 0;
    
    [self.placeholder drawAtPoint:CGPointMake(x, y) withAttributes:textAttributes];
        
        
        
    } else {
        [super drawPlaceholderInRect:rect];
    }
}

- (void)awakeFromNib{
    _leftMargin = 5;
}

- (void)setStyleInHome{
    isHome = YES;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    
    iconRect.origin.x += _leftMargin;
    return iconRect;
    
    return [super leftViewRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if (isHome) {
        CGRect iconRect = [super editingRectForBounds:bounds];
        
        iconRect.origin.x = 35;
        return iconRect;
    }
    if (self.leftIndsets.left > 0) {
        self.textInsets = self.leftIndsets;
    }
    else{
        self.textInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    if (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, self.textInsets)) {
        return [super editingRectForBounds:bounds];
    }
    return UIEdgeInsetsInsetRect(bounds, self.textInsets);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    if (isHome) {
        CGRect iconRect = [super textRectForBounds:bounds];
        
        iconRect.origin.x = 35;
        return iconRect;
    }
    if (self.leftIndsets.left > 0) {
        self.textInsets = self.leftIndsets;
    }
    else{
        self.textInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    if (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, self.textInsets)) {
        return [super textRectForBounds:bounds];
    }
    return UIEdgeInsetsInsetRect(bounds, self.textInsets);
}


@end
