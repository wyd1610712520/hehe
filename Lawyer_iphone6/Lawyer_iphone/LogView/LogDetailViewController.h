//
//  LogDetailViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-24.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextField.h"

typedef enum {
    LogAudtiStateNormal = 0,
    LogAudtiStateAudit = 1,
}LogAudtiState;

@interface LogDetailViewController : CustomNavigationViewController
@property (nonatomic, assign) LogAudtiState logAudtiState;
@property (nonatomic, strong) NSString *logId;
@property (nonatomic, strong) NSString *auditStatus;


@property (nonatomic, strong) IBOutlet UIView *sureView;

@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) IBOutlet UIButton *caseNameButton;
@property (nonatomic, strong) IBOutlet CustomTextField *caseIdField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientNameField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientIdField;
@property (nonatomic, strong) IBOutlet CustomTextField *lawyerField;
@property (nonatomic, strong) IBOutlet CustomTextField *workTimeField;
@property (nonatomic, strong) IBOutlet UIButton *logTypeButton;
@property (nonatomic, strong) IBOutlet CustomTextField *timeField;
@property (nonatomic, strong) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet UIView *auditView;

@property (strong, nonatomic) IBOutlet CustomTextField *yewuLabel;
@property (strong, nonatomic) IBOutlet UILabel *miaoshuLabel;
@property (strong, nonatomic) IBOutlet CustomTextField *zhangdanLabel;

@property (strong, nonatomic) IBOutlet UIImageView *fristImageView;
@property (strong, nonatomic) IBOutlet UIImageView *secondImageView;

@property (assign, nonatomic) BOOL isDone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMar;

- (IBAction)touchSureEvent:(id)sender;

// 添加

// 退回点击
- (IBAction)touchRejectEvent:(id)sender;
// 日志类别
@property (nonatomic, strong) IBOutlet UILabel *logCateLabel;
// 案件名称点击
- (IBAction)touchCaseNameEvent:(id)sender;
// 点击查看审核演示
@property (nonatomic, strong) IBOutlet UIButton *auditDemoButton;
- (IBAction)touchAuditDemoEvent:(id)sender;


@end
