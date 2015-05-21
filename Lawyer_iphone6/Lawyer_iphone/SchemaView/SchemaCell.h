//
//  SchemaCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-25.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchemaCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *logoImageView;
@property (nonatomic, strong) IBOutlet UILabel *startLabel;
@property (nonatomic, strong) IBOutlet UILabel *endLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *typeLabel;

@end
