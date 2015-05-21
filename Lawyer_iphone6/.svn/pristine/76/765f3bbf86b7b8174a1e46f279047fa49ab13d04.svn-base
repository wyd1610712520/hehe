//
//  ProfileViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-11.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"
#import "CircleButton.h"
#import "MobileCoreServices/MobileCoreServices.h"
#import "CustomTextField.h"
#define AvatorUpdate @"AvatorUpdate"

typedef enum {
    ProfileTypeNormal = 1,
    ProfileTypeEdit = 2,
}ProfileType;

@interface ProfileViewController : CustomNavigationViewController

@property (nonatomic, assign) ProfileType profileType;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet CircleButton *avatorButton;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *categoryLabel;
@property (nonatomic, strong) IBOutlet UILabel *areaLabel;

@property (nonatomic, strong) IBOutlet UILabel *roomLabel;
@property (nonatomic, strong) IBOutlet UILabel *phoneLabel;
@property (nonatomic, strong) IBOutlet UILabel *mobileLabel;
@property (nonatomic, strong) IBOutlet UILabel *emailLabel;
@property (nonatomic, strong) IBOutlet UILabel *languageLabel;
@property (nonatomic, strong) IBOutlet UILabel *zyLabel;

@property (nonatomic, strong) IBOutlet UIView *headView;
@property (nonatomic, strong) IBOutlet UIView *infoView;
@property (nonatomic, strong) IBOutlet UIView *infoButtonView;
@property (nonatomic, strong) IBOutlet UIView *buttonView;

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIImageView *arrImageView;


- (IBAction)touchLanEvent:(id)sender;



@property (nonatomic, strong) IBOutlet CustomTextField *phoneField;
@property (nonatomic, strong) IBOutlet CustomTextField *mailField;

- (IBAction)touchAvatorEvent:(id)sender;

- (IBAction)touchButtonEvent:(UIButton*)sender;

@end
