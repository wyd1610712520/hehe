//
//  LogAdviceViewController.h
//  Lawyer_iphone
//
//  Created by bitzsoft_mac on 15/4/14.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

@interface LogAdviceViewController : CustomNavigationViewController

// all string
@property (nonatomic, strong) NSString *auditStatusStr;
@property (nonatomic, strong) NSString *yewuHourStr;
@property (nonatomic, strong) NSString *zhangdanHourStr;
@property (nonatomic, strong) NSString *auditPersonStr;
@property (nonatomic, strong) NSString *auditAdviceStr;

// 右边文字
@property (nonatomic, strong) IBOutlet UILabel *auditStatus;
@property (nonatomic, strong) IBOutlet UILabel *yewuHour;
@property (nonatomic, strong) IBOutlet UILabel *zhangdanHour;
@property (nonatomic, strong) IBOutlet UILabel *auditPerson;
@property (nonatomic, strong) IBOutlet UILabel *auditAdvice;

// 左边文字
@property (nonatomic, strong) IBOutlet UILabel *leftAuditStatus;
@property (nonatomic, strong) IBOutlet UILabel *leftYewuHour;
@property (nonatomic, strong) IBOutlet UILabel *leftZhangdanHour;
@property (nonatomic, strong) IBOutlet UILabel *leftAuditPerson;
@property (nonatomic, strong) IBOutlet UILabel *leftAuditAdvice;

// 后面两根线
@property (nonatomic, strong) IBOutlet UIView *line1;
@property (nonatomic, strong) IBOutlet UIView *line2;

// 退回状态审核意见
@property (nonatomic, strong) IBOutlet UILabel *rAuditAdvice;

@end
