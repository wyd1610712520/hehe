//
//  LawRuleRightViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-26.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "RightViewController.h"

#import "CustomTextField.h"

@class LawRuleViewController;

@class LawRuleRightViewController;

@protocol LawRuleRightViewControllerDelegate <NSObject>

- (void)returnSearchKey:(NSString*)requestKey;

@end

@interface LawRuleRightViewController : RightViewController

@property (nonatomic, strong) NSObject<LawRuleRightViewControllerDelegate> *delegate;

@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (nonatomic, strong) IBOutlet UITextField *seachField;
@property (nonatomic, strong) IBOutlet UIButton *libButton;

- (void)setLawRuleView:(LawRuleViewController*)lawRuleViewController;

- (IBAction)touchLibEvent:(id)sender;

- (IBAction)touchRecordEvent:(id)sender;
- (IBAction)touchKeyEvent:(id)sender;
- (IBAction)touchLibraryEvent:(id)sender;

- (IBAction)touchCloseEvent:(id)sender;

- (IBAction)touchSureEvent:(id)sender;
- (IBAction)touchClearEvent:(id)sender;

@end
