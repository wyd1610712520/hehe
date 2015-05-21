//
//  ModuleSearchViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-23.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ModuleSearchViewController.h"

#import "GeneralViewController.h"
#import "DateViewController.h"
#import "ProcessSelectedViewController.h"
@interface ModuleSearchViewController ()<UITextFieldDelegate,DateViewControllerDelegate,GeneralViewControllerDelegate>{
    DateViewController *_startPicker;
    DateViewController *_endPicker;
    
    NSDictionary *_creatorDic;
    NSDictionary *_categoryDic;
    
    GeneralViewController *_creatorViewController;
    GeneralViewController *_categoryViewController;
    
    NSArray *_categoryDatas;
    
    NSString *_fisrID;
    NSString *_fisrName;
    
    NSString *_secID;
    NSString *_secName;
}

@end

@implementation ModuleSearchViewController

- (id)init{
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ModuleList" ofType:@"plist"];
        _categoryDatas = [[NSArray alloc] initWithContentsOfFile:plistPath];
        
    }
    return self;
}

- (void)popSelf{
    [super popSelf];
    [[NSNotificationCenter defaultCenter] postNotificationName:ModuleBack object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"进程模板搜索" color:nil];
    
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.dateformatter = @"yyyy-MM-dd";
    
    _endPicker = [[DateViewController alloc] init];
    _endPicker.delegate = self;
    _endPicker.dateformatter = @"yyyy-MM-dd";

    _fisrID = @"";
    _secID = @"";
    _secName= @"";
    
    _creatorViewController = [[GeneralViewController alloc] init];
    _creatorViewController.delegate = self;
    
    _categoryViewController = [[GeneralViewController alloc] init];
    _categoryViewController.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesData:) name:@"muban" object:nil];
}

- (void)receivesData:(NSNotification*)noti{
    NSDictionary *dic = (NSDictionary*)[noti object];
    _fisrID = [dic objectForKey:@"first"];
    _secID = [dic objectForKey:@"secondId"];
    _secName = [dic objectForKey:@"secondName"];
    _fisrName = [dic objectForKey:@"_fisrname"];
    
    if (_secName.length == 0) {
        [_categoryButton setTitle:_fisrName forState:UIControlStateNormal];
    }
    else{
            [_categoryButton setTitle:_secName forState:UIControlStateNormal];
    }
    
    [_categoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}



- (IBAction)touchCategoryEvent:(id)sender {
   // _categoryViewController.commomCode = @"CACT";
//    _categoryViewController.datas = _categoryDatas;
//    [self.navigationController pushViewController:_categoryViewController animated:YES];
    
    ProcessSelectedViewController *processSelectedViewController = [[ProcessSelectedViewController alloc] init];
    processSelectedViewController.processSelect = ProcessSelectModule;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:processSelectedViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)touchCreatorEvent:(id)sender {
    _creatorViewController.commomCode = @"SYSEMPL";
    [self.navigationController pushViewController:_creatorViewController animated:YES];
}

- (IBAction)touchTimeEvent:(UIButton *)sender {
    NSInteger tag = sender.tag;
    if (tag == 0) {
        CGRect frame = _startPicker.view.frame;
        frame.origin.x = 0;
        frame.size.width = self.view.frame.size.width - frame.origin.x;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        _startPicker.view.frame = frame;
        [self.view addSubview:_startPicker.view];
    }
    else if (tag == 1){
        CGRect frame = _endPicker.view.frame;
        frame.origin.x = 0;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        frame.size.width = self.view.frame.size.width - frame.origin.x;
        _endPicker.view.frame = frame;
        [self.view addSubview:_endPicker.view];
    }

}

- (IBAction)touchClearEvent:(id)sender{
    [_startTimeButton setTitle:@"" forState:UIControlStateNormal];
    [_endTimeButton setTitle:@"" forState:UIControlStateNormal];
    
    _nameField.text = @"";
    [_categoryButton setTitle:@"请选择模板分类" forState:UIControlStateNormal];
    [_creatorButton setTitle:@"请选择模板创建人" forState:UIControlStateNormal];
    
    [_categoryButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [_creatorButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    
    _fisrID = @"";
    _secID =@"";
    _secName = @"";
    
    _startTimeButton.titleLabel.text = @"";
    _endTimeButton.titleLabel.text = @"";
    
    _categoryDic = nil;
    _creatorDic = nil;
}

- (IBAction)touchSureEvent:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
    NSString *name = @"";
    if ([_nameField hasText]) {
        name = _nameField.text;
    }
    
    NSString *creator = @"";
    if (_creatorDic.count > 0) {
        creator = [_creatorDic objectForKey:@"gc_name"];
    }
    
    if ([_delegate respondsToSelector:@selector(returnModuleSearch:creator:)]) {
        [_delegate returnModuleSearch:name creator:creator];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:ModuleSearch object:[self requestParam:@""]];
}

- (NSDictionary*)requestParam:(NSString*)cptc_category{
    NSString *name = @"";
    if ([_nameField hasText]) {
        name = _nameField.text;
    }
    
    NSString *category = @"";
    if (_categoryDic.count > 0) {
        category = [_categoryDic objectForKey:@"gc_id"];
    }
    
    NSString *creator = @"";
    if (_creatorDic.count > 0) {
        creator = [_creatorDic objectForKey:@"gc_id"];
    }
    
    NSString *start = @"";
    if (_startTimeButton.titleLabel.text > 0) {
        start = _startTimeButton.titleLabel.text;
    }
    
    NSString *end = @"";
    if (_endTimeButton.titleLabel.text > 0) {
        end = _endTimeButton.titleLabel.text;
    }
    


    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_fisrID,@"cptc_type",
                            _secID,@"cptc_category",
                            name,@"cptc_description",
                            creator,@"cptc_creator",
                            start,@"cptc_create_date_s",
                            end,@"cptc_create_date_e", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"3000",@"pageSize",@"1",@"currentPage",@"processtmpllist",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    if (dateViewController == _startPicker) {
        [_startTimeButton setTitle:date forState:UIControlStateNormal];
        [_startTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (dateViewController == _endPicker){
        [_endTimeButton setTitle:date forState:UIControlStateNormal];
        [_endTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    if (generalViewController == _categoryViewController) {
        _categoryDic = data;
        [_categoryButton setTitle:[_categoryDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_categoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _creatorViewController){
        _creatorDic = data;
        [_creatorButton setTitle:[_creatorDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_creatorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
