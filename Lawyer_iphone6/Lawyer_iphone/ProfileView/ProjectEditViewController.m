//
//  ProjectEditViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-15.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProjectEditViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"

@interface ProjectEditViewController ()<UITextViewDelegate,RequestManagerDelegate>{
    
    HttpClient *_httpClient;
    HttpClient *_deleteHttpClient;
}

@end

@implementation ProjectEditViewController

@synthesize projectState = _projectState;

@synthesize pro_id = _pro_id;
@synthesize pro_name = _pro_name;

@synthesize textView = _textView;

@synthesize numLabel = _numLabel;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_projectState == ProjectStateAdd) {
        [self setTitle:[Utility localizedStringWithTitle:@"project_add_nav_title"] color:nil];
    }
    else if (_projectState == ProjectStateEdit) {
        [self setTitle:[Utility localizedStringWithTitle:@"project_edit_nav_title"] color:nil];
        _textView.text = _pro_name;
        
        [self setRightButton:[UIImage imageNamed:@"delete_btn.png"] title:@"" target:self action:@selector(touchDeleteEvent)];
    }

}

- (void)touchDeleteEvent{
    [_deleteHttpClient startRequest:[self deleteParam:@"projectexper" upi_id:_pro_id]];
}

- (NSDictionary*)deleteParam:(NSString*)type upi_id:(NSString*)upi_id{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:upi_id,@"upi_id",
                            type,@"upi_type",
                            [[CommomClient sharedInstance] getAccount],@"userID",
                            @"",@"user_officeID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"userpartinfodelete",@"requestKey",fields,@"fields", nil];
    return param;
}

- (IBAction)touchSureEvent:(id)sender{
    if (![_textView hasText]) {
        [self showHUDWithTextOnly:@"请填写项目"];
        return;
    }
    if (_projectState == ProjectStateAdd) {
        [_httpClient startRequest:[self param:@""]];

    }
    else if (_projectState == ProjectStateEdit) {
        [_httpClient startRequest:[self param:_pro_id]];
    }
}

- (NSDictionary*)param:(NSString*)erID{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:erID,@"epe_id",
                            _textView.text,@"epe_detail",
                            [[CommomClient sharedInstance] getAccount],@"userID",
                            [[CommomClient sharedInstance] getValueFromUserInfo:@"userOffice"],@"user_officeID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"userprojectexperiencemodify",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isSet = YES;
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _deleteHttpClient = [[HttpClient alloc] init];
    _deleteHttpClient.delegate = self;
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
    NSInteger max = 300;
    
    
    
    if (textView.text.length >= max)
    {
        textView.text = [textView.text substringToIndex:max];
    }
    NSInteger number = [textView.text length];
    _numLabel.text = [NSString stringWithFormat:@"您还可以输入%ld个字",max-number];
    
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    
    if (request == _httpClient) {
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"保存失败"];
        }

    }
    else if (request == _deleteHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"删除成功"];
            
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

@end
