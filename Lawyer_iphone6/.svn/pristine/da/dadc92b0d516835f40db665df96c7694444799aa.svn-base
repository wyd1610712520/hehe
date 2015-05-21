//
//  ClientContactAddViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ClientContactAddViewController.h"

#import "HttpClient.h"


#import "GeneralViewController.h"

#import "NSString+Utility.h"

@interface ClientContactAddViewController ()<UITextViewDelegate,UITextFieldDelegate,GeneralViewControllerDelegate,RequestManagerDelegate>{
    HttpClient *_httpClient;
    
    HttpClient *_deleteHttpClient;
    
    NSDictionary *_relateDic;
    GeneralViewController *_relateViewController;
    
    CGFloat _curY;
    
    NSNotification *_notification;
}

@end

@implementation ClientContactAddViewController

@synthesize clientAddState = _clientAddState;

@synthesize clientID = _clientID;
@synthesize ccri_line = _ccri_line;

@synthesize nameField = _nameField;
@synthesize relateButton = _relateButton;
@synthesize linkerField = _linkerField;
@synthesize zongjiField = _zongjiField;
@synthesize addressField = _addressField;
@synthesize faxField = _faxField;
@synthesize emailField = _emailField;
@synthesize textView = _textView;

@synthesize numLabel = _numLabel;


@synthesize contentView = _contentView;
@synthesize scrollView = _scrollView;
@synthesize sureView = _sureView;

@synthesize record = _record;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_clientAddState == ClientAddStateNormal) {
                [self setTitle:@"添加关联客户" color:nil];
        
    }
    else if (_clientAddState == ClientAddStateEdit){
        [self setTitle:@"编辑关联客户" color:nil];
        
        [self setRightButton:[UIImage imageNamed:@"delete_btn.png"] title:nil target:self action:@selector(touchDelete)];
    }

    
    if ([_relateButton.titleLabel.text isEqualToString:@"请选择"]) {
        [_relateButton setTitleColor:[@"#A6A8AB" colorValue] forState:UIControlStateNormal];
    }
    else{
        [_relateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}


- (void)touchDelete{
    NSString *ccri_type = @"";
    ccri_type =[_record objectForKey:@"ccri_type"];
    
    
    if ([[_relateDic objectForKey:@"gc_id"] length] > 0 ) {
        ccri_type = [_relateDic objectForKey:@"gc_id"];
    }
    
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_clientID,@"ccri_client_id",
                            _nameField.text,@"ccri_name",
                            ccri_type,@"ccri_type",
                            _linkerField.text,@"ccri_linker",
                            _zongjiField.text,@"ccri_phone",
                            _faxField.text,@"ccri_fax",
                            _emailField.text,@"ccri_email",
                            _addressField.text,@"ccri_addr",
                            _textView.text,@"ccri_memo",
                            ccri_type,@"ccri_line",
                            @"X",@"ccri_status",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"clientRelationregister",@"requestKey",fields,@"fields", nil];
    
    _deleteHttpClient = [[HttpClient alloc] init];
    _deleteHttpClient.delegate = self;
    [_deleteHttpClient startRequest:param];

}


- (IBAction)touchRelateEvent:(id)sender{
    _relateViewController.commomCode = @"CLRL";
    [self.navigationController pushViewController:_relateViewController animated:YES];

}

- (NSDictionary*)requestParam:(NSString*)clientId ccri_line:(NSString*)ccri_line{
    
    NSString *ccri_type = @"";
    ccri_type =[_record objectForKey:@"ccri_type"];
    
    
    if ([[_relateDic objectForKey:@"gc_id"] length] > 0 ) {
        ccri_type = [_relateDic objectForKey:@"gc_id"];
    }
    
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:clientId,@"ccri_client_id",
                            _nameField.text,@"ccri_name",
                            ccri_type,@"ccri_type",
                            _linkerField.text,@"ccri_linker",
                            _zongjiField.text,@"ccri_phone",
                            _faxField.text,@"ccri_fax",
                            _emailField.text,@"ccri_email",
                            _addressField.text,@"ccri_addr",
                            _textView.text,@"ccri_memo",
                            ccri_line,@"ccri_line",
                            @"A",@"ccri_status",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"clientRelationregister",@"requestKey",fields,@"fields", nil];
    return param;
}


- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    _relateDic = data;
    if ([[_relateDic objectForKey:@"gc_name"] isEqualToString:@"空"]) {
        [_relateButton setTitle:@"请选择" forState:UIControlStateNormal];
    }
    else{
        [_relateButton setTitle:[_relateDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
    }
    
    

}


- (void)touchDeleteEvent{
    
}

- (IBAction)touchSureEvent:(id)sender{
    if (_nameField.text.length == 0 ) {
        [self showHUDWithTextOnly:@"请填写名称"];
        return;
    }
    
    if (_record) {
        if ([[_record objectForKey:@"ccri_type_name"] length] == 0) {
            [self showHUDWithTextOnly:@"请选择关系"];
            return;
        }
    }
    else{
        if ([[_relateDic objectForKey:@"gc_id"] length] == 0) {
            [self showHUDWithTextOnly:@"请选择关系"];
            return;
        }
    }
    
    
    
    if (_clientAddState == ClientAddStateNormal) {
        [_httpClient startRequest:[self requestParam:_clientID ccri_line:@""]];
    }
    else if (_clientAddState == ClientAddStateEdit){
        [_httpClient startRequest:[self requestParam:_clientID ccri_line:_ccri_line]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _relateViewController = [[GeneralViewController alloc] init];
    _relateViewController.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardDidHideNotification object:nil];
    
    [_relateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (_clientAddState == ClientAddStateEdit){
      
        _nameField.text = [_record objectForKey:@"ccri_name"];
        _linkerField.text = [_record objectForKey:@"ccri_linker"];
        _zongjiField.text = [_record objectForKey:@"ccri_phone"];
        _addressField.text = [_record objectForKey:@"ccri_address"];
        _emailField.text = [_record objectForKey:@"ccri_email"];
        _faxField.text = [_record objectForKey:@"ccri_fax"];
        _textView.text = [_record objectForKey:@"ccri_memo"];
        
        [_relateButton setTitle:[_record objectForKey:@"ccri_type_name"] forState:UIControlStateNormal];
        
    }
    
    _textView.placeholder = @"请填写备注";
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

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
    else if (request == _httpClient){
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



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self keyboarShow:_notification];
    return YES;
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
    
}

-(void)keyBoardHide
{
   
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _sureView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = 5;
        }
        
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView{
    NSInteger max = 100;
    
    
    
    if (textView.text.length >= max)
    {
        textView.text = [textView.text substringToIndex:max];
    }
    NSInteger number = [textView.text length];
    _numLabel.text = [NSString stringWithFormat:@"您还可以输入%ld个字",max-number];

}

@end
