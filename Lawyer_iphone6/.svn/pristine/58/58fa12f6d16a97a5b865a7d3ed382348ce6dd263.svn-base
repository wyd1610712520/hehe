//
//  LogCreateViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextField.h"
#import "CustomTextView.h"

typedef enum {
    LogTypeEdit = 1,
    LogTypeAdd  = 2,
}LogType;

typedef enum {
    LogSoureceSchema = 1,
}LogSourece;

@interface LogCreateViewController : CustomNavigationViewController

@property (nonatomic, assign) LogType logType;
@property (nonatomic, assign) LogSourece logSourece;

@property (nonatomic, strong) IBOutlet UIView *currentView;
@property (nonatomic, strong) IBOutlet UIView *sureView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (nonatomic, strong) IBOutlet UIView *caseView;

@property (nonatomic, strong) IBOutlet UIButton *logJobType;
@property (nonatomic, strong) IBOutlet UIButton *caseNameButton;
@property (nonatomic, strong) IBOutlet CustomTextField *caseIdField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientNameField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientIdField;
@property (nonatomic, strong) IBOutlet UIButton *logTypeButton;
@property (nonatomic, strong) IBOutlet UIButton *jobTimeButton;
@property (nonatomic, strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UIButton *endButton;
@property (nonatomic, strong) IBOutlet CustomTextField *jobTimeField;
@property (nonatomic, strong) IBOutlet UILabel *numLabel;
@property (nonatomic, strong) IBOutlet CustomTextView *describeTextView;
@property (nonatomic, strong) NSDictionary *record;

@property (nonatomic, strong) IBOutlet UIView *lawView;

@property (nonatomic, strong) IBOutlet UIButton *lawButton;

@property (nonatomic, strong) NSDictionary *editData;

@property (nonatomic, strong) IBOutlet UIView *clientView;
@property (nonatomic, strong) IBOutlet CustomTextField *clientField;

@property (nonatomic, strong) NSString *logID;

- (IBAction)touchLogJobEvent:(id)sender;
- (IBAction)touchCaseEvent:(id)sender;
- (IBAction)touchJobTypeEvent:(id)sender;
- (IBAction)touchDateEvent:(id)sender;
- (IBAction)touchTimeEvent:(UIButton*)sender;

- (IBAction)touchSureEvent:(id)sender;

- (IBAction)touchLawEvent:(id)sender;

@end
