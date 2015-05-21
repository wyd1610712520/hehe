//
//  DocuDetailViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "DocuDetailViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"
#import "RootViewController.h"

#import "DocumentViewController.h"

#import "AlertView.h"

@interface DocuDetailViewController ()<RequestManagerDelegate,AlertViewDelegate>{
    HttpClient *_detailHttpClient;
    HttpClient *_httpClient;
    DocumentViewController *_documentViewController;
    
    BOOL _isRead;
    
    HttpClient *_favoriteHttpClient;
    HttpClient *_cancelHttpClient;
    
    UIButton *_favoriteButton;
    
    AlertView *_alertView;
    
    NSString *_docuID;
}

@end

@implementation DocuDetailViewController

@synthesize record = _record;


- (IBAction)touchFileEvent:(id)sender {
    _isRead = YES;
    _documentViewController = [[DocumentViewController alloc] init];
    NSString *path = [_record objectForKey:@"do_title"];
    _documentViewController.name = [path stringByDeletingPathExtension];
    

    NSString *type = [path pathExtension];
    _documentViewController.type = type;
    _documentViewController.pathString = [_record objectForKey:@"do_url"];
    [self.navigationController pushViewController:_documentViewController animated:YES];
}

- (NSDictionary*)favoriteParan:(NSString*)titleID{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"document",@"collect_type",
                         @"文书",@"collect_item_type",
                         titleID,@"collect_key_id",
                         [[CommomClient sharedInstance] getAccount],@"userID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"addCollection",@"requestKey",
                           dic,@"fields",
                           nil];
    return param;
}

- (NSDictionary*)cancelFavoriteParan:(NSString*)titleID{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         titleID,@"collect_key_id",
                         [[CommomClient sharedInstance] getAccount],@"userID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"deleteCollection",@"requestKey",
                           dic,@"fields",
                           nil];
    return param;
}

- (void)touchNavRight:(UIButton*)button{
    if (button.selected) {
        [_cancelHttpClient startRequest:[self cancelFavoriteParan:_docuID]];
    }
    else{
        [_favoriteHttpClient startRequest:[self favoriteParan:_docuID]];
        
    }
}


- (IBAction)touchCaseEvent:(id)sender {
    
    
    RootViewController *_detailViewController = [[RootViewController alloc] init];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:_detailViewController animated:YES completion:nil];
    [_detailViewController showInCaseDetail];
    [_detailViewController.caseDetatilViewController setCaseId:[_record objectForKey:@"do_case_id"]];
    
}

- (IBAction)touchRejuectEvent:(id)sender {
    
    
    if (_isRead) {
        if (![_textView hasText]) {
            [self showHUDWithTextOnly:@"请输入审核意见"];
            return;
        }
        
        [_httpClient startRequest:[self auditParam:@"1"]];
    }
    else{
        [self showReadInfo];
    }
    
}

- (IBAction)touchSureEvent:(id)sender {
    if (_isRead) {
        [_httpClient startRequest:[self auditParam:@"0"]];
    }
    else{
        [self showReadInfo];
    }
    
}

- (void)showReadInfo{
    _alertView = [[AlertView alloc] initWithFrame:CGRectMake(15, 120, self.view.frame.size.width-30, 125)];
    [self.view addSubview:_alertView];
    _alertView.delegate = self;
    CGRect frame = _alertView.tipLabel.frame;
    frame.origin.y = 30;
    _alertView.tipLabel.frame = frame;
    _alertView.textField = nil;
    [_alertView setAlertButtonType:AlertButtonOne];
    [_alertView.tipLabel setText:@"请先查看文书文件!"];
    
    [self.view bringSubviewToFront:_alertView];

}

- (void)alertView:(AlertView*)AlertView field:(NSString*)text{
    
}

- (NSDictionary*)auditParam:(NSString*)type{
    NSString *momo = @"";
    if ([_textView hasText]) {
        momo = _textView.text;
    }
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:type,@"type",[_record objectForKey:@"do_doc_id"],@"paperID",momo,@"approveMemo",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"paperapprove",@"requestKey",fields,@"fields", nil];
    return param;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"文书详情" color:nil];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _detailHttpClient = [[HttpClient alloc] init];
    _detailHttpClient.delegate = self;
    [_detailHttpClient startRequest:[self detailParam]];
    
    if (_isHideButton) {
        _sureView.hidden = YES;
        _numLabel.hidden = YES;
        _textView.editable = NO;
    }
    
    NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"favorite_normal.png"],@"image",[UIImage imageNamed:@"favorite_selected.png"],@"selectedImage", nil];
    
    NSArray *images = [NSArray arrayWithObjects:fristImageDic, nil];
    _favoriteButton =[self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];

    _favoriteHttpClient = [[HttpClient alloc] init];
    _favoriteHttpClient.delegate = self;
    
    _cancelHttpClient = [[HttpClient alloc] init];
    _cancelHttpClient.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardDidHideNotification object:nil];

}

- (NSDictionary*)detailParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_papered,@"papered",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"papergetDetail",@"requestKey",fields,@"fields", nil];
    return param;
}


#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    if (request == _detailHttpClient) {
        NSDictionary *record = [result objectForKey:@"record"];
        _record = record;
        
        if ([[record objectForKey:@"do_status"] isEqualToString:@"A"]) {
            _sureView.hidden = YES;
        }
        else{
            _sureView.hidden = NO;
        }
        
        if ([[_record objectForKey:@"do_iscollect"] isEqualToString:@"1"]) {
            _favoriteButton.selected = YES;
        }
        else{
            _favoriteButton.selected = NO;
        }
        
        _docuID = [record objectForKey:@"do_doc_id"];
        
        [_fileButton setTitle:[record objectForKey:@"do_title"] forState:UIControlStateNormal];
        [_caseButton setTitle:[record objectForKey:@"do_case_name"] forState:UIControlStateNormal];
        
        [_fileButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_caseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _docField.text = [record objectForKey:@"do_category"];
        _personField.text = [record objectForKey:@"do_creator_name"];
        _dateFIeld.text = [record objectForKey:@"do_create_date"];
        
        _textView.text = [record objectForKey:@"approveMemo"];
    }
    else if (request == _httpClient){
        if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"审核成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"审核失败"];
        }
    }
    else if (request == _favoriteHttpClient){
        if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"收藏成功"];
            _favoriteButton.selected = YES;
        }
        else{
            [self showHUDWithTextOnly:@"收藏失败"];
            _favoriteButton.selected = NO;
        }
    }
    else if (request == _cancelHttpClient){
        if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"取消收藏成功"];
            _favoriteButton.selected = NO;
        }
        else{
            [self showHUDWithTextOnly:@"取消失败"];
            _favoriteButton.selected = YES;
        }
    }

    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];

}

- (void)textViewDidChange:(UITextView *)textView{
    NSInteger max = 150;
    if (textView.text.length >= max)
    {
        textView.text = [textView.text substringToIndex:max];
    }
    
    NSInteger number = [textView.text length];
    _numLabel.text = [NSString stringWithFormat:@"您还可以输入%ld个字",max-number];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        //        [_scrollView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
        return NO;
    }

    return YES;
    
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

/*
 {
 approveMemo = "";
 "do_case_id" = FG2014BJ010;
 "do_case_name" = "\U5fb7\U60524";
 "do_category" = "\U5f8b\U5e08\U5de5\U4f5c\U6587\U4ef6-\U8c03\U67e5\U62a5\U544a";
 "do_create_date" = "2015-01-22 12:56:06";
 "do_creator" = D000024;
 "do_creator_name" = "\U9093\U5929\U7136";
 "do_doc_id" = 0000005529;
 "do_iscollect" = 0;
 "do_location" = "";
 "do_status" = W;
 "do_title" = "\U8f6f\U4ef6\U5f00\U53d1\U9700\U6c42\U5206\U6790\U53c2\U8003\U6587\U6863.doc";
 "do_url" = "http://test.elinklaw.com/system/downloadfile.aspx?DownType=NEWCASE&DocumentID=0000005529";
 }
 
 
 */
@end
