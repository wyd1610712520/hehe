//
//  GeneralViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"


@class GeneralViewController;

@protocol GeneralViewControllerDelegate <NSObject>

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data;

@end

@interface GeneralViewController : CommomTableViewController

@property (nonatomic, strong) NSObject<GeneralViewControllerDelegate> *delegate;

@property (nonatomic, strong) NSString *commomCode;

@property (nonatomic, strong) NSArray *datas;

@end
