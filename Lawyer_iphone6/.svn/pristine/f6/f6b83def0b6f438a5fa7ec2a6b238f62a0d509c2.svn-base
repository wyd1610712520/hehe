//
//  CaseRightViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-3.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomViewController.h"

#import "CustomTextField.h"

#import "CaseViewController.h"

#import "ProcessViewController.h"

typedef enum {
    ViewTypeCaseRight = 1,
    ViewTypeProcessRight = 2,
}ViewType;

@class CaseRightViewController;

@protocol CaseRightViewController <NSObject>

- (void)returnSearchKey:(NSString*)caseName
                 caseId:(NSString*)caseId
             clientName:(NSString*)clientName
               category:(NSString*)category
                 charge:(NSString*)charge
              startTime:(NSString*)startTime
                endTime:(NSString*)endTime;

- (void)returnCommomName:(NSString*)categoryName chargeName:(NSString*)chargeName;

@end

@interface CaseRightViewController : CommomViewController

@property (nonatomic, assign) ViewType viewType;

@property (nonatomic, strong) NSObject<CaseRightViewController> *delegate;

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UIView *caseRightView;
@property (nonatomic, strong) IBOutlet UIView *processRightView;

@property (nonatomic, strong) IBOutlet CustomTextField *caseNameField;
@property (nonatomic, strong) IBOutlet CustomTextField *caseIdField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientNameField;
@property (nonatomic, strong) IBOutlet UIButton *categoryButton;
@property (nonatomic, strong) IBOutlet UIButton *chargeButton;
@property (nonatomic, strong) IBOutlet UIButton *startTimeButton;
@property (nonatomic, strong) IBOutlet UIButton *endTimeButton;

@property (nonatomic, strong) IBOutlet UILabel *hintLabel;

- (void)setCenterView:(CaseViewController*)caseViewController;
- (void)setProcessView:(ProcessViewController*)ProcessViewController;

+ (CaseRightViewController *)sharedInstance;

- (IBAction)touchCategoryEvent:(UIButton*)sender;
- (IBAction)touchChargeEvent:(UIButton*)sender;

- (IBAction)toucHTimeEvent:(UIButton*)sender;

- (IBAction)touchClearEvent:(id)sender;
- (IBAction)touchSureEvent:(id)sender;

- (IBAction)touchCloseEvent:(id)sender;

@end
