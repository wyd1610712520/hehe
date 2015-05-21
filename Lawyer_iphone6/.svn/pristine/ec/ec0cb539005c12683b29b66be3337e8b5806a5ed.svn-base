//
//  ClientIncreaseViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-9-30.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ClientIncreaseViewController.h"

#import "HttpClient.h"

#import "GeneralViewController.h"

@interface ClientIncreaseViewController ()<UITextFieldDelegate,RequestManagerDelegate,GeneralViewControllerDelegate>{
    HttpClient *_httpClient;
    
    GeneralViewController *_classViewController;
    GeneralViewController *_officeViewController;
    GeneralViewController *_clientTypeViewController;
    GeneralViewController *_industryViewController;
    GeneralViewController *_areaViewController;
    
    NSString *_import;
    NSString *_clientType;
    NSString *_area;
    NSString *_hangye;
    NSString *_guojia;
}

@end

@implementation ClientIncreaseViewController

@synthesize scrollView = _scrollView;

@synthesize clientIncreaseType = _clientIncreaseType;
@synthesize record = _record;

@synthesize clientNameCHField = _clientNameCHField;
@synthesize clientNameEnField = _clientNameEnField;
@synthesize classButton = _classButton;
@synthesize areaButton = _areaButton;
@synthesize clientTypeButton = _clientTypeButton;
@synthesize clientIndustryButton = _clientIndustryButton;
@synthesize addressButton = _addressButton;
@synthesize addressField = _addressField;
@synthesize codeField = _codeField;
@synthesize sureButton = _sureButton;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    if (_clientIncreaseType == ClientIncreaseTypeNormal) {
        [self setTitle:@"添加客户" color:nil];
       
    }
    else if (_clientIncreaseType == ClientIncreaseTypeEdit){
        [self setTitle:@"编辑客户基本信息" color:nil];
        [self setDismissButton];
//        [self setRightButton:[UIImage imageNamed:@"delete_btn.png"] title:nil target:self action:@selector(touchDeleteEvent)];
//        
        
    }
    self.navigationController.navigationBar.translucent = NO;
}

- (void)touchDeleteEvent{
    
}

- (IBAction)touchSureEvent:(UIButton*)sender{
    if (![_clientNameCHField hasText]) {
        [self showHUDWithTextOnly:@"请填写客户名称"];
        return;
    }
    
    
    
    
    if (_clientIncreaseType == ClientIncreaseTypeNormal) {
        if (_area.length == 0) {
            [self showHUDWithTextOnly:@"请填写隶属办公室"];
            return;
        }
        
        if (_clientType.length == 0) {
            [self showHUDWithTextOnly:@"请填写客户类型"];
            return;
        }
        
        if (_guojia.length == 0) {
            [self showHUDWithTextOnly:@"请填写所在地区"];
            return;
        }

        [_httpClient startRequest:[self params:@""]];
    }
    else if (_clientIncreaseType == ClientIncreaseTypeEdit){
        if (_area.length ==0 && [[_record objectForKey:@"cl_area"] length] == 0) {
            [self showHUDWithTextOnly:@"请填写隶属办公室"];
            return;
        }
        if (_clientType.length == 0 && [[_record objectForKey:@"cl_type_id"] length] == 0) {
            [self showHUDWithTextOnly:@"请填写客户类型"];
            return;
        }
        
        if (_guojia.length == 0 && [[_record objectForKey:@"cl_guojia_id"] length] == 0) {
            [self showHUDWithTextOnly:@"请填写所在地区"];
            return;
        }

        [_httpClient startRequest:[self params:[_record objectForKey:@"cl_client_id"]]];
    }
    
}

- (NSDictionary*)params:(NSString*)clientID{
    if ([_import length] == 0 && [[_record objectForKey:@"cl_import_client_id"] length] > 0) {
        _import = [_record objectForKey:@"cl_import_client_id"];
    }
    
    
    
    if ([_area length] == 0 && [[_record objectForKey:@"cl_area_id"] length] > 0) {
        _area = [_record objectForKey:@"cl_area_id"];
    }

    if ([_clientType length]== 0 && [[_record objectForKey:@"cl_type_id"] length] > 0) {
        _clientType = [_record objectForKey:@"cl_type_id"];
    }

    
    if ([_hangye length] == 0 && [[_record objectForKey:@"cl_industry_id"] length]>0) {
        _hangye = [_record objectForKey:@"cl_industry_id"];
    }

    
    if ([_guojia length]== 0 && [[_record objectForKey:@"cl_guojia_id"] length] > 0) {
        _guojia = [_record objectForKey:@"cl_guojia_id"];
    }

    NSString *eName = @"";
    if ([_clientNameEnField hasText]) {
        eName = _clientNameEnField.text;
    }
    
    NSString *cName = @"";
    if ([_clientNameCHField hasText]) {
        cName = _clientNameCHField.text;
    }
    
    NSString *address = @"";
    if ([_addressField hasText]) {
        address = _addressField.text;
    }
    
    NSString *code = @"";
    if ([_codeField hasText]) {
        code = _codeField.text;
    }
    
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:clientID,@"cl_client_id",
                            cName,@"cl_client_name",
                            _import,@"cl_import_client",
                            eName,@"cl_english_name",
                            _area,@"cl_area",
                            _clientType,@"cl_type",
                            _hangye,@"cl_hangye",
                            _guojia,@"cl_guojia",
                            address,@"cl_address",
                            code,@"cl_post_code",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"clientregister",@"requestKey",fields,@"fields",nil];
    return param;
}

- (IBAction)touchGeneralEvent:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if (tag == 0) {
        _classViewController.commomCode = @"CLIMP";
        [self.navigationController pushViewController:_classViewController animated:YES];
    }
    else if (tag == 1){
        _officeViewController.commomCode = @"AE";
        [self.navigationController pushViewController:_officeViewController animated:YES];
    }
    else if (tag == 2){
        _clientTypeViewController.commomCode = @"CLKL";
        [self.navigationController pushViewController:_clientTypeViewController animated:YES];
    }
    else if (tag == 3){
        _industryViewController.commomCode = @"CLIDT";
        [self.navigationController pushViewController:_industryViewController animated:YES];
    }
    else if (tag == 4){
        _areaViewController.commomCode = @"CLCNT";
        [self.navigationController pushViewController:_areaViewController animated:YES];
    }
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    
    _classViewController = [[GeneralViewController alloc] init];
    _classViewController.delegate = self;
    
    _officeViewController = [[GeneralViewController alloc] init];
    _officeViewController.delegate = self;
    
    _clientTypeViewController = [[GeneralViewController alloc] init];
    _clientTypeViewController.delegate = self;
    
    _industryViewController = [[GeneralViewController alloc] init];
    _industryViewController.delegate = self;
    
    _areaViewController = [[GeneralViewController alloc] init];
    _areaViewController.delegate = self;
    
    _import = @"";
    _area = @"";
    _clientType = @"";
    _hangye = @"";
    _guojia = @"";
    
    if (_record) {
        [_clientNameCHField setText:[_record objectForKey:@"cl_client_name"]];
        [_clientNameEnField setText:[_record objectForKey:@"cl_english_name"]];
        [_classButton setTitle:[_record objectForKey:@"cl_import_client"] forState:UIControlStateNormal];
        [_areaButton setTitle:[_record objectForKey:@"cl_area"] forState:UIControlStateNormal];
        [_clientTypeButton setTitle:[_record objectForKey:@"cl_type"] forState:UIControlStateNormal];
        [_clientIndustryButton setTitle:[_record objectForKey:@"cl_industry"] forState:UIControlStateNormal];
        [_addressButton setTitle:[_record objectForKey:@"cl_guojia"] forState:UIControlStateNormal];
        
        _addressField.text = [_record objectForKey:@"cl_address"];
        _codeField.text = [_record objectForKey:@"cl_post_code"];
        
        
        [_classButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_areaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clientTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clientIndustryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
}

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    NSDictionary *dic = data;
    NSString *title = (NSString*)[dic objectForKey:@"gc_name"];
    if (generalViewController == _classViewController) {
        _import = [dic objectForKey:@"gc_id"];
        [_classButton setTitle:title  forState:UIControlStateNormal];
        [_classButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _officeViewController){
        _area = [dic objectForKey:@"gc_id"];
        [_areaButton setTitle:title forState:UIControlStateNormal];
        [_areaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _clientTypeViewController){
        _clientType = [dic objectForKey:@"gc_id"];
        [_clientTypeButton setTitle:title forState:UIControlStateNormal];
        [_clientTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _industryViewController){
        _hangye = [dic objectForKey:@"gc_id"];
        [_clientIndustryButton setTitle:title forState:UIControlStateNormal];
        [_clientIndustryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _areaViewController){
        _guojia = [dic objectForKey:@"gc_id"];
        [_addressButton setTitle:title forState:UIControlStateNormal];
        [_addressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _addressField) {
        [_scrollView setContentOffset:CGPointMake(0, _addressField.frame.origin.y) animated:YES];
    }
    else if (textField == _codeField){
        [_scrollView setContentOffset:CGPointMake(0, _addressField.frame.origin.y) animated:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _addressField) {
        [_addressButton resignFirstResponder];
    }
    else if (textField == _codeField){
        [_codeField resignFirstResponder];
//        CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
//        [self.scrollView setContentOffset:bottomOffset animated:YES];
    }
    else if (textField == _clientNameCHField){
        [_clientNameCHField resignFirstResponder];
    }
    else if (textField == _clientNameEnField){
        [_clientNameEnField resignFirstResponder];
    }
    return YES;
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
        [self showHUDWithTextOnly:@"请等待管理员审核"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receivesUserUpda" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self showHUDWithTextOnly:@"保存失败"];
    }
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}


@end
