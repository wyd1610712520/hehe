//
//  DocumentAuditRightViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "RightViewController.h"

@class DocumentAuditViewController;

#import "CustomTextField.h"

@protocol DocumentAuditViewControllerDelegate <NSObject>

- (void)returnLogDocuData:(NSString*)fileName
                    caseId:(NSString*)caseId
                caseName:(NSString*)caseName
                 startTime:(NSString*)startTime
                   endTime:(NSString*)endTime
                    lawyer:(NSString*)lawyer;

@end

@interface DocumentAuditRightViewController : RightViewController

@property (nonatomic, strong) NSObject<DocumentAuditViewControllerDelegate> *delegate;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet CustomTextField *caseNameField;
@property (strong, nonatomic) IBOutlet CustomTextField *caseIdField;
@property (strong, nonatomic) IBOutlet CustomTextField *fileNameField;

@property (strong, nonatomic) IBOutlet UIButton *personButton;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *endButton;

- (IBAction)touchCloseEvent:(id)sender;
- (IBAction)touchPersonEvent:(id)sender;
- (IBAction)touchStartEvent:(id)sender;
- (IBAction)touchEndEvent:(id)sender;

- (IBAction)touchCleartEvent:(id)sender;

- (IBAction)touchSureEvent:(id)sender;

- (void)setDocumentAuditView:(DocumentAuditViewController*)documentAuditViewController;

@end
