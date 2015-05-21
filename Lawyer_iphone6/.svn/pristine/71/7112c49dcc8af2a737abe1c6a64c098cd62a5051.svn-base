//
//  DateViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DateViewController;


@protocol DateViewControllerDelegate <NSObject>

@optional
- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date;

@end

@interface DateViewController : UIViewController

@property (nonatomic, strong) NSObject<DateViewControllerDelegate>* delegate;

@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, strong) NSString *dateformatter;

- (IBAction)touchCloseEvent:(id)sender;
- (IBAction)touchSureEvent:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;

@end
