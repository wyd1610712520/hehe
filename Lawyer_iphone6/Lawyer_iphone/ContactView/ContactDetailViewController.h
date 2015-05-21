//
//  ContactDetailViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

typedef enum {
    DetailTypeDepart = 0,
    DetailTypePerson = 1,
}DetailType;

@interface ContactDetailViewController : CustomNavigationViewController

@property (nonatomic, assign) DetailType detailType;

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *dutyLabel;
@property (nonatomic, strong) IBOutlet UILabel *areaLabel;
@property (nonatomic, strong) IBOutlet UILabel *phoneLabel;
@property (nonatomic, strong) IBOutlet UILabel *mobileLabel;
@property (nonatomic, strong) IBOutlet UILabel *emailLabel;

@property (nonatomic, strong) NSDictionary *contactClientSubMapping;
@property (nonatomic, strong) NSDictionary *departPersonMapping;


- (IBAction)touchMessageEvent:(id)sender;
- (IBAction)touchMobileEvent:(id)sender;
- (IBAction)touchMPhoneEvent:(id)sender;
- (IBAction)touchEmailEvent:(id)sender;

- (IBAction)touchSaveEvent:(id)sender;

@end
