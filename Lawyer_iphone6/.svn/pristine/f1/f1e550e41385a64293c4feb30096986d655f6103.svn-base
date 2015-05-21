//
//  ClientContactCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-5.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClientContactViewController.h"

#import "CustomLabel.h"

@class ClientContactCell;

@protocol ClientContactCellDelegate <NSObject>

- (void)didTouchMobleEvent:(NSString*)tag;
- (void)didTouchPhoneEvent:(NSString*)tag;
- (void)didTouchMessageEvent:(NSString*)tag;
- (void)didTouchEmailEvent:(NSString*)tag;

@end


@interface ClientContactCell : UITableViewCell

@property (nonatomic, strong) NSObject<ClientContactCellDelegate> *delegate;

@property (nonatomic, assign) ClientContactType clientContactType;

@property (nonatomic, strong) IBOutlet UILabel *namaLabel;
@property (nonatomic, strong) IBOutlet UILabel *positionLabel;

@property (nonatomic, strong) IBOutlet UILabel *phoneHintLabel;
@property (nonatomic, strong) IBOutlet CustomLabel *phoneLabel;

@property (nonatomic, strong) IBOutlet UILabel *telePhoneHintLabel;
@property (nonatomic, strong) IBOutlet CustomLabel *telePhoneLabel;

@property (nonatomic, strong) IBOutlet UILabel *emailHintLabel;
@property (nonatomic, strong) IBOutlet CustomLabel *emailLabel;

@property (nonatomic, strong) IBOutlet CustomLabel *faxLabel;

@property (nonatomic, strong) IBOutlet UILabel *dutyLabel;

@property (nonatomic, strong) IBOutlet UILabel *commentHintLabel;
@property (nonatomic, strong) IBOutlet CustomLabel *commentLabel;

@property (nonatomic, strong) IBOutlet UIButton *mobileButton;
@property (nonatomic, strong) IBOutlet UIButton *messageButton;
@property (nonatomic, strong) IBOutlet UIButton *mailButton;


+ (CGFloat)heightForRow:(NSString*)comment;

- (IBAction)touchMobleEvent:(UIButton*)sender;
- (IBAction)touchPhoneEvent:(UIButton*)sender;
- (IBAction)touchMessageEvent:(UIButton*)sender;
- (IBAction)touchEmailEvent:(UIButton*)sender;

@end
