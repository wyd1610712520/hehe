//
//  CooperationDetailViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-9.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "AvatorView.h"

#import "CircleButton.h"
#import "CustomTextView.h"
#import "LineView.h"
#import "CustomLabel.h"

@interface CooperationDetailViewController : CustomNavigationViewController


@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *followerLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet CustomLabel *industryLabel;
@property (strong, nonatomic) IBOutlet UILabel *areaLabel;
@property (strong, nonatomic) IBOutlet UILabel *deadlineLabel;

@property (strong, nonatomic) IBOutlet UILabel *describeLabel;

@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *businessLabel;

@property (strong, nonatomic) IBOutlet UILabel *publicLabel;
@property (strong, nonatomic) IBOutlet UILabel *parterLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (strong, nonatomic) IBOutlet CircleButton *avatorButton;

@property (strong, nonatomic) IBOutlet UILabel *attachLabel;

@property (strong, nonatomic) NSString *cooperationId;
@property (strong, nonatomic) IBOutlet UIView *attachView;
@property (strong, nonatomic) IBOutlet UIImageView *timeImageView;

@property (strong, nonatomic) IBOutlet UIButton *topButton;
@property (strong, nonatomic) IBOutlet UIButton *guanzhuButton;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;

@property (strong, nonatomic) IBOutlet UILabel *fujianLabel;
@property (strong, nonatomic) IBOutlet UILabel *careLabel;
@property (strong, nonatomic) IBOutlet LineView *lineView;

@property (nonatomic, strong) IBOutlet AvatorView *avatorView;

- (IBAction)touchPartnerEvent:(id)sender;

- (IBAction)touchCommentEvent:(UIButton *)sender;
- (IBAction)touchTopEvent:(UIButton *)sender;
- (IBAction)touchFollowerEvent:(UIButton *)sender;
- (IBAction)touchCollection:(UIButton *)sender;
- (IBAction)touchShareEvent:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentBottom;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *careY;


@property (strong, nonatomic) IBOutlet UIView *commentView;

@property (strong, nonatomic) IBOutlet CustomTextView *textView;
@property (strong, nonatomic) IBOutlet UISwitch *switchButton;

- (IBAction)touchCloseButton:(id)sender;
- (IBAction)touchSureEvent:(id)sender;
- (IBAction)touchSwitchEvent:(UISwitch*)sender;

@end
