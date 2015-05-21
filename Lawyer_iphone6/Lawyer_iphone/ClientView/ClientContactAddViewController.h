//
//  ClientContactAddViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextField.h"
#import "CustomTextView.h"


typedef enum {
    ClientAddStateNormal = 1,
    ClientAddStateEdit = 2,
}ClientAddState;

@interface ClientContactAddViewController : CustomNavigationViewController


@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIView *sureView;

@property (nonatomic, assign) ClientAddState clientAddState;

@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *ccri_line;

@property (nonatomic, strong) IBOutlet CustomTextField *nameField;
@property (nonatomic, strong) IBOutlet UIButton *relateButton;
@property (nonatomic, strong) IBOutlet CustomTextField *linkerField;
@property (nonatomic, strong) IBOutlet CustomTextField *zongjiField;
@property (nonatomic, strong) IBOutlet CustomTextField *addressField;
@property (nonatomic, strong) IBOutlet CustomTextField *faxField;
@property (nonatomic, strong) IBOutlet CustomTextField *emailField;
@property (nonatomic, strong) IBOutlet CustomTextView *textView;

@property (nonatomic, strong) IBOutlet UILabel *numLabel;

@property (nonatomic, strong) NSDictionary *record;

- (IBAction)touchSureEvent:(id)sender;
- (IBAction)touchRelateEvent:(id)sender;

@end
