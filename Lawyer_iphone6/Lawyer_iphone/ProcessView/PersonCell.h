//
//  PersonCell.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-23.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CircleButton.h"

@interface PersonCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dutyLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *departLabel;
@property (strong, nonatomic) IBOutlet CircleButton *avatorButton;

@end
