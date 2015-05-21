//
//  CooperationRightViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "RightViewController.h"

#import "CooperationViewController.h"

@class CooperationRightViewController;

@protocol CooperationRightViewControllerDelegate <NSObject>

- (void)returnCooperationSearchKey:(NSString*)searchKey
                 category:(NSString*)category
             industry:(NSString*)industry
               region:(NSString*)region
                 address:(NSString*)address
                addressname:(NSString*)addressname
              startTime:(NSString*)startTime
                endTime:(NSString*)endTime
                      request_area:(NSString*)request_area height:(CGFloat)height titile:(NSString*)titile ;

@end

@interface CooperationRightViewController : RightViewController

@property (nonatomic, strong) NSObject<CooperationRightViewControllerDelegate> *delegate;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet CustomTextField *searchField;

@property (strong, nonatomic) IBOutlet UIButton *categoryButton;
@property (strong, nonatomic) IBOutlet UIButton *industryButton;
@property (strong, nonatomic) IBOutlet UIButton *regionButton;
@property (strong, nonatomic) IBOutlet UIButton *addressButton;

@property (nonatomic, strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UIButton *endButton;


- (IBAction)touchBackEvent:(id)sender;

- (void)setCoopretaionView:(CooperationViewController*)cooperationViewController;


- (IBAction)touchCategoryEvent:(id)sender;

- (IBAction)touchIndustryEvent:(id)sender;
- (IBAction)touchRegionEvent:(id)sender;
- (IBAction)touchAddressEvent:(id)sender;
- (IBAction)touchTimeEvent:(UIButton*)sender;
- (IBAction)touchClearEvent:(id)sender;
- (IBAction)touchSureEvent:(id)sender;


- (IBAction)touchSegmentEvent:(UIButton *)sender;

@end
