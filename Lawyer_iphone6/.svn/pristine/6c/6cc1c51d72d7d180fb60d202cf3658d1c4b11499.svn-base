//
//  ClientContactNewViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ClientContactNewViewController.h"

#import "HttpClient.h"

@interface ClientContactNewViewController ()<UITextViewDelegate,UITextFieldDelegate,RequestManagerDelegate>{
    HttpClient *_httpClient;
    HttpClient *_deleteHttpClient;
    
    CGFloat _curY;
    
    NSNotification *_notification;
    
}

@end

@implementation ClientContactNewViewController



@synthesize clientContactState = _clientContactState;

@synthesize contentView = _contentView;

@synthesize scrollView = _scrollView;
@synthesize sureButton = _sureButton;

@synthesize nameField = _nameField;
@synthesize dutyField = _dutyField;
@synthesize mobileField = _mobileField;
@synthesize phoneField = _phoneField;
@synthesize chuanzhenField = _chuanzhenField;
@synthesize emailField = _emailField;

@synthesize textView = _textView;

@synthesize sureView = _sureView;
@synthesize numLabel = _numLabel;

@synthesize clientId = _clientId;
@synthesize clr_line = _clr_line;

@synthesize record = _record;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    
    if (_clientContactState == ClientContactStateNormal) {
        [self setTitle:@"添加联系人" color:nil];
        
    }
    else if (_clientContactState == ClientContactStateEdit){
        [self setTitle:@"编辑联系人信息" color:nil];
        
        [self setRightButton:[UIImage imageNamed:@"delete_btn.png"] title:nil target:self action:@selector(touchDelete)];
        
        
        _nameField.text = [_record objectForKey:@"clr_linker"];
        _dutyField.text = [_record objectForKey:@"clr_duty"];
        _mobileField.text = [_record objectForKey:@"clr_phone"];
        _phoneField.text = [_record objectForKey:@"clr_combined"];
        _emailField.text = [_record objectForKey:@"clr_email"];
        _textView.text = [_record objectForKey:@"clr_memo"];
        _chuanzhenField.text= [_record objectForKey:@"clr_fax"];
    }
}

- (void)touchDelete{
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_clientId,@"clr_client_id",
                            _nameField.text,@"clr_name",
                            _dutyField.text,@"clr_duty",
                            _mobileField.text,@"clr_telephone",
                            _phoneField.text,@"clr_phone",
                            _chuanzhenField.text,@"clr_fax",
                            _emailField.text,@"clr_email",
                            _textView.text,@"clr_memo",
                            _clr_line,@"clr_line",
                            @"X",@"clr_status",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"clientlinkerregister",@"requestKey",fields,@"fields", nil];
    
    _deleteHttpClient = [[HttpClient alloc] init];
    _deleteHttpClient.delegate = self;
    [_deleteHttpClient startRequest:param];
}

- (NSDictionary*)requestParam:(NSString*)clientId clr_line:(NSString*)clr_line{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:clientId,@"clr_client_id",
                            _nameField.text,@"clr_name",
                            _dutyField.text,@"clr_duty",
                            _mobileField.text,@"clr_telephone",
                            _phoneField.text,@"clr_phone",
                            _chuanzhenField.text,@"clr_fax",
                            _emailField.text,@"clr_email",
                            _textView.text,@"clr_memo",
                            clr_line,@"clr_line",
                            @"A",@"clr_status",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"clientlinkerregister",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardDidHideNotification object:nil];
    
    _textView.placeholder = @"请填写备注";
}

- (IBAction)touchSureEvent:(id)sender{
    
    if (_nameField.text.length == 0 ) {
        [self showHUDWithTextOnly:@"请填写名字"];
        return;
    }
    
    if (_clientContactState == ClientContactStateNormal) {
        [_httpClient startRequest:[self requestParam:_clientId clr_line:@""]];
        
    }
    else if (_clientContactState == ClientContactStateEdit){
        [_httpClient startRequest:[self requestParam:_clientId clr_line:_clr_line]];
    }
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




-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
       
        return NO;
    }
        return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView{
    NSInteger max = 50;
    
    
    
    if (textView.text.length >= max)
    {
        textView.text = [textView.text substringToIndex:max];
    }
    NSInteger number = [textView.text length];
    _numLabel.text = [NSString stringWithFormat:@"您还可以输入%ld个字",max-number];
    

}

-(void)keyboarShow:(NSNotification *) notif
{
    
    
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
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


@end
