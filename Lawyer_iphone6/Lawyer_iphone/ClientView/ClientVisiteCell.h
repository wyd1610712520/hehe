//
//  ClientVisiteCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientVisiteCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *typeLabel;
@property (nonatomic, strong) IBOutlet UILabel *contentLabel;

+ (CGFloat)heightForRow:(NSString*)content;

@end
