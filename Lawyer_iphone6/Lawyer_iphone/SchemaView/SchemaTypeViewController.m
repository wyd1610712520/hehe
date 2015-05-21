//
//  SchemaTypeViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "SchemaTypeViewController.h"

#import "HttpClient.h"

#import "GeneralViewController.h"

#import "DateViewController.h"

#import "CaseViewController.h"

#import "RootViewController.h"

#import "LogCreateViewController.h"

#import "CommomClient.h"
#import "AppDelegate.h"
#import "MapViewController.h"

#import "AlertView.h"

@interface SchemaTypeViewController ()<RequestManagerDelegate,UITextFieldDelegate,UITextViewDelegate,MapViewControllerDelegate,GeneralViewControllerDelegate,CaseViewControllerDelegate,DateViewControllerDelegate,AlertViewDelegate,UIAlertViewDelegate>{
    HttpClient *_detailHttpClient;
    HttpClient *_editHttpClient;
    HttpClient *_addHttpClient;
    AppDelegate *delegate;
    
    GeneralViewController *_generalViewController;
    GeneralViewController *_remainViewController;
    
    NSDictionary *_schemTypeDic;
    
    DateViewController *_startPicker;
    DateViewController *_endPicker;
    
    CaseViewController *_caseViewController;
    
    RootViewController *_rootViewController;
    
    BOOL isEditing;
    
    NSArray *_remainDatas;
    NSDictionary *_remainDic;
    
    AlertView *_fileAlertView;
    
    LogCreateViewController *_logCreateViewController;
    
    NSDictionary *_editData;
    
    HttpClient *_deleteHttpClient;
    
    NSDictionary *_record;
    
    MapViewController *_mapViewController;
    
    NSNotification *_notification;
    
    NSString *_privteSwitch;
    
    NSDictionary *_caseDic;
}



@end

@implementation SchemaTypeViewController

@synthesize state = _state;

@synthesize schemaType = _schemaType;

@synthesize scrollView = _scrollView;

@synthesize schemaNameField = _schemaNameField;
@synthesize caseIdField = _caseIdField;
@synthesize caseNameField = _caseNameField;
@synthesize clientIdField = _clientIdField;
@synthesize addressField = _addressField;
@synthesize clientNameField = _clientNameField;

@synthesize schemaTypeBotton = _schemaTypeBotton;
@synthesize startButton = _startButton;
@synthesize endButton = _endButton;
@synthesize remainButton = _remainButton;
@synthesize caseNameButton = _caseNameButton;

@synthesize textView = _textView;

@synthesize countLabel = _countLabel;

@synthesize delegate = _delegate;

@synthesize fifthImageView = _fifthImageView;
@synthesize firstImageView = _firstImageView;
@synthesize secondImageView = _secondImageView;
@synthesize thirdImageView = _thirdImageView;
@synthesize foruthImageView = _foruthImageView;

@synthesize schemaId = _schemaId;

@synthesize sureButton = _sureButton;

- (id)init{
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Schema_remain" ofType:@"plist"];
        _remainDatas = [[NSArray alloc] initWithContentsOfFile:plistPath];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self schematype];
    if (_schemaType == SchemaTypeEdit || _schemaType == SchemaTypeAdd) {
        _buttonSwitch.enabled = YES;
    }
    else{
        _buttonSwitch.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_deleteHttpClient cancelRequest];
}

- (NSDictionary*)deleteParam{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_schemaId,@"sc_schedule_id", nil];
    NSArray *array = [NSArray arrayWithObjects:dic, nil];
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:array,@"fields_list",@"deleteschedule",@"requestKey", nil];
    return fields;
}

- (void)touchDelete:(UIButton*)button{
    if (button.tag == 0) {
        _schemaType = SchemaTypeEdit;
        isEditing = YES;
        if (_record) {
            _schemaNameField.text = [_record objectForKey:@"sc_title"];
            [_schemaTypeBotton setTitle:[_record objectForKey:@"sc_work_typeName"] forState:UIControlStateNormal];
            [_startButton setTitle:[_record objectForKey:@"sc_start_date"] forState:UIControlStateNormal];
            [_endButton setTitle:[_record objectForKey:@"sc_end_date"] forState:UIControlStateNormal];
            
            [_caseNameButton setTitle:[_record objectForKey:@"sc_case_name"] forState:UIControlStateNormal];
            _caseIdField.text = [_record objectForKey:@"sc_client_id"];
            
            _clientNameField.text = [_record objectForKey:@"sc_client_name"];
            _clientIdField.text = [_record objectForKey:@"sc_client_id"];
            _addressField.text = [_record objectForKey:@"sc_address"];
            _textView.text = [_record objectForKey:@"sc_description"];
            
        }
        [self schematype];
    }
    else if (button.tag == 1){
        _fileAlertView = [[AlertView alloc] initWithFrame:CGRectMake(15, 120, self.view.frame.size.width-30, 125)];
        [self.view addSubview:_fileAlertView];
        _fileAlertView.delegate = self;
        [_fileAlertView setAlertButtonType:AlertButtonTwo];
        [_fileAlertView.tipLabel setText:@"是否删除"];
        _fileAlertView.textField = nil;
        [_fileAlertView.sureButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.view bringSubviewToFront:_fileAlertView];
    }
}

- (void)touchDelete{
    _fileAlertView = [[AlertView alloc] initWithFrame:CGRectMake(15, 120, self.view.frame.size.width-30, 125)];
    [self.view addSubview:_fileAlertView];
    _fileAlertView.delegate = self;
    [_fileAlertView setAlertButtonType:AlertButtonTwo];
    [_fileAlertView.tipLabel setText:@"是否删除"];
    _fileAlertView.textField = nil;
    [_fileAlertView.sureButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.view bringSubviewToFront:_fileAlertView];
}

- (void)alertView:(AlertView*)AlertView field:(NSString*)text{
    _deleteHttpClient = [[HttpClient alloc] init];
    _deleteHttpClient.delegate = self;
    
    [_deleteHttpClient startRequest:[self deleteParam]];
}


- (void)schematype{
    
    if (_schemaType == SchemaTypeAdd) {
        [self isShowArrow:NO];
        [self setTitle:[Utility localizedStringWithTitle:@"schema_nav_add_title"] color:nil];
        
        _buttonSwitch.enabled = YES;
        
    }
    else if (_schemaType == SchemaTypeEdit){
        _buttonSwitch.enabled = YES;
        [self isShowArrow:NO];
        [self setTitle:[Utility localizedStringWithTitle:@"schema_nav_edit_title"] color:nil];
        
        [self setRightButton:[UIImage imageNamed:@"delete_btn.png"] title:nil target:self action:@selector(touchDelete)];
        
        [_addressLabel setHidden:YES];
        [_addressField setHidden:NO];
        _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textView.layer.borderWidth = 0.5;
    }
    else if (_schemaType == SchemaTypeDetail) {
        _buttonSwitch.enabled = NO;
        [self isShowArrow:NO];
        [self setTitle:[Utility localizedStringWithTitle:@"schema_nav_detail_title"] color:nil];
        
        _textView.layer.borderColor = [UIColor clearColor].CGColor;
        
        
        
        if ([_state isEqualToString:@"1"]) {
            NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"blut_edit_logo.png"],@"image",nil,@"selectedImage", nil];
            NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"delete_btn.png"],@"image",nil,@"selectedImage", nil];
            NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
            [self setNavigationSegmentWithImages:images target:self action:@selector(touchDelete:)];
            
        }
        else{
            NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"schema_log_btn.png"],@"image",nil,@"selectedImage", nil];
            NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"blut_edit_logo.png"],@"image",nil,@"selectedImage", nil];
            NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
            [self setNavigationSegmentWithImages:images target:self action:@selector(touchRight:)];
        }
        
        _detailHttpClient = [[HttpClient alloc] init];
        _detailHttpClient.delegate = self;
        [_detailHttpClient startRequest:[self detailParam:_schemaId]];
        
        for (NSLayoutConstraint *layout in self.view.constraints) {
            if (layout.secondItem == _scrollView && layout.firstAttribute == NSLayoutAttributeBottom) {
                layout.constant = 0;
            }
        }
        
    }
    
    
    if (delegate.isShowInSchema) {
        _sureView.hidden = NO;
        for (NSLayoutConstraint *layout in self.view.constraints) {
            if (layout.secondItem == _scrollView && layout.firstAttribute == NSLayoutAttributeBottom) {
                layout.constant = 50;
            }
        }
    }
}

- (void)touchEdit{
    _schemaType = SchemaTypeEdit;
    isEditing = YES;
    if (_record) {
        _schemaNameField.text = [_record objectForKey:@"sc_title"];
        [_schemaTypeBotton setTitle:[_record objectForKey:@"sc_work_typeName"] forState:UIControlStateNormal];
        [_startButton setTitle:[_record objectForKey:@"sc_start_date"] forState:UIControlStateNormal];
        [_endButton setTitle:[_record objectForKey:@"sc_end_date"] forState:UIControlStateNormal];
        
        [_caseNameButton setTitle:[_record objectForKey:@"sc_case_name"] forState:UIControlStateNormal];
        _caseIdField.text = [_record objectForKey:@"sc_client_id"];
        
        _clientNameField.text = [_record objectForKey:@"sc_client_name"];
        _clientIdField.text = [_record objectForKey:@"sc_client_id"];
        _addressField.text = [_record objectForKey:@"sc_address"];
        _textView.text = [_record objectForKey:@"sc_description"];
        
        
    }
    
    [self schematype];
    

}

- (IBAction)touchRemainEvent:(UIButton*)sender{
    _remainViewController = [[GeneralViewController alloc] init];
    _remainViewController.delegate = self;
    _remainViewController.datas = _remainDatas;
    [self.navigationController pushViewController:_remainViewController animated:YES];
}

- (NSDictionary*)addParam:(NSString*)sche_id{
    NSString *schemaName = @"";
    NSString *schemaType = @"";
    NSString *startTime = @"";
    NSString *endTime = @"";
    NSString *memo = @"";
    
    if ([_schemaNameField hasText]) {
        schemaName = _schemaNameField.text;
    }
    
    if (_schemTypeDic) {
        schemaType = [_schemTypeDic objectForKey:@"gc_id"];
    }
    else{
        schemaType = (NSString*)[_record objectForKey:@"sc_work_type"];
    }
    
    if ([_startButton.titleLabel.text length] != 0) {
        startTime = _startButton.titleLabel.text;
    }
    
    if ([_endButton.titleLabel.text length] != 0) {
        endTime = _endButton.titleLabel.text;
    }
    
    if ([_textView hasText]) {
        memo = _textView.text;
    }
    
    NSString *sc_attation_days = @"";
    if (_remainDic) {
        sc_attation_days = [_remainDic objectForKey:@"value"];
    }
    else if(_record){
        NSString *time = [_record objectForKey:@"sc_attation_days"];
       
        sc_attation_days = time;
    }
    NSString *clientID = @"";
    NSString *clientName = @"";
    NSString *caseID = @"";
    NSString *caseName = @"";
    
    NSString *address = @"";
    if ([_addressField hasText]) {
        address = _addressField.text;
    }
    
    if (_caseDic) {
        clientID = _clientIdField.text;
        clientName = _clientNameField.text;
        caseID = _caseIdField.text;
        caseName = _caseNameButton.titleLabel.text;
    }
    else if(_record){
        clientID = [_record objectForKey:@"sc_client_id"];
        clientName = [_record objectForKey:@"sc_client_name"];
        caseID = [_record objectForKey:@"sc_case_id"];
        caseName = [_record objectForKey:@"sc_case_name"];
    }
   
    
    NSString *convert = @"0";
    if (_record) {
        convert = [_record objectForKey:@"sc_isConvert"];
    }
    
    NSDictionary *dicFields = [NSDictionary dictionaryWithObjectsAndKeys:
                               sche_id, @"sc_schedule_id",
                               startTime, @"sc_start_date",
                               endTime, @"sc_end_date",
                               sc_attation_days, @"sc_attation_days",
                               clientID, @"sc_client_id",
                               clientName, @"sc_client_name",
                               caseID, @"sc_case_id",
                               caseName, @"sc_case_name",
                               schemaType, @"sc_work_type",
                               address,@"sc_address",
                               schemaName, @"sc_title",
                               memo, @"sc_description",
                               convert,@"sc_isConvert",
                               _privteSwitch,@"sc_is_private",
                               nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"addSchedule", @"requestKey",
                         dicFields, @"fields",
                         nil];
    return dic;
}

- (IBAction)switchButton:(UISwitch *)sender {
    if (sender.on) {
        _privteSwitch = @"1";
    }
    else{
        _privteSwitch = @"0";
    }
}

- (IBAction)touchSureEvent:(id)sender{
    if (![_schemaNameField hasText]) {
        [self showHUDWithTextOnly:@"请填写日程名称"];
        return;
    }
    
    if ([_schemaTypeBotton.titleLabel.text length] == 0) {
        [self showHUDWithTextOnly:@"请填写日程类型"];
        return;
    }
    
    if (!_schemTypeDic) {
        if (!_record) {
            [self showHUDWithTextOnly:@"请填写日程类型"];
            return;
        }
    }
    
    if ([_startButton.titleLabel.text length] == 0) {
        [self showHUDWithTextOnly:@"请填写开始时间"];
        return;
    }
    
    if ([_endButton.titleLabel.text length] == 0) {
        [self showHUDWithTextOnly:@"请填写结束时间"];
        return;
    }
    
    if (![_textView hasText]) {
        [self showHUDWithTextOnly:@"请填写日程描述"];
        return;
    }
    
    if (_schemaType == SchemaTypeAdd) {
        [_addHttpClient startRequest:[self addParam:@""]];
    }
    else if (_schemaType == SchemaTypeEdit){
        [_editHttpClient startRequest:[self addParam:_schemaId]];
    }
    else if (_schemaType == SchemaTypeDetail){
        if (delegate.isShowInSchema) {
            
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"schemToLog" object:_record];
            delegate.isShowInSchema = NO;
            
        }
    }
}

- (void)touchRight:(UIButton*)button{
    if (button.tag == 0) {
        _logCreateViewController = [[LogCreateViewController alloc] init];
        _logCreateViewController.logType = LogTypeEdit;
        _logCreateViewController.record = _record;
        _logCreateViewController.logID = @"";
        _logCreateViewController.logSourece = LogSoureceSchema;
        [self.navigationController pushViewController:_logCreateViewController animated:YES];
    }
    else if (button.tag == 1){
        _schemaType = SchemaTypeEdit;
        isEditing = YES;
        if (_record) {
            _schemaNameField.text = [_record objectForKey:@"sc_title"];
            [_schemaTypeBotton setTitle:[_record objectForKey:@"sc_work_typeName"] forState:UIControlStateNormal];
            [_startButton setTitle:[_record objectForKey:@"sc_start_date"] forState:UIControlStateNormal];
            [_endButton setTitle:[_record objectForKey:@"sc_end_date"] forState:UIControlStateNormal];
            
            [_caseNameButton setTitle:[_record objectForKey:@"sc_case_name"] forState:UIControlStateNormal];
            _caseIdField.text = [_record objectForKey:@"sc_client_id"];
            
            _clientNameField.text = [_record objectForKey:@"sc_client_name"];
            _clientIdField.text = [_record objectForKey:@"sc_client_id"];
            _addressField.text = [_record objectForKey:@"sc_address"];
            _textView.text = [_record objectForKey:@"sc_description"];
            
            
        }
        
        [self schematype];
 
    }
    
}

- (void)isShowArrow:(BOOL)show{
    [_firstImageView setHidden:show];
    [_secondImageView setHidden:show];
    [_thirdImageView setHidden:show];
    [_foruthImageView setHidden:show];
    [_fifthImageView setHidden:show];
    [_countLabel setHidden:show];
    
    _schemaNameField.enabled = !show;
    _schemaTypeBotton.enabled = !show;
    _startButton.enabled = !show;
    _endButton.enabled = !show;
    _remainButton.enabled = !show;
    _caseNameButton.enabled = !show;
    _caseIdField.enabled = !show;
    
    _clientNameField.enabled = !show;
    _clientIdField.enabled = !show;
    _addressField.enabled = !show;
    _textView.editable = !show;
    
    if (delegate.isShowInSchema) {
        _sureView.hidden = NO;
    }
    else{
        _sureView.hidden = show;
    }
    
   // _scrollView.translatesAutoresizingMaskIntoConstraints = YES;
   // self.view.translatesAutoresizingMaskIntoConstraints = YES;
//    if (show) {
//    
//        for (NSLayoutConstraint *layout in _scrollView.constraints) {
//            
//            if (layout.firstItem == _scrollView && layout.firstAttribute == NSLayoutAttributeBottom) {
//                layout.constant = 0;
//            }
//        }
//    }
//    else{
//        for (NSLayoutConstraint *layout in _scrollView.constraints) {
//            if (layout.firstItem == _scrollView && layout.firstAttribute == NSLayoutAttributeBottom) {
//                layout.constant = 50;
//            }
//        }
//    }
    
}

- (NSDictionary*)editParam:(NSString*)schemaleId{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getAccount],@"userID",schemaleId,@"sc_schedule_id", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"updatescheduleconvert",@"requestKey",fields,@"fields", nil];
    return param;
}

- (NSDictionary*)detailParam:(NSString*)schemaleId{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getAccount],@"userID",schemaleId,@"sc_schedule_id", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"scheduleview",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _privteSwitch = @"1";
    _generalViewController = [[GeneralViewController alloc] init];
    _generalViewController.delegate = self;
    
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    _endPicker = [[DateViewController alloc] init];
    _endPicker.delegate = self;
    _endPicker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    
    _addHttpClient = [[HttpClient alloc] init];
    _addHttpClient.delegate = self;
    
    _editHttpClient = [[HttpClient alloc] init];
    _editHttpClient.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardDidHideNotification object:nil];
    delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [_startButton setTitle:_time forState:UIControlStateNormal];
    [_endButton setTitle:_time forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_endButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    [self.view bringSubviewToFront:_contentView];
//    CGRect frame = _contentView.frame;
//    frame.size.width = [UIScreen mainScreen].bounds.size.width;
//    _contentView.frame = frame;
//    for (NSLayoutConstraint *layout in _contentView.constraints) {
//        if (layout.firstAttribute == NSLayoutAttributeWidth && layout.firstItem == _contentView) {
//            
//            layout.constant = self.view.bounds.size.width;
//        }
//    }
//    
//    for (NSLayoutConstraint *layout in _scrollView.constraints) {
//        if (layout.firstAttribute == NSLayoutAttributeWidth && layout.firstItem == _scrollView) {
//            [_scrollView showBorder:[UIColor yellowColor]];
//            layout.constant = [UIScreen mainScreen].bounds.size.width;
//        }
//    }
    
}

- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    if (dateViewController == _startPicker) {
        [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startButton setTitle:date forState:UIControlStateNormal];
    }
    else if (dateViewController == _endPicker){
        [_endButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_endButton setTitle:date forState:UIControlStateNormal];
    }
}

- (IBAction)touchDateEvent:(UIButton*)sender{
    
}

- (IBAction)touchCaseEvent:(id)sender{
    _rootViewController = [[RootViewController alloc] init];
    
    [self presentViewController:_rootViewController animated:YES completion:nil];
  
    [_rootViewController showInCase];
    _rootViewController.caseViewController.caseStatuts = CaseStatutsSelectable;
    _rootViewController.caseViewController.delegate = self;
}

#pragma mark - CaseViewControllerDelegate

- (void)returnDataToProcess:(NSDictionary*)item{
    _caseDic = item;
    [_caseNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_caseNameButton setTitle:[item objectForKey:@"ca_case_name"] forState:UIControlStateNormal];
    _caseIdField.text = [item objectForKey:@"ca_case_id"];
    _clientNameField.text = [item objectForKey:@"cl_client_name"];
    [_clientIdField setText:[item objectForKey:@"cl_client_id"]];
    
    _caseIdField.textColor = [UIColor blackColor];
    _clientNameField.textColor = [UIColor blackColor];
    _clientIdField.textColor = [UIColor blackColor];
    
}

- (IBAction)touchLocationEvent:(id)sender{
    _mapViewController = [[MapViewController alloc] init];
    
    [self.navigationController pushViewController:_mapViewController animated:YES];
    
    if (_schemaType == SchemaTypeDetail) {
        _mapViewController.address = _addressField.text;
        [_mapViewController search];
    }
    else{
        _mapViewController.delegate = self;
        [_mapViewController location];
    }
    
}

- (void)returnUserLocation:(NSString *)address{
    _addressField.text = address;
}

- (IBAction)touchCommomEvent:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if (tag == 0) {
        _generalViewController.commomCode = @"GZ";
        [self.navigationController pushViewController:_generalViewController animated:YES];
    }
    else if (tag == 1){
        [_textView resignFirstResponder];
        [_addressField resignFirstResponder];
        [_schemaNameField resignFirstResponder];
        CGRect frame = _startPicker.view.frame;
        frame.origin.y = self.view.frame.size.height- frame.size.height;
        frame.size.width = self.view.frame.size.width;
        _startPicker.view.frame = frame;
        [self.view addSubview:_startPicker.view];
    }
    else if (tag == 2){
        [_textView resignFirstResponder];
        [_schemaNameField resignFirstResponder];
        [_addressField resignFirstResponder];
        
        CGRect frame = _endPicker.view.frame;
        frame.origin.y = self.view.frame.size.height- frame.size.height;
        frame.size.width = self.view.frame.size.width;
        _endPicker.view.frame = frame;
        [self.view addSubview:_endPicker.view];
    }
    else if (tag == 3){
        
    }
}




#pragma mark - GeneralViewControllerDelegate

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    
    if (generalViewController == _remainViewController) {
        _remainDic = data;
        [_remainButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_remainButton setTitle:[_remainDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
    }
    else{
        _schemTypeDic = data;
        if (_schemTypeDic) {
            [_schemaTypeBotton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_schemaTypeBotton setTitle:[_schemTypeDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        }

    }
    
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;

    
    if (request == _detailHttpClient) {
        _record = (NSDictionary*)[dic objectForKey:@"record"];
        
        
        _schemaNameField.text = [_record objectForKey:@"sc_title"];
        
        NSString *time = [_record objectForKey:@"sc_attation_days"];
        NSString *remain;
        for (NSDictionary *dic in _remainDatas) {
            if ([[dic objectForKey:@"value"] isEqualToString:time]) {
                remain = [dic objectForKey:@"gc_name"];
            }
        }
        [_remainButton setTitle:remain forState:UIControlStateNormal];
        if ([[_record objectForKey:@"sc_case_name"] length] > 0) {
            [_caseNameButton setTitle:[_record objectForKey:@"sc_case_name"] forState:UIControlStateNormal];
            
            _caseIdField.text = [_record objectForKey:@"sc_case_id"];
            
            _clientNameField.text = [_record objectForKey:@"sc_client_name"];
            _clientIdField.text = [_record objectForKey:@"sc_client_id"];
        }
        else{
            [_caseNameButton setTitle:@"无" forState:UIControlStateNormal];
            _caseIdField.text = @"无";
            
            _clientNameField.text = @"无";
            _clientIdField.text = @"无";
        }
        
        
        
        

        _textView.text = [_record objectForKey:@"sc_description"];
        
        
//        _schemaTypeBotton.titleLabel.text = listMapping.sc_work_typeName;
//        _startButton.titleLabel.text = listMapping.sc_start_date;
//        _endButton.titleLabel.text = listMapping.sc_end_date;
//        
//        _schemaTypeBotton.titleLabel.textColor = [UIColor blackColor];
//        _startButton.titleLabel.textColor = [UIColor blackColor];
//        _endButton.titleLabel.textColor = [UIColor blackColor];
        
        [_remainButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_schemaTypeBotton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_endButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_caseNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_schemaTypeBotton setTitle:[_record objectForKey:@"sc_work_typeName"] forState:UIControlStateNormal];
        [_startButton setTitle:[_record objectForKey:@"sc_start_date"] forState:UIControlStateNormal];
        [_endButton setTitle:[_record objectForKey:@"sc_end_date"] forState:UIControlStateNormal];
        
        NSString *address = [_record objectForKey:@"sc_address"];
        _addressLabel.text = address;
        
        UIFont *font = [UIFont systemFontOfSize:15];
        CGSize size = CGSizeMake(_addressLabel.frame.size.width, 1000);
        
        NSDictionary *textAttributes = @{NSFontAttributeName: font};
        
        
        CGRect labelsize = [address boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
        
        if (labelsize.size.height > 18) {
            _addressLabel.hidden = NO;
            _addressField.hidden = YES;
        }
        else{
            _addressLabel.hidden = YES;
            _addressField.hidden = NO;
            _addressField.text = address;
        }
        
        _caseIdField.textColor = [UIColor blackColor];
        _clientNameField.textColor = [UIColor blackColor];
        _clientIdField.textColor = [UIColor blackColor];
        
        if ([[_record objectForKey:@"sc_is_private"] isEqualToString:@"1"]) {
            _buttonSwitch.on = YES;
        }
        else{
            _buttonSwitch.on = NO;
        }
        
        
        [self isShowArrow:YES];
    }
    else if (request == _editHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"编辑成功"];
            if ([_delegate respondsToSelector:@selector(schemaViewRefresh:)]) {
                [_delegate schemaViewRefresh:YES];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"编辑失败"];
        }
    }
    else if (request == _addHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"添加成功"];
            if ([_delegate respondsToSelector:@selector(schemaViewRefresh:)]) {
                [_delegate schemaViewRefresh:YES];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"添加失败"];
        }
    }
    else if (request == _deleteHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"删除成功"];
            if ([_delegate respondsToSelector:@selector(schemaViewRefresh:)]) {
                [_delegate schemaViewRefresh:NO];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"删除失败"];
        }
    }
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

-(void)keyboarShow:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    _notification = notif;
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _sureView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = keyboardSize.height;
        }
        
    }
    
    for (NSLayoutConstraint *layout in _contentView.constraints) {
        if (layout.firstItem == _contentView && layout.firstAttribute == NSLayoutAttributeHeight) {
            layout.constant = 1050;
        }
    }
}

-(void)keyBoardHide
{
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _sureView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = 5;
        }
    }
    
    for (NSLayoutConstraint *layout in _contentView.constraints) {
        if (layout.firstItem == _contentView && layout.firstAttribute == NSLayoutAttributeHeight) {
            layout.constant = 1050;
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _addressField) {
         [self keyboarShow:_notification];
        return YES;
    }
    else if (textField == _schemaNameField){
       // [self keyBoardHide];
        return YES;
    }

    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    //[self keyBoardHide];
    return YES;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [self keyboarShow:_notification];
    return YES;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
       // [self keyBoardHide];
//        [_scrollView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];

        return NO;
    }
 
    
    return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView{
    NSInteger max = 500;
    
    
    
    if (textView.text.length >= max)
    {
        textView.text = [textView.text substringToIndex:max];
    }
    NSInteger number = [textView.text length];
    _countLabel.text = [NSString stringWithFormat:@"您还可以输入%ld个字",max-number];
    
}

@end
