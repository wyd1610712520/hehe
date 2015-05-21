//
//  ExperienceEditViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-7.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ExperienceEditViewController.h"

#import "DateViewController.h"

#import "CommomClient.h"



@interface ExperienceEditViewController ()<DateViewControllerDelegate,RequestManagerDelegate,UITextFieldDelegate>{
    DateViewController *_startPicker;
    DateViewController *_endPicker;
    
    HttpClient *_deleteHttpClient;
    
    HttpClient *_httpClient;
}

@end

@implementation ExperienceEditViewController

@synthesize experienceState = _experienceState;

@synthesize firstHintLabel;
@synthesize seconHintdLabel;
@synthesize thirdHintLabel;
@synthesize foruthHintLabel;

@synthesize fourthField = _fourthField;

@synthesize startButton = _startButton;
@synthesize endButton = _endButton;
@synthesize companyField = _companyField;
@synthesize dutyField = _dutyField;
@synthesize erdID = _erdID;

@synthesize educationMapping = _educationMapping;
@synthesize mapping = _mapping;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_experienceState == ExperienceStateAdd) {
        [self setTitle:[Utility localizedStringWithTitle:@"experience_add_nav_title"] color:nil];
        
        self.firstHintLabel.text = @"时间:";
        self.seconHintdLabel.text = @"公司:";
        self.thirdHintLabel.text = @"职务:";
        self.foruthHintLabel.text = @"描述:";
        
        _textView.hidden = NO;
        _fourthField.hidden = YES;
        _lineImageView.hidden = YES;
    }
    else if (_experienceState == ExperienceStateEdit) {
        [self setTitle:[Utility localizedStringWithTitle:@"experience_edit_nav_title"] color:nil];
        
        self.firstHintLabel.text = @"时间:";
        self.seconHintdLabel.text = @"公司:";
        self.thirdHintLabel.text = @"职务:";
        self.foruthHintLabel.text = @"描述:";
        
        [_startButton setTitle:[self getDate:[_mapping objectForKey:@"erd_start_date"] formatter:@"yyyy-MM-dd"]  forState:UIControlStateNormal];
        [_endButton setTitle:[self getDate:[_mapping objectForKey:@"erd_end_date"] formatter:@"yyyy-MM-dd"] forState:UIControlStateNormal];
        _companyField.text = [_mapping objectForKey:@"erd_place"];
        _dutyField.text = [_mapping objectForKey:@"erd_duty"];
        _textView.text = [_mapping objectForKey:@"erd_work"];
        
        _textView.hidden = NO;
        _fourthField.hidden = YES;
        _lineImageView.hidden = YES;
        
        [self setRightButton:[UIImage imageNamed:@"delete_btn.png"] title:@"" target:self action:@selector(touchDeleteEvent)];
    }
    else if (_experienceState == EducationStateAdd){
        [self setTitle:[Utility localizedStringWithTitle:@"education_add_nav_title"] color:nil];
        
        _companyField.placeholder = @"请填写学校名称";

        _dutyField.placeholder = @"请填写专业";
        _fourthField.placeholder = @"请填写学历";
        
        self.firstHintLabel.text = @"时间:";
        self.seconHintdLabel.text = @"学校:";
        self.thirdHintLabel.text = @"专业:";
        self.foruthHintLabel.text = @"学历:";
        
        _fourthField.hidden = NO;
        _textView.hidden = YES;
        _lineImageView.hidden = NO;
    }
    else if (_experienceState == EducationStateEdit){
        [self setRightButton:[UIImage imageNamed:@"delete_btn.png"] title:@"" target:self action:@selector(touchDeleteEvent)];
        _fourthField.hidden = NO;
        _textView.hidden = YES;
        _lineImageView.hidden = NO;
        self.firstHintLabel.text = @"时间:";
        self.seconHintdLabel.text = @"学校:";
        self.thirdHintLabel.text = @"专业:";
        self.foruthHintLabel.text = @"学历:";
        
        
        [self setTitle:[Utility localizedStringWithTitle:@"education_edit_nav_title"] color:nil];
        [_startButton setTitle:[self getDate:[_educationMapping objectForKey:@"eed_start_date"] formatter:@"yyyy-MM-dd"] forState:UIControlStateNormal];
        [_endButton setTitle:[self getDate:[_educationMapping objectForKey:@"eed_end_date"] formatter:@"yyyy-MM-dd"] forState:UIControlStateNormal];
        _companyField.text = [_educationMapping objectForKey:@"eed_school"];
        _dutyField.text = [_educationMapping objectForKey:@"eed_education"];
        _fourthField.text = [_educationMapping objectForKey:@"eed_level"];

    }
}

- (void)touchDeleteEvent{
    if (_experienceState == ExperienceStateEdit) {
        [_deleteHttpClient startRequest:[self deleteParam:@"workexper" upi_id:[_mapping objectForKey:@"erd_id"]]];
    }
    if (_experienceState == EducationStateEdit){
        [_deleteHttpClient startRequest:[self deleteParam:@"education" upi_id:[_educationMapping objectForKey:@"eed_id"]]];
    }
}

- (NSDictionary*)deleteParam:(NSString*)type upi_id:(NSString*)upi_id{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:upi_id,@"upi_id",
                            type,@"upi_type",
                            [[CommomClient sharedInstance] getAccount],@"userID",
                            @"",@"user_officeID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"userpartinfodelete",@"requestKey",fields,@"fields", nil];
    return param;
}

- (NSString*)getDate:(NSString*)string formatter:(NSString*)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:string];
    [dateFormatter setDateFormat:formatter];
    NSString *time = [dateFormatter stringFromDate:date];
    return time;
    
}

- (NSDictionary*)param:(NSString*)erID{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:erID,@"erd_id",
                            _startButton.titleLabel.text,@"erd_start_date",
                            _endButton.titleLabel.text,@"erd_end_date",
                            _companyField.text,@"erd_place",
                            _dutyField.text,@"erd_duty",
                            _textView.text,@"erd_work",
                            [[CommomClient sharedInstance] getAccount],@"userID",
                            [[CommomClient sharedInstance] getValueFromUserInfo:@"userOffice"],@"user_officeID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"userworkexperiencemodify",@"requestKey",fields,@"fields", nil];
    return param;
}

- (NSDictionary*)eduParam:(NSString*)erID{
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:erID,@"eed_id",
                            _startButton.titleLabel.text,@"eed_start_date",
                            _endButton.titleLabel.text,@"eed_end_date",
                            _companyField.text,@"eed_school",
                            _dutyField.text,@"eed_education",
                            _fourthField.text,@"eed_level",
                            [[CommomClient sharedInstance] getValueFromUserInfo:@"userKey"],@"userID",
                            [[CommomClient sharedInstance] getValueFromUserInfo:@"userOffice"],@"user_officeID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"usereducationmodify",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isSet = YES;
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.dateformatter = @"yyyy-MM-dd";
    
    _endPicker = [[DateViewController alloc] init];
    _endPicker.delegate = self;
    _endPicker.dateformatter = @"yyyy-MM-dd";
    
    
    _deleteHttpClient = [[HttpClient alloc] init];
    _deleteHttpClient.delegate = self;
    
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
}

- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    [_companyField resignFirstResponder];
    [_dutyField resignFirstResponder];
    [_textView resignFirstResponder];
    if (dateViewController == _startPicker) {
        [_startButton setTitle:date forState:UIControlStateNormal];
    }
    else if (dateViewController == _endPicker){
        [_endButton setTitle:date forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)touchSureEvent:(id)sender{
    if (_experienceState == ExperienceStateAdd) {
        if (_startButton.titleLabel.text.length == 0) {
            [self showHUDWithTextOnly:@"请选择开始时间"];
            return;
        }
        
        if (_endButton.titleLabel.text.length == 0) {
            [self showHUDWithTextOnly:@"请选择结束时间"];
            return;
        }
        
        if (![_companyField hasText]) {
            [self showHUDWithTextOnly:@"请填写公司名称"];
            return;
        }
        
        if (![_dutyField hasText]) {
            [self showHUDWithTextOnly:@"请填写职务"];
            return ;
        }
        
        
        if (![_textView hasText]) {
            [self showHUDWithTextOnly:@"请填写描述信息"];
            return;
        }
        

        [_httpClient startRequest:[self param:@""]];
    }
    else if (_experienceState == ExperienceStateEdit) {
        if (_startButton.titleLabel.text.length == 0) {
            [self showHUDWithTextOnly:@"请选择开始时间"];
            return;
        }
        
        if (_endButton.titleLabel.text.length == 0) {
            [self showHUDWithTextOnly:@"请选择结束时间"];
            return;
        }
        
        if (![_companyField hasText]) {
            [self showHUDWithTextOnly:@"请填写公司名称"];
            return;
        }
        
        if (![_dutyField hasText]) {
            [self showHUDWithTextOnly:@"请填写职务"];
            return ;
        }
        
        
        if (![_textView hasText]) {
            [self showHUDWithTextOnly:@"请填写描述信息"];
            return;
        }
        

        [_httpClient startRequest:[self param:[_mapping objectForKey:@"erd_id"]]];
    }
    else if (_experienceState == EducationStateAdd){
        if (_startButton.titleLabel.text.length == 0) {
            [self showHUDWithTextOnly:@"请选择开始时间"];
            return;
        }
        
        if (_endButton.titleLabel.text.length == 0) {
            [self showHUDWithTextOnly:@"请选择结束时间"];
            return;
        }
        
        if (![_companyField hasText]) {
            [self showHUDWithTextOnly:@"请选择学校"];
            return;
        }
        
        if (![_dutyField hasText]) {
            [self showHUDWithTextOnly:@"请选择专业"];
            return ;
        }
      
        
        if (![_fourthField hasText]) {
            [self showHUDWithTextOnly:@"请选择学历"];
            return;
        }
        
        [_httpClient startRequest:[self eduParam:@""]];
    }
    else if (_experienceState == EducationStateEdit){
        if (_startButton.titleLabel.text.length == 0) {
            [self showHUDWithTextOnly:@"请选择开始时间"];
            return;
        }
        
        if (_endButton.titleLabel.text.length == 0) {
            [self showHUDWithTextOnly:@"请选择结束时间"];
            return;
        }
        
        if (![_companyField hasText]) {
            [self showHUDWithTextOnly:@"请选择学校"];
            return;
        }
        
        if (![_dutyField hasText]) {
            [self showHUDWithTextOnly:@"请选择专业"];
            return ;
        }
        
        
        if (![_fourthField hasText]) {
            [self showHUDWithTextOnly:@"请选择学历"];
            return;
        }
        [_httpClient startRequest:[self eduParam:[_educationMapping objectForKey:@"eed_id"]]];
    }
}

- (IBAction)touchTimeEvent:(UIButton*)sender{
    if (sender.tag == 0) {
        CGRect frame = _startPicker.view.frame;
        frame.origin.x = 0;
        frame.origin.y = self.view.frame.size.height - _startPicker.view.frame.size.height;
        frame.size.width = self.view.frame.size.width;
        _startPicker.view.frame = frame;
        [self.view addSubview:_startPicker.view];
    }
    else if (sender.tag == 1){
        CGRect frame = _endPicker.view.frame;
        frame.origin.x = 0;
        frame.size.width = self.view.frame.size.width;
        frame.origin.y = self.view.frame.size.height - _endPicker.view.frame.size.height;
        _endPicker.view.frame = frame;
        [self.view addSubview:_endPicker.view];
    }
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

/*
 
 {
 fields =     {
 "eed_education" = "\U6492\U8c46\U6210\U5175";
 "eed_end_date" = "2015-03-23";
 "eed_id" = "";
 "eed_level" = "\U5f53\U5e74\U611f\U8c22\U4f60\U611f\U8c22\U6bcf\U4e2a\U9879\U76ee\U83b7\U6089";
 "eed_school" = "\U5531\U6b4c\U559d\U9152\U53bb";
 "eed_start_date" = "2015-03-21";
 userID = "dtr@elinklaw.com";
 "user_officeID" = 0005;
 };
 requestKey = usereducationmodify;
 }
 */

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    if (request == _deleteHttpClient) {
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"删除成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"删除失败"];
        }
    }
    else{
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"保存成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"保存失败"];
        }
    }
    
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
    
}

@end
