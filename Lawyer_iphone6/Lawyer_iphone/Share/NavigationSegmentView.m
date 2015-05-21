//
//  NavigationSegmentView.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-31.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "NavigationSegmentView.h"

@interface NavigationSegmentView (){
    NSArray *_images;
}

@end

@implementation NavigationSegmentView

@synthesize firstButton = _firstButton;

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
     }
    return self;
}

- (void)setImages:(NSArray*)images target:(id)target action:(SEL)action{
    _images = images;
    float leftMargin = 0;
    float width = 50;
    float height = self.frame.size.height;
    
 
    for (int i = 0; i < _images.count; i++) {
        NSDictionary *dic = (NSDictionary*)[_images objectAtIndex:i];
        UIImage *normalImage = (UIImage*)[dic objectForKey:@"image"];
        UIImage *selectedImage = (UIImage*)[dic objectForKey:@"selectedImage"];
        NavigationButton *button = [NavigationButton buttonWithType:UIButtonTypeCustom];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        if (_images.count == 1) {
            button.frame = CGRectMake(width+leftMargin, 0, width, height);
        }
        else{
            button.frame = CGRectMake(i*width+leftMargin, 0, width, height);
        }
        
        if (i == 0) {
            _firstButton = button;
        }
        
        
        
        [button setImage:normalImage forState:UIControlStateNormal];
        button.tag = i;
        if (selectedImage) {
            [button setImage:selectedImage forState:UIControlStateSelected];
        }
        
        [self addSubview:button];
    }
    
}





- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (point.x >= 0) {
        return YES;
    }
    else{
        return [super pointInside:point withEvent:event];
    }
}

@end

@implementation NavigationButton





@end