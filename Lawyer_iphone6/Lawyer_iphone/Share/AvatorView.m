//
//  AvatorView.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-15.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "AvatorView.h"

#import "UIButton+AFNetworking.h"

@interface AvatorView (){
    
    NSArray *_record;
}

@end

@implementation AvatorView



@synthesize managerLogo = _managerLogo;

- (void)setAvators:(NSArray*)datas{
    _record = datas;
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    
    _managerLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"case_manager_logo.png"]];
    
    
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]] || [subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    
    CGFloat width = 40;
    CGFloat height = self.frame.size.height;
    
    
    CGFloat x = 0;
    
    for (int i = 0; i < datas.count; i++) {
        CircleButton *avatorButton = [CircleButton buttonWithType:UIButtonTypeCustom];
        NSDictionary *dic = (NSDictionary*)[datas objectAtIndex:i];
        
        if ([dic objectForKey:@"ca_lawyer_photo"]) {
            NSString *path = [dic objectForKey:@"ca_lawyer_photo"];
            [avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:path]];
        }
        else if ([dic objectForKey:@"rda_care_photo"]) {
            NSString *path = [dic objectForKey:@"rda_care_photo"];
            [avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:path]];
        }
        else if ([dic objectForKey:@"gc_photo"]) {
            NSString *path = [dic objectForKey:@"gc_photo"];
            [avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:path]];
        }
        else if ([dic objectForKey:@"ywcp_group_photo"]){
            NSString *path = [dic objectForKey:@"ywcp_group_photo"];
            [avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:path]];

        }
        
        [avatorButton addTarget:self action:@selector(touchProfileEvent:) forControlEvents:UIControlEventTouchUpInside];
        avatorButton.tag = i;
        avatorButton.layer.borderColor = [UIColor clearColor].CGColor;
        [self addSubview:avatorButton];
        
        avatorButton.frame = CGRectMake(i*width+i*35+2, 0, width, width);
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatorButton.frame.origin.x-10, height-16, width+20, 19)];
        nameLabel.textColor = _textColor;
        
        if ([dic objectForKey:@"ca_lawyer_name"]) {
            
            if ([[dic objectForKey:@"ca_lawyer_name"] isEqualToString:_nameId]) {
                _managerLogo.frame = CGRectMake((i+1)*width+i*35+2-10, avatorButton.frame.size.height-13, 17, 17);
                [self addSubview:_managerLogo];
            }
            
            
            nameLabel.text = [dic objectForKey:@"ca_lawyer_name"];
        }
        else if ([dic objectForKey:@"rda_care_name"]) {
            nameLabel.text = [dic objectForKey:@"rda_care_name"];
        }
        else if ([dic objectForKey:@"gc_name"]) {
            nameLabel.text = [dic objectForKey:@"gc_name"];
        }
        else if ([dic objectForKey:@"ywcp_group_name"]) {
            nameLabel.text = [dic objectForKey:@"ywcp_group_name"];
        }
        
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        
        
        [self addSubview:nameLabel];
       
        
        x = avatorButton.frame.size.width + width;
    }
    [self setContentSize:CGSizeMake(datas.count*width+datas.count*35, self.frame.size.height)];
    self.showsHorizontalScrollIndicator = NO;
}

- (void)touchProfileEvent:(UIButton*)sender{
    NSDictionary *dic = (NSDictionary*)[_record objectAtIndex:sender.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moProfile" object:dic];
}

@end
