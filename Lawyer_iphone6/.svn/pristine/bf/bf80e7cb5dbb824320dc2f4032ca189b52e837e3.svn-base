//
//  FileCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FileCell;

@protocol FileCellDelegate <NSObject>

- (void)addFileCell:(FileCell*)fileCell tag:(NSInteger)tag;
- (void)removeFileCell:(FileCell*)fileCell tag:(NSInteger)tag;

@end

@interface FileCell : UITableViewCell

@property (nonatomic, strong) NSObject<FileCellDelegate> *delegate;

@property (nonatomic, strong) IBOutlet UIView *secondView;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *firstLabel;
@property (nonatomic, strong) IBOutlet UILabel *secondLabel;
@property (nonatomic, strong) IBOutlet UILabel *thirdLabel;
@property (nonatomic, strong) IBOutlet UILabel *foruthLabel;
@property (nonatomic, strong) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UIButton *boxButton;
- (IBAction)touchBoxEvent:(UIButton *)sender;

@end
