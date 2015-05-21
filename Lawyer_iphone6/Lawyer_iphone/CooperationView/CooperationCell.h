//
//  CooperationCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CooperationCell;

@protocol CooperationCellDelegate   <NSObject>

- (void)editCooperationCell:(CooperationCell*)cooperationCell tag:(NSInteger)tag;
- (void)deleteCooperationCell:(CooperationCell*)cooperationCell tag:(NSInteger)tag;
- (void)shareCooperationCell:(CooperationCell*)cooperationCell tag:(NSInteger)tag;

@end

@interface CooperationCell : UITableViewCell

@property (nonatomic, strong) NSObject<CooperationCellDelegate> *delegate;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *typeLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel *followerLabel;
@property (nonatomic, strong) IBOutlet UILabel *topLabel;
@property (nonatomic, strong) IBOutlet UIImageView *stateImageView;
@property (strong, nonatomic) IBOutlet UIView *buttonView;

- (void)setState:(NSString*)state;
- (IBAction)touchEditEvent:(UIButton *)sender;
- (IBAction)touchDeleteEvent:(UIButton *)sender;
- (IBAction)touchShareEvent:(UIButton *)sender;


@end
