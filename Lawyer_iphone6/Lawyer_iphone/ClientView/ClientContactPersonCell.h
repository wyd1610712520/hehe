//
//  ClientContactPersonCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 15-1-2.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomLabel.h"

@class ClientContactPersonCell;

@protocol ClientContactPersonCellDelegate <NSObject>

@optional

- (void)didPhoneEvent:(NSString*)tag;
- (void)didLocationEvent:(NSString*)tag;
- (void)didEmailEvent:(NSString*)tag;;

@end

@interface ClientContactPersonCell : UITableViewCell

@property (nonatomic, strong) NSObject<ClientContactPersonCellDelegate> *delegate;


@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *dutyLabel;
@property (nonatomic, strong) IBOutlet CustomLabel *fristLabel;
@property (nonatomic, strong) IBOutlet CustomLabel *secondLabel;
@property (nonatomic, strong) IBOutlet CustomLabel *thirdLabel;
@property (nonatomic, strong) IBOutlet CustomLabel *fourthLabel;
@property (nonatomic, strong) IBOutlet CustomLabel *fifthLabel;
@property (nonatomic, strong) IBOutlet CustomLabel *sixLabel;

- (IBAction)touchPhoneEvent:(UIButton*)sender;
- (IBAction)touchLocationEvent:(UIButton*)sender;
- (IBAction)touchEmailEvent:(UIButton*)sender;


@end
