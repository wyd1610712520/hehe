//
//  ClientContactViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-9.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

#import "NSString+Utility.h"

typedef enum {
    ClientContactTypeNormal = 1,
    ClientContactTypeRelate = 2,
}ClientContactType;


@interface ClientContactViewController : CommomTableViewController

@property (nonatomic, assign) ClientContactType clientContactType;

@property (nonatomic, strong) NSString *clientID;

@property (nonatomic, strong) IBOutlet UIView *hintView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIButton *sureButton;

@end
