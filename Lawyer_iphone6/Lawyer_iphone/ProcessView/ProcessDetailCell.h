//
//  ProcessDetailCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-10.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProcessDetailCell;

@protocol ProcessDetailCellDelegate  <NSObject>

@optional

- (void)processDetailCell:(ProcessDetailCell*)processDetailCell didTouchComment:(NSInteger)tag;
- (void)processDetailCell:(ProcessDetailCell*)processDetailCell didTouchDelegate:(NSInteger)tag;
- (void)processDetailCell:(ProcessDetailCell*)processDetailCell didTouchMove:(UIButton*)sender;
- (void)processDetailCell:(ProcessDetailCell*)processDetailCell didTouchCancel:(UIButton*)sender;
- (void)processDetailCell:(ProcessDetailCell*)processDetailCell didTouchDown:(UIButton*)sender;

@end

@interface ProcessDetailCell : UITableViewCell

@property (nonatomic, strong) NSObject<ProcessDetailCellDelegate> *delegate;

@property (nonatomic, strong) IBOutlet UILabel *tittleLabel;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *contentLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) IBOutlet UIImageView *readImageVIew;

@property (nonatomic, strong) IBOutlet UILabel *managerLabel;
@property (nonatomic, strong) IBOutlet UILabel *commentLabel;

@property (nonatomic, strong) IBOutlet UIButton *commentButton;
@property (nonatomic, strong) IBOutlet UIButton *deleteButton;
@property (nonatomic, strong) IBOutlet UIButton *moveButton;

@property (nonatomic, strong) IBOutlet UIView *processView;
@property (nonatomic, strong) IBOutlet UIImageView *processImageView;
@property (nonatomic, strong) IBOutlet UILabel *processLabel;

@property (nonatomic, strong) IBOutlet UIImageView *stateImageView;

- (void)setStateFlag:(NSString*)flag;

- (IBAction)touchCommentEvent:(id)sender;
- (IBAction)touchDeleteEvent:(id)sender;

- (IBAction)touchCancelEvent:(UIButton*)sender;
- (IBAction)touchMoveEvent:(UIButton*)sender;
- (IBAction)touchDownEvent:(UIButton*)sender;

+ (CGFloat)heightForHeight:(NSString*)content;

@end
