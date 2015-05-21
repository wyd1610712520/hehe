//
//  CommentEditViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-27.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CommentEditViewController.h"

#import "HttpClient.h"

#import "UploadCell.h"

#import "MeidaViewController.h"

#import "AlertView.h"

#import "DocumentViewController.h"

@interface CommentEditViewController ()<UITableViewDataSource,AlertViewDelegate,MeidaViewControllerDelegate,UploadCellDelegate,UITableViewDelegate,UITextViewDelegate,UIAlertViewDelegate,RequestManagerDelegate>{
    HttpClient *_httpClient;
    
    
    AlertView *_alertView;
    
    NSData *_curData;
    NSString *_curType;
    NSMutableArray *_fileDatas;
    
    NSMutableString *_fileList;
    
    DocumentViewController *documentViewController;
    
    BOOL _isUnDone;
}

@end

@implementation CommentEditViewController

@synthesize caseID = _caseID;
@synthesize ywcpID = _ywcpID;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"进程回复" color:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardDidHideNotification object:nil];

    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    
    UINib *nib = [UINib nibWithNibName:@"UploadCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"UploadCell"];
    
    _fileDatas = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiceFileList:) name:@"filelist" object:nil];
    
    _fileList = [[NSMutableString alloc] initWithFormat:@""];
    
}

- (void)receiceFileList:(NSNotification*)notification{
    NSString *str = (NSString*)[notification object];
    [_fileList appendFormat:@"%@,",str];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fileDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UploadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UploadCell"];
    NSDictionary *dic = (NSDictionary*)[_fileDatas objectAtIndex:indexPath.row];
    cell.titelLabel.text = [dic objectForKey:@"name"];
    NSData *data = (NSData*)[dic objectForKey:@"data"];
    cell.sizeLabel.text = [NSString stringWithFormat:@"%.2fM",data.length/1024.0/1024.0];
    cell.uploadtype = UploadtypeProcess;
    
    if (cell.uploadStatus == UploadDone) {
        [cell.button setBackgroundImage:[UIImage imageNamed:@"download_done_logo.png"] forState:UIControlStateNormal];
        [cell.button setTitle:@"" forState:UIControlStateNormal];
        cell.button.enabled = NO;
    }
    else if (cell.uploadStatus == Uploading){
        _isUnDone = YES;
 
    }
    else{
        [cell.button setBackgroundImage:[UIImage imageNamed:@"upload_btn.png"] forState:UIControlStateNormal];
        [cell.button setTitle:@"上传" forState:UIControlStateNormal];
        cell.button.enabled = YES;
        _isUnDone = YES;
    }

    
    
    cell.delegate = self;
    [cell setProcessUploadFile:data type:[dic objectForKey:@"type"] caseID:_caseID title:[dic objectForKey:@"name"] ywcpID:@"" category:@"1"];
    cell.logoImageView.image = [self.view checkResourceType:[dic objectForKey:@"type"]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    UploadCell *cell = (UploadCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    if (cell.button.enabled && !cell.button.selected) {
        [_fileDatas removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
    
    if (!cell.button.enabled || cell.button.selected) {
        [self showHUDWithTextOnly:@"已上传文件不能删除"];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = (NSDictionary*)[_fileDatas objectAtIndex:indexPath.row];
    
    documentViewController = [[DocumentViewController alloc] init];
    documentViewController.data = [dic objectForKey:@"data"];
    documentViewController.type = [dic objectForKey:@"type"];
    documentViewController.documentType = DocumentTypeLocal;
    documentViewController.name = [dic objectForKey:@"name"];
    [self.navigationController pushViewController:documentViewController animated:YES];
    
}


- (IBAction)touchAttachEvent:(id)sender {
    MeidaViewController *_meidaViewController = [[MeidaViewController alloc] init];
    _meidaViewController.delegate = self;

    _meidaViewController.view.frame = self.navigationController.view.bounds;
    [self.navigationController.view addSubview:_meidaViewController.view];
}

- (IBAction)touchSureEvent:(id)sender {
    if (![_textView hasText]) {
        [self showHUDWithTextOnly:@"进程回复内容不能为空"];
        return;
    }
    
    [_httpClient startRequest:[self commentParam]];
//    if (_isUnDone) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"存在未上传的附件,是否忽略" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
//        alertView.delegate = self;
//        [alertView show];
//    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [_httpClient startRequest:[self commentParam]];
    }
}

- (NSDictionary*)commentParam{
    NSString *content = @"";
    if ([_textView hasText] && _textView.text.length > 0) {
        content = _textView.text;
    }
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_caseID,@"caseID",_ywcpID,@"ywcpID",_fileList,@"cpr_files",content,@"cpr_detail", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"caseprocssitemreply",@"requestKey", nil];
    return param;
}



#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
        [self showHUDWithTextOnly:@"回复成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendCompelte" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else{
        [self showHUDWithTextOnly:@"回复失败"];
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
            layout.constant = 0;
        }
        
    }
}

- (void)meidaViewController:(MeidaViewController*)meidaViewController fileData:(NSData*)fileData type:(NSString *)type{
    _curData = fileData;
    _curType = type;
    
    
    
    _alertView = [[AlertView alloc] initWithFrame:CGRectMake(15, 120, self.view.frame.size.width- 30, 125)];
    [meidaViewController.view addSubview:_alertView];
    _alertView.delegate = self;
    [_alertView setAlertButtonType:AlertButtonOne];
    [_alertView showField:[self.view getCurrentDate]];
    [_alertView.tipLabel setText:@"重命名文件"];
    [meidaViewController.view bringSubviewToFront:_alertView];
    
    
}

- (void)alertView:(AlertView*)AlertView field:(NSString*)text{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_curData,@"data",text,@"name",_curType,@"type", nil];
    self.navigationController.navigationBarHidden = NO;
    
    [_fileDatas addObject:dic];
    
    
    NSInteger num = _fileDatas.count;
    for (NSLayoutConstraint *layout in _tableView.constraints) {
        if (layout.firstAttribute == NSLayoutAttributeHeight) {
            layout.constant = num*55;
        }
    }
    for (NSLayoutConstraint *layout in _contentView.constraints) {
        if (layout.firstAttribute == NSLayoutAttributeHeight && layout.firstItem == _contentView) {
            layout.constant = num*55+600;
        }
    }
    
    [_tableView reloadData];
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
    NSInteger max = 500;
    if (textView.text.length >= max)
    {
        textView.text = [textView.text substringToIndex:max];
    }
    NSInteger number = [textView.text length];
    _numLabel.text = [NSString stringWithFormat:@"您还可以输入%ld个字",max-number];
}

@end
