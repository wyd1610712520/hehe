//
//  SearchField.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-9-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchField;

@protocol SearchFieldDelegate <NSObject>

- (void)searchStart:(NSString*)key;

@end

@interface SearchField : UIView<UITextFieldDelegate>

@property (nonatomic, strong) NSObject<SearchFieldDelegate> *delegate;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *tintLabel;
@property (nonatomic, strong) UIImageView *searchImageView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *deleteButton;

- (void)setTitle:(NSString*)title;

@end
