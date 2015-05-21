//
//  ExperienceEditViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-7.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextField.h"

#import "HttpClient.h"

#import "CustomTextView.h"

typedef enum {
    ExperienceStateAdd = 1,
    ExperienceStateEdit = 2,
    EducationStateAdd = 3,
    EducationStateEdit = 4,
}ExperienceState;

@interface ExperienceEditViewController : CustomNavigationViewController

@property (nonatomic, assign) ExperienceState experienceState;

@property (nonatomic, strong) IBOutlet UILabel *firstHintLabel;
@property (nonatomic, strong) IBOutlet UILabel *seconHintdLabel;
@property (nonatomic, strong) IBOutlet UILabel *thirdHintLabel;
@property (nonatomic, strong) IBOutlet UILabel *foruthHintLabel;

@property (nonatomic, strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UIButton *endButton;
@property (nonatomic, strong) IBOutlet CustomTextField *companyField;
@property (nonatomic, strong) IBOutlet CustomTextField *dutyField;
@property (nonatomic, strong) IBOutlet CustomTextView *textView;

@property (nonatomic, strong) IBOutlet CustomTextField *fourthField;

@property (nonatomic, strong) IBOutlet UIImageView *lineImageView;

@property (nonatomic, strong) NSDictionary *mapping;
@property (nonatomic, strong) NSDictionary *educationMapping;

@property (nonatomic, strong) NSString *erdID;

- (IBAction)touchSureEvent:(id)sender;
- (IBAction)touchTimeEvent:(UIButton*)sender;

@end
