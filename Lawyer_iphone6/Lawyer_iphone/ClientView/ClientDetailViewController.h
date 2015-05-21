//
//  ClientDetailViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-9.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomLabel.h"

@interface ClientDetailViewController : CustomNavigationViewController

@property (nonatomic, strong) NSString *clientId;

@property (strong, nonatomic) IBOutlet UIView *topView;


@property (strong, nonatomic) IBOutlet UILabel *clientNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *enNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *classLabel;

@property (strong, nonatomic) IBOutlet CustomLabel *officeLabel;
@property (strong, nonatomic) IBOutlet CustomLabel *clientTypeLabel;
@property (strong, nonatomic) IBOutlet CustomLabel *industryLabel;
@property (strong, nonatomic) IBOutlet CustomLabel *guojiaLabel;
@property (strong, nonatomic) IBOutlet CustomLabel *emailLabel;
@property (strong, nonatomic) IBOutlet CustomLabel *webLabel;
@property (strong, nonatomic) IBOutlet CustomLabel *addressLabel;
@property (strong, nonatomic) NSDictionary *record;

- (IBAction)touchSegButtonEvent:(UIButton *)sender;
- (IBAction)touchMapEvent:(id)sender;
- (IBAction)touchProfileEvent:(id)sender;

@end
