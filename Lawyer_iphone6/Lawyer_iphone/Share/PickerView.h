//
//  PickerView.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-16.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerView;

@protocol PickerViewDelegate <NSObject>

- (void)pickerView:(PickerView*)pickerView returnObject:(id)returnObject;

@end

@interface PickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) NSObject<PickerViewDelegate> *delegate;

@property (nonatomic, strong) UIPickerView *pickerView;

- (void)setData:(NSArray*)array;

@end
