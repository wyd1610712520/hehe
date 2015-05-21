//
//  LogRightViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-5.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "RightViewController.h"

#import "CustomTextField.h"

#import "LogViewController.h"

@class LogRightViewController;

@protocol LogRightViewControllerDelegate  <NSObject>

- (void)returnLogData:(NSString*)caseName
            caseID:(NSString*)caseID
        clientName:(NSString*)clientName
      caseCategory:(NSString*)caseCategory
        caseCharge:(NSString*)caseCharge
         startTime:(NSString*)startTime
              endTime:(NSString*)endTime status:(NSString*)status;

- (void)logRightViewController:(LogRightViewController *)logRightViewController param:(NSDictionary *)param;


@end

@interface LogRightViewController : RightViewController

@property (nonatomic, strong) NSObject<LogRightViewControllerDelegate> *delegate;

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *secondView;

@property (nonatomic, strong) IBOutlet CustomTextField *caseNameField;
@property (nonatomic, strong) IBOutlet CustomTextField *caseIdField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientNameField;

@property (nonatomic, strong) IBOutlet UIButton *categoryButton;
@property (nonatomic, strong) IBOutlet UIButton *chargeButton;
@property (nonatomic, strong) IBOutlet UIButton *startTimeButton;
@property (nonatomic, strong) IBOutlet UIButton *endTimeButton;

- (void)setLogView:(LogViewController*)logViewController;

- (IBAction)touchCloseEvent:(id)sender;

- (IBAction)touchNEvent:(id)sender;
- (IBAction)touchAEvent:(id)sender;
- (IBAction)touchCategoryEvent:(UIButton*)sender;
- (IBAction)touchChargeEvent:(UIButton*)sender;

- (IBAction)toucHTimeEvent:(UIButton*)sender;


- (IBAction)touchSureEvent:(id)sender;
- (IBAction)touchClearEvent:(id)sender;

// 添加

- (IBAction)touchRejectEvent:(id)sender;
@property (nonatomic, strong) IBOutlet UIImageView *img1;
@property (nonatomic, strong) IBOutlet UIImageView *img2;
@property (nonatomic, strong) IBOutlet UIImageView *green1;
@property (nonatomic, strong) IBOutlet UIImageView *green2;

@property (nonatomic, strong) IBOutlet UIImageView *img3;
@property (nonatomic, strong) IBOutlet UIImageView *green3;

@end
