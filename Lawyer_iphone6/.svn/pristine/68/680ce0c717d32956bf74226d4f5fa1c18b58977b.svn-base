//
//  CommomTableViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-9-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchField.h"

#import "PullToRefreshIndicator.h"
#import "CustomNavigationViewController.h"
#import "SegmentView.h"

#import "CustomSegment.h"

@interface CommomTableViewController : CustomNavigationViewController

@property (nonatomic, strong) PullToRefreshIndicator* topRefreshIndicator;
@property (nonatomic, strong) PullToRefreshIndicator* bottomRefreshIndicator;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *tableDic;
@property (nonatomic, strong) NSMutableArray *tableDatas;
@property (nonatomic, strong) NSMutableArray *tableWords;
@property (nonatomic, strong) NSMutableSet *indexSet;

@property (nonatomic, strong) SearchField *searchField;
@property (nonatomic, strong) SegmentView *segmentView;

@property (nonatomic, strong) CustomSegment *customSegment;

- (void)hideSearchBar;
- (void)showSearchBar;
- (void)clearTableData;

- (void)showSegment:(NSArray*)titles;

- (void)showTable;

- (void)setSegmentTitles:(NSArray*)titles frame:(CGRect)frame;

@end
