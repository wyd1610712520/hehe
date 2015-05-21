//
//  HomeViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-8.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommomViewController.h"

#import "OBShapedButton.h"
#import "CustomTextField.h"

@interface HomeViewController : CommomViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *centerView;

@property (strong, nonatomic) IBOutlet CustomTextField *searchField;

@property (strong, nonatomic) IBOutlet OBShapedButton *logButton;
@property (strong, nonatomic) IBOutlet OBShapedButton *schemaButton;
@property (strong, nonatomic) IBOutlet OBShapedButton *processButton;
@property (strong, nonatomic) IBOutlet OBShapedButton *cooperationButton;
@property (strong, nonatomic) IBOutlet OBShapedButton *newsButton;
@property (strong, nonatomic) IBOutlet OBShapedButton *docButton;
@property (strong, nonatomic) IBOutlet UIImageView *hotImageView;

+ (HomeViewController *)sharedInstance;

- (IBAction)touchLeftEvent:(id)sender;
- (IBAction)touchClientEvent:(id)sender;
- (IBAction)touchCaseEvent:(id)sender;
- (IBAction)touchLogEvent:(id)sender;
- (IBAction)touchSchemaEvent:(id)sender;
- (IBAction)touchNewsEvent:(id)sender;
- (IBAction)touchMenuEvent:(id)sender;
- (IBAction)touchFileView:(id)sender;
- (IBAction)touchProcessView:(id)sender;
- (IBAction)touchCooperationEvent:(id)sender;

- (IBAction)touchCollectEvent:(id)sender;
- (IBAction)touchAuditEvent:(id)sender;

@end
