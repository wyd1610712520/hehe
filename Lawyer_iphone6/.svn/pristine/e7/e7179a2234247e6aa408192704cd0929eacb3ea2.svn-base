//
//  AlertView.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-19.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "AlertView.h"

#import "LineView.h"

#import "MBProgressHUD.h"

#define heightY 0.64
#define widthY 0.36

@interface AlertView ()<UITextFieldDelegate,UITextViewDelegate>{
    CABasicAnimation *endSacleAnimation;
    
    LineView *_firstView;
    LineView *_secondView;
    
    CGFloat _oriY;
    
    NSString *_content;
}

@end

@implementation AlertView

@synthesize alertButtonType = _alertButtonType;
@synthesize tipLabel = _tipLabel;
@synthesize titleLabel = _titleLabel;
@synthesize cancelButton = _cancelButton;
@synthesize sureButton = _sureButton;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize textField = _textField;

@synthesize delegate = _delegate;

UIImage *_gBackground = nil;

+ (void)initialize{
    _gBackground = [UIImage imageNamed:@"alertview_background.png"];

}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 13;
        self.layer.masksToBounds = YES;
        
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.frame.size.width, 20)];
        _tipLabel.font = [UIFont systemFontOfSize:18];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.text = @"提示";
        [self addSubview:_tipLabel];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setAlertButtonType:(AlertButtonType)alertButtonType{
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundImageView.image = [_gBackground stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    if (alertButtonType == AlertButtonOne) {
        _firstView = [[LineView alloc] initWithFrame:CGRectMake(0, self.frame.size.height*heightY, self.frame.size.width, 0.5)];
        
        _oriY = _firstView.frame.origin.y;
        
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(0, self.frame.size.height*heightY, self.frame.size.width, self.frame.size.height*widthY);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_sureButton addTarget:self action:@selector(touchSureEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sureButton];
        
    }
    else if (alertButtonType == AlertButtonTwo){
        _firstView = [[LineView alloc] initWithFrame:CGRectMake(0, self.frame.size.height*heightY, self.frame.size.width, 0.5)];
        _oriY = _firstView.frame.origin.y;
        
        _secondView = [[LineView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, self.frame.size.height*heightY, 0.5, self.frame.size.height*widthY)];
        [self addSubview:_secondView];
        _secondView.backgroundColor = [UIColor whiteColor];
        
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(self.frame.size.width/2, self.frame.size.height*heightY, self.frame.size.width/2, self.frame.size.height*widthY);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_sureButton addTarget:self action:@selector(touchSureEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sureButton];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, self.frame.size.height*heightY, self.frame.size.width/2, self.frame.size.height*widthY);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(touchCancelEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
    }
    
    [self insertSubview:_backgroundImageView atIndex:0];
    
    [self addSubview:_firstView];
    
    _firstView.backgroundColor = [UIColor whiteColor];
    
}

- (void)showSimpleTitle:(NSString*)title{
    _titleLabel.frame = CGRectMake(0, _tipLabel.frame.size.height+_tipLabel.frame.origin.y+10, self.frame.size.width, 20);
    _titleLabel.text = title;
    [self addSubview:_titleLabel];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(0, self.frame.size.height*0.65, self.frame.size.width, self.frame.size.height*0.35);
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(touchCancelEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];

}

- (void)didAddSubview:(UIView *)subview{
    [super didAddSubview:subview];
    CABasicAnimation *sacleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    sacleAnimation.duration = 0.2;
    sacleAnimation.removedOnCompletion = NO;
    sacleAnimation.fillMode = kCAFillModeForwards;
    sacleAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    sacleAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.layer addAnimation:sacleAnimation forKey:nil];
}

- (void)showField:(NSString*)title{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, _tipLabel.frame.size.height+_tipLabel.frame.origin.y+5, self.frame.size.width-20, 40)];
    _textField.textColor = [UIColor whiteColor];
    _textField.font = [UIFont systemFontOfSize:18];
    _textField.text = title;
    [self addSubview:_textField];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    [_textField becomeFirstResponder];
    
}

- (void)showTextView:(NSString*)content{
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, _tipLabel.frame.size.height+_tipLabel.frame.origin.y+5, self.frame.size.width-20, 40)];
    _textView.textColor = [UIColor whiteColor];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = [UIFont systemFontOfSize:18];
    [self addSubview:_textView];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    _textView.scrollsToTop = NO;
    [_textView becomeFirstResponder];
}



- (void)textViewDidChange:(UITextView *)textView{
    NSString *content = textView.text;
    UIFont *font = [UIFont systemFontOfSize:18];
    CGSize size = CGSizeMake(self.frame.size.width-20, 1000);
    
    NSDictionary *textAttributes = @{NSFontAttributeName: font};
    
    
    CGRect labelsize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
    
    
    CGRect frame = _textView.frame;
    frame.size.height = labelsize.size.height+10;
    if (frame.size.height < 40) {
        frame.size.height = 40;
    }
    if ((frame.size.height+frame.origin.y) > _firstView.frame.origin.y) {
        frame.size.height = _firstView.frame.origin.y - frame.origin.y;
    }
    _textView.frame = frame;
    
    
    
    CGRect frame1 = self.frame;
    frame1.size.height = 155+ labelsize.size.height;
    if (frame1.size.height < 255) {
        
        
        _backgroundImageView.frame = self.bounds;
        
        
        CGRect frame2 = _firstView.frame;
        frame2.origin.y = _oriY+labelsize.size.height;
        _firstView.frame = frame2;
        
        CGRect frame3 = _secondView.frame;
        frame3.origin.y = _oriY+labelsize.size.height;
        _secondView.frame = frame3;
        
        CGRect frame4 = _sureButton.frame;
        frame4.origin.y = _oriY+labelsize.size.height;
        _sureButton.frame = frame4;
        CGRect frame5 = _cancelButton.frame;
        frame5.origin.y = _oriY+labelsize.size.height;
        _cancelButton.frame = frame5;
        
        
        self.frame = frame1;
    }
    
    NSInteger max = 100;
    
    if (textView.text.length >= max)
    {
        textView.text = [textView.text substringToIndex:max];
    }
    

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    NSInteger max = 100;
    
    
    
    if (textView.text.length >= max)
    {
        textView.text = [textView.text substringToIndex:max];
    }

    return YES;
    
}



- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
}

- (void)touchCancelEvent{
    endSacleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    endSacleAnimation.duration = 0.2;
    endSacleAnimation.removedOnCompletion = NO;
    endSacleAnimation.fillMode = kCAFillModeForwards;
    endSacleAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    endSacleAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    endSacleAnimation.delegate = self;
    [self.layer addAnimation:endSacleAnimation forKey:nil];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchSureEvent{
    if ([_delegate respondsToSelector:@selector(alertView:field:)]) {
        
        if (_textView){
            [_delegate alertView:self field:_textView.text];
        }
        else{
//            if (![_textField hasText] && ![_sureButton.titleLabel.text isEqualToString:@"删除"]) {
//            }
            if (_textField && ![_textField hasText]) {
                [self showHUDWithTextOnly:@"请输入名称"];
                return;

            }

            [_delegate alertView:self field:_textField.text];
        }
        
        [self removeFromSuperview];
    }
    
    
}

- (void)showHUDWithTextOnly:(NSString*)title{
    MBProgressHUD* _progressHUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    
    _progressHUD.mode = MBProgressHUDModeText;
    _progressHUD.labelText = title;
    _progressHUD.margin = 10.f;
    _progressHUD.removeFromSuperViewOnHide = YES;
    
    [_progressHUD hide:YES afterDelay:1.4];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    flag = YES;
    [self removeFromSuperview];
}

@end
