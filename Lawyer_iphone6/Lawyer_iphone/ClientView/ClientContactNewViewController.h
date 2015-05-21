//
//  ClientContactNewViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextField.h"

#import "CustomTextView.h"


typedef enum {
    ClientContactStateNormal = 1,
    ClientContactStateEdit = 2,
}ClientContactState;

@interface ClientContactNewViewController : CustomNavigationViewController

@property (nonatomic, assign) ClientContactState clientContactState;

@property (nonatomic, strong) IBOutlet CustomTextField *nameField;
@property (nonatomic, strong) IBOutlet CustomTextField *dutyField;
@property (nonatomic, strong) IBOutlet CustomTextField *mobileField;
@property (nonatomic, strong) IBOutlet CustomTextField *phoneField;
@property (nonatomic, strong) IBOutlet CustomTextField *chuanzhenField;
@property (nonatomic, strong) IBOutlet CustomTextField *emailField;

@property (nonatomic, strong) IBOutlet UIView *contentView;
    
@property (nonatomic, strong) IBOutlet UIView *sureView;

@property (nonatomic, strong) IBOutlet UILabel *numLabel;
@property (nonatomic, strong) IBOutlet CustomTextView *textView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIButton *sureButton;

@property (nonatomic, strong) NSDictionary *record;

@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *clr_line;

- (IBAction)touchSureEvent:(id)sender;

@end
