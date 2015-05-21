//
//  ClientDocCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClientDocCell;

@protocol ClientDocCellDelegate <NSObject>

- (void)didTouchZhuanEvent:(NSInteger)tag;

@end

@interface ClientDocCell : UITableViewCell

@property (nonatomic, strong) NSObject<ClientDocCellDelegate> *delegte;

@property (nonatomic, strong) IBOutlet UIImageView *logoImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *sizeLabel;

@property (nonatomic, strong) IBOutlet UIButton *button;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthLayout;

- (IBAction)touchZhuanEvent:(id)sender;


@end
