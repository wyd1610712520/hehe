//
//  CaseViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-10.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

#import "CaseCell.h"

typedef enum {
    CaseStatutsNormal = 1,
    CaseStatutsSelectable = 2,
}CaseStatuts;
@class RootViewController;
@class CaseViewController;

@protocol CaseViewControllerDelegate <NSObject>

@optional

- (void)returnDataToProcess:(NSDictionary*)item;

@end

@interface CaseViewController : CommomTableViewController

@property (nonatomic, strong) NSObject<CaseViewControllerDelegate> *delegate;

@property (nonatomic, assign) CaseStatuts caseStatuts;

@property (nonatomic, strong) NSString *searchKey;

@property (nonatomic, strong) IBOutlet CaseCell *caseCell;

@property (nonatomic, strong) IBOutlet UIView *hintView;

- (void)setRootView:(RootViewController*)rootViewController;

@end
