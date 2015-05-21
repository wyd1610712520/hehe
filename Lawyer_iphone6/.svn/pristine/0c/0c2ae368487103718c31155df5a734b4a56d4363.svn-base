//
//  ClientIncreaseViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-9-30.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CustomNavigationViewController.h"


#import "CustomTextField.h"

typedef enum {
    ClientIncreaseTypeNormal = 1,
    ClientIncreaseTypeEdit = 2,
}ClientIncreaseType;

@interface ClientIncreaseViewController : CustomNavigationViewController

@property (nonatomic, assign) ClientIncreaseType clientIncreaseType;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (nonatomic, strong) NSDictionary *record;

@property (nonatomic, strong) IBOutlet CustomTextField *clientNameCHField;
@property (nonatomic, strong) IBOutlet CustomTextField *clientNameEnField;
@property (nonatomic, strong) IBOutlet UIButton *classButton;
@property (nonatomic, strong) IBOutlet UIButton *areaButton;
@property (nonatomic, strong) IBOutlet UIButton *clientTypeButton;
@property (nonatomic, strong) IBOutlet UIButton *clientIndustryButton;
@property (nonatomic, strong) IBOutlet UIButton *addressButton;
@property (nonatomic, strong) IBOutlet CustomTextField *addressField;
@property (nonatomic, strong) IBOutlet CustomTextField *codeField;
@property (nonatomic, strong) IBOutlet UIButton *sureButton;

- (IBAction)touchGeneralEvent:(UIButton*)sender;
- (IBAction)touchSureEvent:(UIButton*)sender;

@end
