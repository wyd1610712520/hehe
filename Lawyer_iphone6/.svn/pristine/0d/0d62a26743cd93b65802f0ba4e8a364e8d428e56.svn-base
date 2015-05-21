//
//  ProcessCommentCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 15-1-2.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CircleButton.h"

#import "LineView.h"

@class CommentFileView;

@interface ProcessCommentCell : UITableViewCell

@property (nonatomic, strong) IBOutlet CircleButton *avatorButton;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *contentLabel;

@property (nonatomic, strong) IBOutlet UIImageView *readImageView;

@property (nonatomic, assign) BOOL isAllRight;

@property (nonatomic, assign) CommentFileView *firstView;

// 回复删除
@property (nonatomic, strong) IBOutlet UIButton *deleteBtn;
- (IBAction)touchDeleteBtn:(id)btn
;

@property (nonatomic, strong) IBOutlet UIView *operationView;

- (void)setContent:(NSString*)content files:(NSArray*)files;

+ (CGFloat)heightForRow:(NSString*)content files:(NSArray*)files;

@end


@interface CommentFileView : UIView

@property (nonatomic, strong) IBOutlet  UIImageView *logoImageView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UIButton *operationButton;
@property (nonatomic, strong) IBOutlet DashLineView *dashLineView;
@property (nonatomic, strong) UIView *lineView;

- (void)setOperationHide:(BOOL)hide;

@end