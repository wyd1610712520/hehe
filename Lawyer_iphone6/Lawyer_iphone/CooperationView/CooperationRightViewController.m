//
//  CooperationRightViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//


#import "CooperationRightViewController.h"

#import "RevealViewController.h"

#import "GeneralViewController.h"

#import "DateViewController.h"

@interface CooperationRightViewController ()<UITextFieldDelegate,GeneralViewControllerDelegate,DateViewControllerDelegate>{
    CooperationViewController *_cooperationViewController;
    
    GeneralViewController *_categoryViewController;
    GeneralViewController *_industryViewController;
    GeneralViewController *_regionViewController;
    GeneralViewController *_addressViewController;
    
    NSDictionary *_categoryDic;
    NSDictionary *_industryDic;
    NSDictionary *_regionDic;
    NSDictionary *_addressDic;
    
    DateViewController *_startPicker;
    DateViewController *_endPicker;
    
    int count;
}

@end

@implementation CooperationRightViewController

@synthesize contentView = _contentView;
@synthesize scrollView = _scrollView;

@synthesize searchField = _searchField;
@synthesize categoryButton = _categoryButton;
@synthesize industryButton = _industryButton;
@synthesize regionButton = _regionButton;
@synthesize addressButton = _addressButton;

@synthesize startButton = _startButton;
@synthesize endButton = _endButton;


@synthesize delegate = _delegate;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    self.navigationController.navigationBarHidden = YES;
    _cooperationViewController.navigationController.view.hidden = NO;

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (count == 0) {
        self.navigationController.navigationBarHidden = YES;
        _cooperationViewController.navigationController.view.hidden = NO;
        count ++;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    _cooperationViewController.navigationController.view.hidden = YES;
}

- (void)setCoopretaionView:(CooperationViewController*)cooperationViewController{
    _cooperationViewController = cooperationViewController;
}

- (IBAction)touchCategoryEvent:(id)sender {
    _categoryViewController.commomCode = @"CPCT";
    [self.navigationController pushViewController:_categoryViewController animated:YES];
}

- (IBAction)touchIndustryEvent:(id)sender {
    _industryViewController.commomCode = @"CLIDT";
    [self.navigationController pushViewController:_industryViewController animated:YES];
}

- (IBAction)touchRegionEvent:(id)sender {
    _regionViewController.commomCode = @"FIELD";
    [self.navigationController pushViewController:_regionViewController animated:YES];
}

- (IBAction)touchAddressEvent:(id)sender {
    _addressViewController.commomCode = @"CLCNT";
    [self.navigationController pushViewController:_addressViewController animated:YES];
}

- (IBAction)touchTimeEvent:(UIButton*)sender {
    [_searchField resignFirstResponder];
    if (sender.tag == 0) {
        CGRect frame = _startPicker.view.frame;
        frame.origin.x = vectorx;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
        _startPicker.view.frame = frame;
        
        
        [self.view addSubview:_startPicker.view];
    }
    else if (sender.tag == 1){
        CGRect frame = _endPicker.view.frame;
        frame.origin.x = vectorx;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
        _endPicker.view.frame = frame;
        [self.view addSubview:_endPicker.view];
    }

}

- (IBAction)touchClearEvent:(id)sender {
    _searchField.text = @"";
    [_categoryButton setTitle:@"请选择需求类型" forState:UIControlStateNormal];
    [_industryButton setTitle:@"请选择行业" forState:UIControlStateNormal];
    [_regionButton setTitle:@"请选择涉及领域" forState:UIControlStateNormal];
    [_addressButton setTitle:@"请选择地区" forState:UIControlStateNormal];
    [_startButton setTitle:@"" forState:UIControlStateNormal];
    [_endButton setTitle:@"" forState:UIControlStateNormal];
    
    _categoryDic = nil;

    _regionDic = nil;
    _addressDic = nil;
    _industryDic = nil;
    
    [_startButton setTitle:@"" forState:UIControlStateNormal];
    [_endButton setTitle:@"" forState:UIControlStateNormal];
    _startButton.titleLabel.text = @"";
    _endButton.titleLabel.text = @"";
    
    [_categoryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_industryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_regionButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_addressButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (IBAction)touchSureEvent:(id)sender {
    if ([_delegate respondsToSelector:@selector(returnCooperationSearchKey:category:industry:region:address: addressname:startTime:endTime:request_area:height:titile:)]) {
        [_delegate returnCooperationSearchKey:_searchField.text category:[_categoryDic objectForKey:@"gc_id"]  industry:[_industryDic objectForKey:@"gc_id"] region:[_regionDic objectForKey:@"gc_id"] address:[_addressDic objectForKey:@"gc_id"] addressname:[_addressDic objectForKey:@"gc_name"] startTime:_startButton.titleLabel.text endTime:_endButton.titleLabel.text request_area:@"" height:88 titile:@"合作信息"];
        [self.revealContainer clickBlackLayer];
    }
    
}

- (IBAction)touchSegmentEvent:(UIButton *)sender {
    if (sender.tag == 0) {
        if ([_delegate respondsToSelector:@selector(returnCooperationSearchKey:category:industry:region:address:addressname:startTime:endTime:request_area:height:titile:)]) {
            [_delegate returnCooperationSearchKey:@"" category:@"" industry:@"" region:@"" address:@"" addressname:@"" startTime:@"" endTime:@"" request_area:@"my" height:110 titile:@"我发布的" ];
            [self.revealContainer clickBlackLayer];
        }
    }
    else if (sender.tag == 1) {
        if ([_delegate respondsToSelector:@selector(returnCooperationSearchKey:category:industry:region:address:addressname:startTime:endTime:request_area:height:titile:)]) {
            [_delegate returnCooperationSearchKey:@"" category:@"" industry:@"" region:@"" address:@"" addressname:@""startTime:@"" endTime:@"" request_area:@"care" height:88 titile:@"我关注的" ];
            [self.revealContainer clickBlackLayer];
        }
    }
    else if (sender.tag == 2) {
        if ([_delegate respondsToSelector:@selector(returnCooperationSearchKey:category:industry:region:address:addressname:startTime:endTime:request_area:height:titile:)]) {
            [_delegate returnCooperationSearchKey:@"" category:@"" industry:@"" region:@"" address:@"" addressname:@""startTime:@"" endTime:@"" request_area:@"collect" height:88 titile:@"我收藏的" ];
            [self.revealContainer clickBlackLayer];
        }
    }
    else if (sender.tag == 3) {
        if ([_delegate respondsToSelector:@selector(returnCooperationSearchKey:category:industry:region:address:addressname:startTime:endTime:request_area:height:titile:)]) {
            [_delegate returnCooperationSearchKey:@"" category:@"" industry:@"" region:@"" address:@"" addressname:@""startTime:@"" endTime:@"" request_area:@"zan" height:88 titile:@"我赞过的" ];
            [self.revealContainer clickBlackLayer];
        }
    }
    else if (sender.tag == 4) {
        if ([_delegate respondsToSelector:@selector(returnCooperationSearchKey:category:industry:region:address:addressname:startTime:endTime:request_area:height:titile:)]) {
            [_delegate returnCooperationSearchKey:@"" category:@"" industry:@"" region:@"" address:@"" addressname:@""startTime:@"" endTime:@"" request_area:@"reply" height:88 titile:@"我回复的" ];
            [self.revealContainer clickBlackLayer];
        }
    }
    else if (sender.tag == 5) {
        if ([_delegate respondsToSelector:@selector(returnCooperationSearchKey:category:industry:region:address:addressname:startTime:endTime:request_area:height:titile:)]) {
            [_delegate returnCooperationSearchKey:@"" category:@"" industry:@"" region:@"" address:@"" addressname:@""startTime:@"" endTime:@"" request_area:@"" height:88 titile:@"合作信息" ];
            [self.revealContainer clickBlackLayer];
        }
    }
}

- (IBAction)touchBackEvent:(id)sender{
    [self.revealContainer clickBlackLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = _contentView.frame;
    frame.origin.x = vectorx+20;
    frame.origin.y = 20;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;;
    frame.size.height = 900;
    _contentView.frame = frame;
    
    
    
    [_scrollView addSubview:_contentView];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 900)];
    
    _categoryViewController = [[GeneralViewController alloc] init];
    _categoryViewController.delegate = self;
    
    _industryViewController = [[GeneralViewController alloc] init];
    _industryViewController.delegate = self;

    _regionViewController = [[GeneralViewController alloc] init];
    _regionViewController.delegate = self;
    
    _addressViewController = [[GeneralViewController alloc] init];
    _addressViewController.delegate = self;
    
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.dateformatter = @"yyyy-MM-dd";
    
    
    
    _endPicker = [[DateViewController alloc] init];
    _endPicker.delegate = self;
    _endPicker.dateformatter = @"yyyy-MM-dd";
}

- (void)general:(GeneralViewController *)generalViewController data:(NSDictionary *)data{
    if (generalViewController == _categoryViewController) {
        _categoryDic = data;
        [_categoryButton setTitle:[data objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_categoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _industryViewController) {
        _industryDic = data;
        [_industryButton setTitle:[data objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_industryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _regionViewController) {
        _regionDic = data;
        [_regionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_regionButton setTitle:[data objectForKey:@"gc_name"] forState:UIControlStateNormal];
    }
    else if (generalViewController == _addressViewController) {
        _addressDic = data;
        [_addressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addressButton setTitle:[data objectForKey:@"gc_name"] forState:UIControlStateNormal];
    }
}

- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    if (dateViewController == _startPicker) {
        [_startButton setTitle:date forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (dateViewController == _endPicker){
        [_endButton setTitle:date forState:UIControlStateNormal];
        [_endButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
