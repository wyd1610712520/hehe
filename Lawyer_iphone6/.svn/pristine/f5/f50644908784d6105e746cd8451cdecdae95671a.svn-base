//
//  SetupViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-11.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "RightViewController.h"

#import "LineImageView.h"
#import "CircleButton.h"

#import "HomeViewController.h"


@interface SetupViewController : RightViewController

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIView *secondView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet CircleButton *avatorButton;

@property (nonatomic, strong) IBOutlet UILabel *sizeLabel;

@property (nonatomic, strong) IBOutlet LineImageView *lineImageView;

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;

+ (SetupViewController *)sharedInstance;

- (IBAction)touchShareEvent:(id)sender;
- (IBAction)touchPasswrodEvent:(id)sender;
- (IBAction)touchAvatorEvent:(id)sender;

- (IBAction)touchExitEvent:(id)sender;
- (void)setHomeView:(HomeViewController*)homeViewController;

- (IBAction)touchClearDataEvent:(id)sender;
- (IBAction)touchHelpEvent:(id)sender;
- (IBAction)touchCommentDataEvent:(id)sender;
- (IBAction)touchAboutDataEvent:(id)sender;

@end
