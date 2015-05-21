//
//  AudioViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

@class AudioViewController;

@protocol AudioViewControllerDelegate <NSObject>

- (void)audioViewController:(AudioViewController*)audioViewController path:(NSString*)path;

@end

@interface AudioViewController : CustomNavigationViewController

@property (nonatomic, strong) NSObject<AudioViewControllerDelegate>* delegate;

@property (nonatomic, strong) IBOutlet UIButton *playButton;
@property (nonatomic, strong) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) IBOutlet UILabel *hintLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;

- (IBAction)touchRecordEvent:(UIButton*)sender;
- (IBAction)touchSaveEvent:(UIButton*)sender;

@end
