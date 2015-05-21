//
//  PersonDetailViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-19.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//
#import <AddressBook/AddressBook.h>
#import "CustomNavigationViewController.h"

@interface PersonDetailViewController : CustomNavigationViewController

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dutyLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *faxLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
@property (strong, nonatomic) IBOutlet UILabel *webLabl;


@property (nonatomic, strong) NSDictionary *record;

- (IBAction)touchMessageEvent:(id)sender;
- (IBAction)touchMobileEvent:(id)sender;
- (IBAction)touchPhoneEvent:(id)sender;
- (IBAction)touchMailEvent:(id)sender;
- (IBAction)touchLocationEvent:(id)sender;

- (IBAction)touchSaveEvent:(id)sender;

@end
