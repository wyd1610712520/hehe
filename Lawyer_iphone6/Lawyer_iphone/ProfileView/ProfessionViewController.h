//
//  ProfessionViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-3.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

typedef enum {
    ProfessionTypeNormal = 1,
    ProfessionTypeEdit = 2,
}ProfessionType;

@interface ProfessionViewController : CommomTableViewController

@property (nonatomic, assign) ProfessionType professionType;

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UILabel *professionLabel;
@property (nonatomic, strong) IBOutlet UILabel *hintLabel;
@property (nonatomic, strong) IBOutlet UIButton *sureButton;

- (IBAction)touchSureEvent:(id)sender;

@end
