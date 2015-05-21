//
//  DateViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "DateViewController.h"

@interface DateViewController ()

@end

@implementation DateViewController

@synthesize delegate = _delegate;
@synthesize datePicker = _datePicker;
@synthesize dateformatter = _dateformatter;

- (id)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (IBAction)datePickerValueChanged:(id)sender{
    
}

- (IBAction)touchCloseEvent:(id)sender{
    [self.view removeFromSuperview];
}

- (IBAction)touchSureEvent:(id)sender{
    
    if ([_delegate respondsToSelector:@selector(datePicker:date:)]) {
        NSDate *selectDate = [_datePicker date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        if (_dateformatter.length > 0) {
            [dateFormatter setDateFormat:_dateformatter];
        }
        else{
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        }
        
        [_delegate datePicker:self date:[dateFormatter stringFromDate:selectDate]];
        [self.view removeFromSuperview];
    }
}

@end
