//
//  PickerView.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-16.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "PickerView.h"

@interface PickerView (){
    NSArray *_datas;
    
    UIButton *cancelButton;
    UIButton *sureButton;
    
    id _returnObject;
}

@end

@implementation PickerView

@synthesize delegate = _delegate;
@synthesize pickerView = _pickerView;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(touchCancelEvent) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.frame = CGRectMake(0, 0, frame.size.width * 0.4, 35);
        [self addSubview:cancelButton];
        
        sureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(touchSureEvent) forControlEvents:UIControlEventTouchUpInside];
        sureButton.frame = CGRectMake(frame.size.width * 0.6, 0, frame.size.width * 0.4, 35);
        [self addSubview:sureButton];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width,frame.size.height-30)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
        [self addSubview:_pickerView];
        
    }
    return self;
}

- (void)touchCancelEvent{
    [self removeFromSuperview];
}

- (void)touchSureEvent{
    if (!_returnObject && _datas.count > 0) {
        _returnObject = (id)[_datas objectAtIndex:0];
    }
    if ([_delegate respondsToSelector:@selector(pickerView:returnObject:)]) {
        [self removeFromSuperview];
        [_delegate pickerView:self returnObject:_returnObject];
    }
}

- (void)setData:(NSArray*)array{
    _datas = array;
    _returnObject = nil;
    [_pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _datas.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  [[_datas objectAtIndex:row] objectForKey:@"gc_name"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _returnObject = (id)[_datas objectAtIndex:row];
}

@end
