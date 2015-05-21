//
//  UploadButton.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-2-7.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "UploadButton.h"

#import "NSString+Utility.h"

#define PI 3.14159265358979323846

@interface UploadButton (){
    CGFloat _progress;
    
    BOOL isChange;
}

@end

@implementation UploadButton


- (void)drawRect:(CGRect)rect{
    if (isChange) {
        [self setTitle:[NSString stringWithFormat:@"%d%@",(int)_progress,@"%"] forState:UIControlStateNormal];
        


        [self setTitleColor:[@"#F95C1E" colorValue] forState:UIControlStateNormal];
        self.layer.masksToBounds = YES;
       // self.layer.cornerRadius = self.frame.size.width/2;
       // self.layer.borderColor = [@"#F95C1E" colorValue].CGColor;
      //  self.layer.borderWidth = 2;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBStrokeColor(context, 249.0/255.0, 92.0/255.0, 30.0/255.0, 1);
        CGContextSetLineWidth(context, 2.0);
        CGContextAddArc(context, self.frame.size.width/2, self.frame.size.width/2, self.frame.size.width/2-2, -45, (2*PI*_progress)/100, 0);
        CGContextDrawPath(context, kCGPathStroke);

    }
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    isChange = YES;
    
    
   
    [self setNeedsLayout];
    [self setNeedsDisplay];
    
}

@end

