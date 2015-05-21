//
//  ProcessCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CircleButton.h"

@interface ProcessCell : UITableViewCell

@property (nonatomic, strong) IBOutlet CircleButton *avatorImageView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *companyLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *flagLabel;
@property (nonatomic, strong) IBOutlet UILabel *commentLabel;

@end
