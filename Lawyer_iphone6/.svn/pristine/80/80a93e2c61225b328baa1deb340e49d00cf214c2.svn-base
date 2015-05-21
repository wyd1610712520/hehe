//
//  LogAdviceViewController.m
//  Lawyer_iphone
//
//  Created by bitzsoft_mac on 15/4/14.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "LogAdviceViewController.h"

@interface LogAdviceViewController ()

@end

@implementation LogAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDismissButton];
    
    [self setTitle:@"审核信息" color:nil];
    
    
    if ([_auditStatusStr isEqualToString:@"B"])
    {
        _auditStatus.text = @"退回";
        [_auditStatus setTextColor:[UIColor redColor]];
        
        _leftYewuHour.textAlignment = NSTextAlignmentRight;
        _leftYewuHour.text = @"审核人：";
        _leftZhangdanHour.text = @"审核意见：";
        
        _yewuHour.text = _auditPersonStr;
        
        _line1.hidden = YES;
        _line2.hidden = YES;

        _leftAuditPerson.hidden = YES;
        _leftAuditAdvice.hidden = YES;
        
        _rAuditAdvice.text = _auditAdviceStr;
    }
    if ([_auditStatusStr isEqualToString:@"A"])
    {
        _auditStatus.text = @"通过";
        
        _auditPerson.text = _auditPersonStr;
        _auditAdvice.text = _auditAdviceStr;
        
        _yewuHour.text = _yewuHourStr;
        _zhangdanHour.text = _zhangdanHourStr;
    }
    
}

@end
