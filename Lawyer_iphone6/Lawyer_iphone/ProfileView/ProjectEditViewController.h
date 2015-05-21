//
//  ProjectEditViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-15.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import "CustomTextView.h"

typedef enum {
    ProjectStateAdd = 1,
    ProjectStateEdit = 2,
}ProjectState;


@interface ProjectEditViewController : CustomNavigationViewController

@property (nonatomic, assign) ProjectState projectState;

@property (nonatomic, strong) NSString *pro_id;
@property (nonatomic, strong) NSString *pro_name;

@property (nonatomic, strong) IBOutlet CustomTextView *textView;
@property (nonatomic, strong) IBOutlet UILabel *numLabel;

- (IBAction)touchSureEvent:(id)sender;

@end
