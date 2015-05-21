//
//  LogAuditRightViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "RightViewController.h"

#import "CustomTextField.h"

@class LogAuditViewController;

@class LogAuditRightViewController;

@protocol LogAuditRightViewControllerDelegate <NSObject>

- (void)returnLogAuditData:(NSString*)caseName
                    caseId:(NSString*)caseId
                clientName:(NSString*)clientName
                 startTime:(NSString*)startTime
                   endTime:(NSString*)endTime
                    lawyer:(NSString*)lawyer;

@end

@interface LogAuditRightViewController : RightViewController


@property (nonatomic, strong) NSObject<LogAuditRightViewControllerDelegate> *delegate;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet CustomTextField *caseNameField;
@property (strong, nonatomic) IBOutlet CustomTextField *caseIdField;
@property (strong, nonatomic) IBOutlet CustomTextField *clientNameField;

@property (strong, nonatomic) IBOutlet UIButton *personButton;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *endButton;


- (IBAction)touchCloseEvent:(id)sender;
- (IBAction)touchPersonEvent:(id)sender;
- (IBAction)touchStartEvent:(id)sender;
- (IBAction)touchEndEvent:(id)sender;

- (IBAction)touchCleartEvent:(id)sender;

- (IBAction)touchSureEvent:(id)sender;

- (void)setLogAuditView:(LogAuditViewController*)logAuditViewController;

@end
