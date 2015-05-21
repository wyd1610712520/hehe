//
//  CaseRightViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-3.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CaseRightViewController.h"

#import "HttpClient.h"

#import "GeneralViewController.h"

#import "DateViewController.h"
#import "RootViewController.h"

#import "PickerView.h"


@interface CaseRightViewController ()<RequestManagerDelegate,PickerViewDelegate,UITextFieldDelegate,GeneralViewControllerDelegate,DateViewControllerDelegate>{
    CaseViewController *_caseViewController;
    
    HttpClient *_commomHttpClient;
    
    
    PickerView *_pickerView;
    
    UIButton *_currentButton;
    
    GeneralViewController *_caseTypeViewController;
    GeneralViewController *_hostViewController;
    
    NSDictionary *_caseTypeDic;
    NSDictionary *_hostDic;
    
    DateViewController *_startPicker;
    DateViewController *_endPicker;
    
    ProcessViewController *_processViewController;
}

@end

@implementation CaseRightViewController

@synthesize viewType = _viewType;

@synthesize delegate = _delegate;

@synthesize contentView = _contentView;
@synthesize scrollView = _scrollView;

@synthesize hintLabel = _hintLabel;

@synthesize caseNameField = _caseNameField;
@synthesize caseIdField = _caseIdField;
@synthesize clientNameField = _clientNameField;

@synthesize categoryButton = _categoryButton;
@synthesize chargeButton = _chargeButton;

@synthesize startTimeButton = _startTimeButton;
@synthesize endTimeButton = _endTimeButton;

@synthesize caseRightView = _caseRightView;
@synthesize processRightView = _processRightView;

+ (CaseRightViewController *)sharedInstance
{
    __strong static CaseRightViewController *instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[CaseRightViewController alloc] init];
    });
    return instance;
}

- (void)setProcessView:(ProcessViewController*)ProcessViewController{
    _processViewController = ProcessViewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    _processViewController.navigationController.view.hidden = NO;
    _caseViewController.navigationController.view.hidden = NO;
    
    if (_viewType == ViewTypeCaseRight) {
        _hintLabel.text = @"筛选";
    }
    else if (_viewType == ViewTypeProcessRight){
        _hintLabel.text = @"搜索进程";
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    _processViewController.navigationController.view.hidden = YES;
    
    _caseViewController.navigationController.view.hidden = YES;
}

- (IBAction)touchCloseEvent:(id)sender{
//    [_caseViewController showCenter];
    [_caseIdField resignFirstResponder];
    [_caseNameField resignFirstResponder];
    [_clientNameField resignFirstResponder];
    [self touchClearEvent:nil];
    [self touchSureEvent:nil];
    [self.revealContainer clickBlackLayer];
    
}
 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightbackground.png"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:imageView atIndex:0];
    
    _commomHttpClient = [[HttpClient alloc] init];
    _commomHttpClient.delegate = self;
    
    //[self.view showBorder:[UIColor blueColor]];
   // [_contentView showBorder:[UIColor greenColor]];
    
    CGRect frame = _contentView.frame;
    frame.origin.x = vectorx+20;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height * 0.04;
    frame.size.height = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
    _contentView.frame = frame;
    [self.view addSubview:_contentView];
    _scrollView.frame = _contentView.frame;
    _scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
    
    CGRect _caseframe = _caseRightView.frame;
    _caseframe.size.width = _scrollView.frame.size.width;
    _caseRightView.frame = _caseframe;
    [_scrollView addSubview:_caseRightView];
    
    _pickerView = [[PickerView alloc] initWithFrame:CGRectMake(0, _contentView.frame.size.height*0.5, _contentView.frame.size.width, _contentView.frame.size.height*0.5)];
    _pickerView.delegate = self;
    
    _caseTypeViewController = [[GeneralViewController alloc] init];
    _caseTypeViewController.delegate = self;
    
    _hostViewController = [[GeneralViewController alloc] init];
    _hostViewController.delegate = self;
    
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.dateformatter = @"yyyy-MM-dd";
    

    
    _endPicker = [[DateViewController alloc] init];
    _endPicker.delegate = self;
    _endPicker.dateformatter = @"yyyy-MM-dd";
    
//    NSString *curTime = [self getCurrentDate];
//    NSString *startTime = [self getDate];
//    
//    
//    [_startTimeButton setTitle:[NSString stringWithFormat:@"%@-01-01",startTime] forState:UIControlStateNormal];
//    [_endTimeButton setTitle:curTime forState:UIControlStateNormal];
//    
//     [_startTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_endTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (NSString*)getDate{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy"];
    
    return [dateFormatter stringFromDate:date];
}

- (NSString*)getCurrentDate{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:date];
}

- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    if (dateViewController == _startPicker) {
        [_startTimeButton setTitle:date forState:UIControlStateNormal];
       
    }
    else if (dateViewController == _endPicker){
        [_endTimeButton setTitle:date forState:UIControlStateNormal];
        
    }
}

- (void)viewWillShow{
    _caseViewController.navigationController.view.hidden = YES;
}

- (void)viewWillHide{
    _caseViewController.navigationController.view.hidden = NO;
}

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    if (generalViewController == _hostViewController) {
        _hostDic = data;
        [_chargeButton setTitle:[_hostDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_chargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _caseTypeViewController){
        _caseTypeDic = data;
        [_categoryButton setTitle:[_caseTypeDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_categoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)toucHTimeEvent:(UIButton*)sender{
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

- (IBAction)touchCategoryEvent:(UIButton*)sender{
    _currentButton = sender;
    _caseTypeViewController.commomCode = @"CACT";
    [self.navigationController pushViewController:_caseTypeViewController animated:YES];
}

- (IBAction)touchChargeEvent:(UIButton*)sender{
    _currentButton = sender;
    _hostViewController.commomCode = @"SYSEMPL";
    [self.navigationController pushViewController:_hostViewController animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - RequestManagerDelegate

//- (void)requestStarted:(id)request{
//    [_contentView showProgess:nil animation:YES];
//}
//
//- (void)request:(id)request didCompleted:(RKMappingResult*)mappingResult{
//    [_contentView hideAlertView:0];
//    
//    _commomMapping = (CommomMapping*)mappingResult.firstObject;
//    
//    [_pickerView setData:_commomMapping.record_list];
//    [_contentView addSubview:_pickerView];
//}
//
//- (void)requestFailed:(id)request{
//    [_contentView hideAlertView:0];
//}


- (void)setCenterView:(CaseViewController*)caseViewController{
    _caseViewController = caseViewController;
}


- (IBAction)touchClearEvent:(id)sender{
    _caseNameField.text = @"";
    _caseIdField.text = @"";
    _clientNameField.text = @"";
    [_categoryButton setTitle:@"请选择案件类别" forState:UIControlStateNormal];
    [_chargeButton setTitle:@"请选择案件负责人" forState:UIControlStateNormal];
    [_categoryButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [_chargeButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [_startTimeButton setTitle:@"" forState:UIControlStateNormal];
    [_endTimeButton setTitle:@"" forState:UIControlStateNormal];
    
    _startTimeButton.titleLabel.text = @"";
    _endTimeButton.titleLabel.text = @"";
    
    _caseTypeDic = nil;
    _hostDic = nil;
//    [_categoryButton setTitle:@"请选择案件类别" forState:UIControlStateNormal];
//    [_chargeButton setTitle:@"请选择案件负责人" forState:UIControlStateNormal];
//    [_startTimeButton setTitle:@"" forState:UIControlStateNormal];
//    [_endTimeButton setTitle:@"" forState:UIControlStateNormal];
//    
//    [_caseNameField setTitle:@"请输入案件名称关键字"];
//    [_caseIdField setTitle:@"请输入案件编号"];
//    [_clientNameField setTitle:@"请输入客户名称关键字"];
//    
//    _caseNameField.titleLabel.hidden = NO;
//    _clientNameField.titleLabel.hidden = NO;
//    _caseIdField.titleLabel.hidden = NO;
}


- (IBAction)touchSureEvent:(id)sender{
    if ([_delegate respondsToSelector:@selector(returnSearchKey:caseId:clientName:category:charge:startTime:endTime:)]) {
        [self.revealContainer showCenter];
        NSString *category = @"";
        NSString *charge = @"";
        
        NSString *categoryName = @"";
        NSString *chargeName = @"";
        
        NSString *startTime = @"";
        NSString *endTime = @"";
        
        if (![_categoryButton.titleLabel.text isEqualToString:@"请选择案件类别"]) {
            
            
            if (_categoryButton.titleLabel.text.length > 0) {
                category = [_caseTypeDic objectForKey:@"gc_id"];
                categoryName = [_caseTypeDic objectForKey:@"gc_name"];
            }
            else{
                category = @"";
            }
        }
        
        if (![_chargeButton.titleLabel.text isEqualToString:@"请选择案件负责人"]) {
            
            if (_chargeButton.titleLabel.text.length > 0) {
                charge = [_hostDic objectForKey:@"gc_id"];
                chargeName = [_hostDic objectForKey:@"gc_name"];
            }
            else{
                charge = @"";
            }
        }
        
        if (![_startTimeButton.titleLabel.text isEqualToString:@""]) {
            
            if (_startTimeButton.titleLabel.text.length > 0) {
                startTime = _startTimeButton.titleLabel.text;
            }
            else{
                startTime = @"";
            }
        }
        
        if (![_endTimeButton.titleLabel.text isEqualToString:@""]) {
            
            if (_endTimeButton.titleLabel.text.length > 0) {
                endTime = _endTimeButton.titleLabel.text;
            }
            else{
                endTime = @"";
            }
        }
        
        [_delegate returnSearchKey:_caseNameField.text caseId:_caseIdField.text clientName:_clientNameField.text category:category charge:charge startTime:startTime endTime:endTime];
        
        if ([_delegate respondsToSelector:@selector(returnCommomName:chargeName:)]) {
            [_delegate returnCommomName:categoryName chargeName:chargeName];
        }
    }
    
}

- (void)pickerView:(PickerView*)pickerView returnObject:(id)returnObject{
    NSDictionary *dic = (NSDictionary*)returnObject;
    [_currentButton setTitle:[dic objectForKey:@"gc_name"] forState:UIControlStateNormal];
}



@end
