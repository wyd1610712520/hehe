//
//  SchemaTypeViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextField.h"

#import "CustomTextView.h"

typedef enum {
    SchemaTypeAdd = 1,
    SchemaTypeEdit = 2,
    SchemaTypeDetail = 3,
}SchemaType;

@class SchemaTypeViewController;

@protocol SchemaTypeViewControllerDelegate <NSObject>

- (void)schemaViewRefresh:(BOOL)isAdd;

@end


@interface SchemaTypeViewController : CustomNavigationViewController

@property (nonatomic, strong) NSObject<SchemaTypeViewControllerDelegate> *delegate;

@property (nonatomic, assign) SchemaType schemaType;

@property (nonatomic, strong) IBOutlet CustomTextField *schemaNameField;
@property (nonatomic, strong) IBOutlet CustomTextField *caseIdField;
@property (nonatomic, strong) IBOutlet CustomTextField *caseNameField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientIdField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientNameField;
@property (nonatomic, strong) IBOutlet CustomTextField *addressField;

@property (nonatomic, strong) IBOutlet UIButton *schemaTypeBotton;
@property (nonatomic, strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UIButton *endButton;
@property (nonatomic, strong) IBOutlet UIButton *remainButton;
@property (nonatomic, strong) IBOutlet UIButton *caseNameButton;
@property (nonatomic, strong) IBOutlet CustomTextView *textView;

@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) IBOutlet UIImageView *firstImageView;
@property (nonatomic, strong) IBOutlet UIImageView *secondImageView;
@property (nonatomic, strong) IBOutlet UIImageView *thirdImageView;
@property (nonatomic, strong) IBOutlet UIImageView *foruthImageView;
@property (nonatomic, strong) IBOutlet UIImageView *fifthImageView;

@property (nonatomic, strong) IBOutlet UILabel *countLabel;
@property (nonatomic, strong) IBOutlet UIButton *sureButton;

@property (nonatomic, strong) NSString *schemaId;

@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (nonatomic, strong) IBOutlet UILabel *addressLabel;

@property (nonatomic, strong) IBOutlet UIView *sureView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UISwitch *buttonSwitch;

- (IBAction)switchButton:(UISwitch *)sender;



- (IBAction)touchSureEvent:(id)sender;
- (IBAction)touchRemainEvent:(UIButton*)sender;
- (IBAction)touchCommomEvent:(UIButton*)sender;
- (IBAction)touchDateEvent:(UIButton*)sender;
- (IBAction)touchCaseEvent:(id)sender;

- (IBAction)touchLocationEvent:(id)sender;

@end
