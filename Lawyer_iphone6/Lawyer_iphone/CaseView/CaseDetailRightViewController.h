//
//  CaseDetailRightViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-3.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomViewController.h"

@class CaseDetatilViewController;

@interface CaseDetailRightViewController : CommomViewController

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) NSString *caseid;
@property (nonatomic, strong) NSDictionary *record;

- (void)setCaseDetailView:(CaseDetatilViewController*)caseDetatilViewController;

- (IBAction)touchCloseEvent:(id)sender;

- (IBAction)touchCaseProcessEvent:(id)sender;
- (IBAction)touchCaseSearchEvent:(id)sender;
- (IBAction)touchCaseLogEvent:(id)sender;
- (IBAction)touchCasedocEvent:(id)sender;
- (IBAction)touchClientEvent:(id)sender;

@end
