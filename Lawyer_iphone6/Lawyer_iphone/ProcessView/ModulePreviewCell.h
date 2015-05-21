//
//  ModulePreviewCell.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-2-4.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModulePreviewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

+ (CGFloat)heightForRow:(NSString*)content;

@end
