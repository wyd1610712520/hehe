//
//  ProcessFragmentNewViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-23.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextField.h"
#import "CustomTextView.h"

typedef enum {
    ProceeFragmentNew = 0,
    ProceeFragmentEdit = 1,
}ProceeFragment;

@interface ProcessFragmentNewViewController : CustomNavigationViewController
@property (strong, nonatomic) IBOutlet CustomTextField *nameField;
@property (strong, nonatomic) IBOutlet UIButton *statusButton;
@property (strong, nonatomic) IBOutlet UISlider *valueButton;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *endButton;
@property (strong, nonatomic) IBOutlet UIButton *managerButton;
@property (strong, nonatomic) IBOutlet UIButton *groupButton;
@property (strong, nonatomic) IBOutlet CustomTextView *textView;
@property (strong, nonatomic) IBOutlet UIView *sureView;

@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

@property (nonatomic, assign) BOOL showNew;

@property (assign, nonatomic) ProceeFragment proceeFragment;

@property (nonatomic, strong) NSString *caseID;
@property (nonatomic, strong) NSString *ywcpID;

@property (nonatomic, strong) NSDictionary *record;

@property (nonatomic, assign) BOOL isCustom;

@property (nonatomic, strong) IBOutlet UILabel *numLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *contentView;

- (IBAction)touchStatusEvent:(id)sender;
- (IBAction)touchValueEvent:(UISlider*)sender;
- (IBAction)touchTimeEvent:(UIButton *)sender;
- (IBAction)touchManagerEvent:(id)sender;
- (IBAction)touchGroupEvent:(UIButton *)sender;
- (IBAction)touchSureEvent:(id)sender;

- (IBAction)touchMediaEvent:(id)sender;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;


@end
