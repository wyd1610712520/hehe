//
//  ContactCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *numLabel;
@property (nonatomic, strong) IBOutlet UILabel *phoneLabel;
@property (nonatomic, strong) IBOutlet UILabel *mobileLabel;

@end
