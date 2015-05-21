//
//  CircleButton.m
//  Lawyer_Iphone
//
//  Created by 邬 明 on 14-4-19.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CircleButton.h"

@interface CircleButton()<NSURLConnectionDataDelegate>{
    NSMutableData *_data;
    UIActivityIndicatorView *_indicatorView;
}

@end

@implementation CircleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
    }
    return self;
}

- (void)setBorderColor:(UIColor*)color{
    self.layer.borderColor = color.CGColor;
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    [super setBackgroundImage:image forState:state];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth = 1.0f;
}

- (void)setDownloadImage:(NSString*)path{
    _data = [[NSMutableData alloc] init];
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];

    [connection start];
    
//    _indicatorView = [[UIActivityIndicatorView alloc] init];
//    _indicatorView.center = self.center;
//    [self addSubview:_indicatorView];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    UIImage *image = [UIImage imageWithData:_data];
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

}

@end
