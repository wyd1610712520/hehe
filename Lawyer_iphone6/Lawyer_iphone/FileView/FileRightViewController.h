//
//  FileRightViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "RightViewController.h"

#import "FileViewController.h"

#import "CustomTextField.h"

@class FileRightViewController;

@protocol FileRightViewControllerDelegate  <NSObject>

- (void)fileRightViewController:(FileRightViewController*)fileRightViewController searchDic:(NSDictionary*)searchDic;

- (void)didTouchManageEvnet;

- (void)fileRightView:(NSString*)title name:(NSString*)name;

@end

@interface FileRightViewController : RightViewController

@property (nonatomic, strong) NSObject<FileRightViewControllerDelegate> *delegate;

@property (strong, nonatomic) IBOutlet UIView *buttonView;

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet CustomTextField *searchField;

@property (nonatomic, strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UIButton *endButton;
@property (nonatomic, strong) IBOutlet UIButton *docButton;
@property (nonatomic, strong) IBOutlet UIButton *areaButton;
@property (nonatomic, strong) IBOutlet UIButton *arrangeButton;

@property (nonatomic, assign) CGFloat heightView;

@property (strong, nonatomic) IBOutlet UIButton *orderButton;
@property (strong, nonatomic) IBOutlet UIButton *manegerButton;
@property (strong, nonatomic) IBOutlet UILabel *orderLabel;
@property (strong, nonatomic) IBOutlet UIButton *newfileButton;

@property (strong, nonatomic) NSString *classid;

@property (strong, nonatomic) IBOutlet UIImageView *firstLineView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonTopLayout;


- (void)setFileView:(FileViewController*)fileViewController;

- (IBAction)touchBackEvent:(id)sender;

- (IBAction)touchClearEvent:(id)sender;
- (IBAction)touchSureEvent:(id)sender;
- (IBAction)touchTimeEvent:(UIButton*)sender;
- (IBAction)touchButtonEvent:(UIButton*)sender;
- (IBAction)touchOrderEvent:(id)sender;
- (IBAction)touchManagerEvent:(id)sender;
- (IBAction)touchDocEvent:(id)sender;
- (IBAction)touchAreaEvent:(id)sender;

- (IBAction)touchNewFileEvent:(id)sender;
@end
