//
//  FileView.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-1.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FileView;
#import "LineView.h"

@protocol FileViewDelegate <NSObject>

- (void)fileView:(FileView*)fileView tag:(NSInteger)tag;

@end

@interface FileView : UIView

@property (nonatomic, strong) NSObject<FileViewDelegate> *delegate;

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, strong) LineView *lineView;

@property (nonatomic, strong) UIButton *button;


@end
