//
//  DocuDetailViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

#import "CustomTextField.h"
#import "CustomTextView.h"

@interface DocuDetailViewController : CommomTableViewController

@property (nonatomic, strong) NSString *papered;

@property (nonatomic, strong) NSDictionary *record;
@property (strong, nonatomic) IBOutlet UIButton *fileButton;
@property (strong, nonatomic) IBOutlet UIButton *caseButton;
@property (strong, nonatomic) IBOutlet CustomTextField *docField;
@property (strong, nonatomic) IBOutlet CustomTextField *personField;
@property (strong, nonatomic) IBOutlet CustomTextField *dateFIeld;

@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (strong, nonatomic) IBOutlet CustomTextView *textView;

@property (strong, nonatomic) IBOutlet UIView *sureView;

@property (assign, nonatomic) BOOL isHideButton;


- (IBAction)touchFileEvent:(id)sender;

- (IBAction)touchCaseEvent:(id)sender;
- (IBAction)touchRejuectEvent:(id)sender;
- (IBAction)touchSureEvent:(id)sender;

@end
