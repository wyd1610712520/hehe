//
//  FileRightViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "FileRightViewController.h"

#import "GeneralViewController.h"

#import "DateViewController.h"

#import "FileResultViewController.h"

#import "GeneralViewController.h"
#import "RootViewController.h"

@interface FileRightViewController ()<UITextFieldDelegate,GeneralViewControllerDelegate,GeneralViewControllerDelegate,DateViewControllerDelegate>{
    FileViewController *_fileViewController;
    
    DateViewController *_startPicker;
    DateViewController *_endPicker;
    
    NSDictionary*_docDic;
    NSDictionary*_areaDic;
    
    NSArray *_areaData;

    
    GeneralViewController *_docViewController;
    GeneralViewController *_areaViewController;
    
    FileResultViewController *_fileResultViewController;
    
    NSArray *_generalData;
    NSDictionary *_generalDic;
    GeneralViewController *_generalViewController;
}

@end

@implementation FileRightViewController

@synthesize contentView = _contentView;

@synthesize searchField = _searchField;
@synthesize startButton = _startButton;
@synthesize endButton = _endButton;
@synthesize classid = _classid;
@synthesize areaButton = _areaButton;
@synthesize docButton = _docButton;
@synthesize arrangeButton = _arrangeButton;

@synthesize heightView = _heightView;

@synthesize orderButton = _orderButton;
@synthesize manegerButton = _manegerButton;

@synthesize delegate = _delegate;

- (void)setFileView:(FileViewController*)fileViewController{
    _fileViewController = fileViewController;
    self.navigationController.navigationBarHidden = YES;
    _fileViewController.navigationController.view.hidden = NO;
}

- (IBAction)touchBackEvent:(id)sender{
    [self.revealContainer clickBlackLayer];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
    _fileViewController.navigationController.view.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    _fileViewController.navigationController.view.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = _contentView.frame;
    frame.origin.x = vectorx+20;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height * 0.04;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
    frame.size.height = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    _contentView.frame = frame;
    
    [self.scrollView addSubview:_contentView];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _contentView.frame.size.height+20)];
    
    
    self.navigationController.navigationBarHidden = YES;
    _fileViewController.navigationController.view.hidden = NO;

     
    _docViewController = [[GeneralViewController alloc] init];
    _docViewController.delegate = self;
    
    if (Iphone6 || Iphone6s) {
        _buttonTopLayout.constant = 100;
    }
    
    NSDictionary *area1 = [NSDictionary dictionaryWithObjectsAndKeys:@"all",@"gc_id",@"所有文件夹",@"gc_name", nil];
    NSDictionary *area2 = [NSDictionary dictionaryWithObjectsAndKeys:@"current",@"gc_id",@"当前文件夹",@"gc_name", nil];

    _areaData = [NSArray arrayWithObjects:area1,area2, nil];
    _areaViewController = [[GeneralViewController alloc] init];
    _areaViewController.delegate = self;
    _areaViewController.datas = _areaData;

    
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.dateformatter = @"yyyy-MM-dd";
    
    _endPicker = [[DateViewController alloc] init];
    _endPicker.delegate = self;
    _endPicker.dateformatter = @"yyyy-MM-dd";
    
    _fileResultViewController = [[FileResultViewController alloc] init];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"time-desc",@"gc_id",@"时间倒序",@"gc_name", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"name-asc",@"gc_id",@"名称顺序",@"gc_name", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"name-desc",@"gc_id",@"名称倒序",@"gc_name", nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"time-asc",@"gc_id",@"时间顺序",@"gc_name", nil];
    _generalData = [NSArray arrayWithObjects:dic1,dic4,dic2,dic3, nil];
    _generalViewController = [[GeneralViewController alloc] init];
    _generalViewController.datas = _generalData;
    _generalViewController.delegate = self;
    
    [_areaButton setTitle:@"当前文件夹" forState:UIControlStateNormal];
    [_areaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    if (dateViewController == _startPicker) {
        [_startButton setTitle:date forState:UIControlStateNormal];
    }
    else if (dateViewController == _endPicker){
        [_endButton setTitle:date forState:UIControlStateNormal];
    }
}

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    if (generalViewController == _docViewController) {
        _docDic = data;
        [_docButton setTitle:[_docDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_docButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _areaViewController){
        _areaDic = data;
        [_areaButton setTitle:[_areaDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_areaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _generalViewController){
        _generalDic = data;
        [_orderLabel setText:[_generalDic objectForKey:@"gc_name"]];
    }
}

- (NSDictionary*)fileParams{
    NSString *startTime = @"";
    if (_startButton.titleLabel.text.length > 0) {
        startTime = _startButton.titleLabel.text;
    }
    
    NSString *endTime = @"";
    if (_endButton.titleLabel.text.length > 0) {
        endTime = _endButton.titleLabel.text;
    }
    NSString *search = @"";
    
    if (_searchField.text.length > 0) {
        search = _searchField.text;
    }
    
    NSString *doc = @"";
    if ([[_docDic objectForKey:@"gc_id"] length] > 0) {
        doc = [_docDic objectForKey:@"gc_id"];
    }
    
    NSString *area = @"current";
    if ([[_areaDic objectForKey:@"gc_id"] length] > 0) {
        area = [_areaDic objectForKey:@"gc_id"];
    }
    
    
    NSString *order = @"";
    if ([[_generalDic objectForKey:@"gc_id"] length] > 0) {
        order = [_generalDic objectForKey:@"gc_id"];
    }
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"", @"caseID",
                            _classid, @"classID",
                            startTime, @"do_create_begin",
                            endTime, @"do_create_end",
                            search, @"do_title",
                            doc, @"do_creator",
                            area, @"do_search_area",
                            order, @"do_order",
                            @"", @"last_request_date",
                            nil];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"docList",@"requestKey",
                            fields,@"fields",
                            nil];
    return params;
}

- (IBAction)touchTimeEvent:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if (tag == 0) {
        CGRect frame = _startPicker.view.frame;
        frame.origin.x = vectorx;
        frame.size.width = self.view.frame.size.width - frame.origin.x;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        _startPicker.view.frame = frame;
        [self.view addSubview:_startPicker.view];
    }
    else if (tag == 1){
        CGRect frame = _endPicker.view.frame;
        frame.origin.x = vectorx;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        frame.size.width = self.view.frame.size.width - frame.origin.x;
        _endPicker.view.frame = frame;
        [self.view addSubview:_endPicker.view];
    }
}


- (IBAction)touchButtonEvent:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if (tag == 0) {
        
    }
    else if (tag == 1){
        
    }
}

- (IBAction)touchOrderEvent:(id)sender {
    [self.navigationController pushViewController:_generalViewController animated:YES];
}

- (IBAction)touchNewFileEvent:(id)sender{
    
}


- (IBAction)touchManagerEvent:(id)sender {
    if ([_delegate respondsToSelector:@selector(didTouchManageEvnet)]) {
        [_delegate didTouchManageEvnet];
        [self.revealContainer clickBlackLayer];
    }
}

- (IBAction)touchDocEvent:(id)sender {
    _docViewController.commomCode = @"SYSEMPL";
    [self.navigationController pushViewController:_docViewController animated:YES];
}

- (IBAction)touchAreaEvent:(id)sender {
    [self.navigationController pushViewController:_areaViewController animated:YES];
}

- (IBAction)touchClearEvent:(id)sender{
    _generalDic = nil;
    _areaDic = nil;
    _docDic = nil;
    _searchField.text = @"";
    _orderLabel.text = @"";
    [_startButton setTitle:@"" forState:UIControlStateNormal];
    [_endButton setTitle:@"" forState:UIControlStateNormal];
    [_docButton setTitle:@"" forState:UIControlStateNormal];
    [_areaButton setTitle:@"" forState:UIControlStateNormal];
    
}

- (IBAction)touchSureEvent:(id)sender{
    //_fileResultViewController.searchDic = [self fileParams];
    //[self.navigationController pushViewController:_fileResultViewController animated:YES];
    if ([_delegate respondsToSelector:@selector(fileRightViewController:searchDic:)]) {
        
        if ([_areaButton.titleLabel.text isEqualToString:@"当前文件夹"]) {
            
        }
        else{
            if (![_searchField hasText]) {
                [self showHUDWithTextOnly:@"请填写文档名称"];
                return;
            }
        }
        
        
        [_delegate fileRightViewController:self searchDic:[self fileParams]];
        [self.revealContainer clickBlackLayer];
    }
    
    if ([_delegate respondsToSelector:@selector(fileRightView:name:)]) {
        [_delegate fileRightView:_searchField.text name:_docButton.titleLabel.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
