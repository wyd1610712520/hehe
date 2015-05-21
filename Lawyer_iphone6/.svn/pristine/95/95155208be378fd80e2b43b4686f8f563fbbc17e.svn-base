//
//  CommentCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-9.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleButton.h"

@class CommentCell;

@protocol CommentCellDelegate  <NSObject>

- (void)deleteCommentCell:(CommentCell*)commentCell tag:(NSInteger)tag;
- (void)publicCommentCell:(CommentCell*)commentCell tag:(NSInteger)tag;


@end

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) NSObject<CommentCellDelegate> *delegate;

@property (strong, nonatomic) IBOutlet CircleButton *avatorButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIButton *publicButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

- (IBAction)touchPublicEvent:(UIButton *)sender;
- (IBAction)touchDeleteEvent:(id)sender;

+ (CGFloat)heightForRow:(NSString*)content show:(BOOL)show;
- (void)isShowButton:(BOOL)show;

@end
