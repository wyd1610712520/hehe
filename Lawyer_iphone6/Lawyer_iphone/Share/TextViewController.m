//
//  TextViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-30.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController (){
    UITextView *_textView;
}

@end

@implementation TextViewController

@synthesize content = _content;

@synthesize delegate = _delegate;
@synthesize textType = _textType;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    

    
}


- (void)touchSureEvnet{
    if ([_delegate respondsToSelector:@selector(textViewController:text:)]) {
        if ([_textView hasText]) {
            [_delegate textViewController:self text:_textView.text];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            [self showHUDWithTextOnly:@"请输入文字"];
        }
        
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    
    

    
    
    
    _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    _textView.font = [UIFont systemFontOfSize:17];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.textColor = [UIColor blackColor];
    [self.view addSubview:_textView];
   
    _textView.layer.borderWidth = 0.5f;
    _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    if (_textType == TextTypeNormal) {
        [_textView becomeFirstResponder];
        [self setTitle:@"创建文本" color:nil];
        [self setRightButton:nil title:@"确定" target:self action:@selector(touchSureEvnet)];
    }
    else if (_textType == TextTypeRead){
        [self setTitle:@"浏览" color:nil];
        _textView.text = _content;
        _textView.editable = NO;
        
    }

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_textView resignFirstResponder];
    
    if ([_delegate respondsToSelector:@selector(dissView)]) {
        [_delegate dissView];
    }
}

@end
