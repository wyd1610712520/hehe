//
//  NewsCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIImageView *importImageView;
@property (strong, nonatomic) IBOutlet UIImageView *attachImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleLayoutRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *attachLeftLayoout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left2;

@end
