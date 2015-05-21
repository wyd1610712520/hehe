//
//  ProcessFragmentNewViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-23.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ProcessFragmentNewViewController.h"

#import "GeneralViewController.h"
#import "DateViewController.h"

#import "PersonViewController.h"

#import "HttpClient.h"
#import "UploadCell.h"
#import "MeidaViewController.h"
#import "AlertView.h"
#import "RootViewController.h"
#import "CommomClient.h"
#import "DocumentViewController.h"

@interface ProcessFragmentNewViewController ()<GeneralViewControllerDelegate,AlertViewDelegate,MeidaViewControllerDelegate,RequestManagerDelegate,DateViewControllerDelegate,UploadCellDelegate,UIAlertViewDelegate,UITextFieldDelegate,UITextViewDelegate>{
    GeneralViewController *_generalViewController;
    
    DateViewController *_startPicker;
    DateViewController *_endPicker;
    
    NSDictionary *_statusDic;
    
    NSInteger _deleteIndex;
    
    PersonViewController *_personViewController;
    
    DocumentViewController *documentViewController;
    
    NSDictionary *_personDic;
    NSArray *_groupArr;
    
    HttpClient *_httpClient;
    RootViewController *_rootViewController;
    
    HttpClient *deleteHttpClient;
    
    AlertView *_alertView;
    
    NSData *_curData;
    NSString *_curType;
    NSMutableArray *_fileDatas;
    NSMutableString *_fileList;
    
    CGFloat _scrollHeight;
    
    BOOL _isUnDone;
}

@end

@implementation ProcessFragmentNewViewController

@synthesize proceeFragment = _proceeFragment;


- (void)receivesPop{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeMedia) name:@"closeMedia" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesPop) name:@"backpop" object:nil];
    
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.dateformatter = @"yyyy-MM-dd";

    _endPicker = [[DateViewController alloc] init];
    _endPicker.delegate = self;
    _endPicker.dateformatter = @"yyyy-MM-dd";
    
    _generalViewController = [[GeneralViewController alloc] init];
    _generalViewController.delegate = self;

    _fileDatas = [[NSMutableArray alloc] init];
    
    if (_proceeFragment == ProceeFragmentNew) {
        [self setTitle:@"新建进程阶段" color:nil];
    }
    else if (_proceeFragment == ProceeFragmentEdit){
        [self setTitle:@"编辑进程阶段" color:nil];
        if (_record) {
            _nameField.text = [_record objectForKey:@"ywcp_title"];
            [_statusButton setTitle:[_record objectForKey:@"ywcp_typename"] forState:UIControlStateNormal];
            [_statusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            NSString *complete = [_record objectForKey:@"ywcp_complete"];
            _valueButton.value = [complete floatValue];
            _valueLabel.text = [NSString stringWithFormat:@"%@%@",complete,@"%"];
            
            [_startButton setTitle:[_record objectForKey:@"ywcp_date"] forState:UIControlStateNormal];
            [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_endButton setTitle:[_record objectForKey:@"ywcp_end_date"] forState:UIControlStateNormal];
            [_endButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [_managerButton setTitle:[_record objectForKey:@"ywcp_emp_name"] forState:UIControlStateNormal];
            [_managerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            NSMutableString *groupStr = [[NSMutableString alloc] init];
            for (NSDictionary *group in [_record objectForKey:@"group_list"]) {
                [groupStr appendString:[NSString stringWithFormat:@"%@,",[group objectForKey:@"ywcp_group_name"]]];
            }
            
            _groupArr = [_record objectForKey:@"group_list"];
            
            
            [_groupButton setTitle:groupStr forState:UIControlStateNormal];
            [_groupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            _textView.text = [_record objectForKey:@"ywcp_detail"];
            
            for (NSDictionary *item in [_record objectForKey:@"file_list"]) {
                [_fileDatas addObject:item];
            }
            
            
            
            _tableHeight.constant = [[_record objectForKey:@"file_list"] count]*60;
            _contentHeight.constant += [[_record objectForKey:@"file_list"] count]*60;
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesSinglePerson:) name:PersonNormal object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesGroupPerson:) name:PersonGroup object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(reveivesFileList:) name:@"file_list_process" object:nil];
    
    UINib *nib = [UINib nibWithNibName:@"UploadCell" bundle:nil];
    [_tableview registerNib:nib forCellReuseIdentifier:@"UploadCell"];
    
    
    _fileList = [[NSMutableString alloc] initWithFormat:@""];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardDidHideNotification object:nil];
}

- (void)reveivesFileList:(NSNotification*)notification{
    NSString *idString = (NSString*)[notification object];
    [_fileList appendFormat:@"%@,",idString];
}

- (void)receivesSinglePerson:(NSNotification*)notification{
    _personDic = [notification object];
    [_managerButton setTitle:[_personDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
    [_managerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

- (void)closeMedia{
    [self.scrollView scrollsToTop];
}

- (void)receivesGroupPerson:(NSNotification*)notification{
    _groupArr = nil;
    _groupArr = [notification object];
    NSString *name = @"";
    for (NSDictionary *item in _groupArr) {
        if ([item objectForKey:@"ywcp_group_name"]) {
            name = [name stringByAppendingFormat:@"%@,",[item objectForKey:@"ywcp_group_name"]];
        }
        else if ([item objectForKey:@"gc_name"]){
            name = [name stringByAppendingFormat:@"%@,",[item objectForKey:@"gc_name"]];
        }
        
        
    }
    
    
    [_groupButton setTitle:name forState:UIControlStateNormal];
    [_groupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (NSDictionary*)param:(NSString*)ywcp_id{
    NSString *name = @"";
    if ([_nameField hasText]) {
        name = _nameField.text;
    }
    
    
    NSString *status = @"";
    if ([[_statusDic objectForKey:@"gc_id"] length] >0) {
        status = [_statusDic objectForKey:@"gc_id"];
    }
    else if (_record.count > 0){
        status = [_record objectForKey:@"ywcp_type"];
    }
    
    NSString *start = @"";
    if (_startButton.titleLabel.text > 0) {
        start = _startButton.titleLabel.text;
    }
    
    NSString *end = @"";
    if (_endButton.titleLabel.text > 0) {
        end = _endButton.titleLabel.text;
    }
    
    NSString *memo = @"";
    if ([_textView hasText]) {
        memo = _textView.text;
    }
    
    NSString *group = @"";
  
    for (int i = 0; i < _groupArr.count; i++) {
        NSDictionary *item = (NSDictionary*)[_groupArr objectAtIndex:i];
        
        if ([item objectForKey:@"gc_id"]) {
            if (i == (_groupArr.count-1)) {
                group = [group stringByAppendingFormat:@"%@",[item objectForKey:@"gc_id"]];
            }
            else{
                group = [group stringByAppendingFormat:@"%@,",[item objectForKey:@"gc_id"]];
            }
            
            
        }
        else if ([item objectForKey:@"ywcp_group_id"]){
            if (i == (_groupArr.count-1)) {
                group = [group stringByAppendingFormat:@"%@",[item objectForKey:@"ywcp_group_id"]];
            }
            else{
                group = [group stringByAppendingFormat:@"%@,",[item objectForKey:@"ywcp_group_id"]];
            }
            
        }
    }
    
    
    NSString *manager = @"";
 
    
    if (_personDic) {
        manager =[_personDic objectForKey:@"gc_id"];
    }
    else{
        manager = [_record objectForKey:@"ywcp_emp_id"];
    }

    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_caseID,@"ywcp_case_id",
                            ywcp_id,@"ywcp_id",
                            name,@"ywcp_title",
                            status,@"ywcp_type",
                            start,@"ywcp_date",
                            end,@"ywcp_end_date",
                            memo,@"ywcp_detail",
                            [NSString stringWithFormat:@"%d",(int)_valueButton.value],@"ywcp_complete",
                            manager,@"ywcp_empl_id",
                            group,@"ywcp_group",
                            _fileList,@"ywcp_files",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"CaseProcessItemEdit",@"requestKey", nil];
    return param;
}



- (void)hideKeyboard{
    [_textView resignFirstResponder];
    [_nameField resignFirstResponder];
}

- (IBAction)touchStatusEvent:(id)sender {
    [self hideKeyboard];
    _generalViewController.commomCode = @"YWCPT";
    [self.navigationController pushViewController:_generalViewController animated:YES];

}

- (IBAction)touchValueEvent:(UISlider*)sender {
    
    
    _valueLabel.text = [NSString stringWithFormat:@"%d%@",(int)sender.value ,@"%"];
}

- (IBAction)touchTimeEvent:(UIButton *)sender {
    [self hideKeyboard];
    if (sender.tag == 0) {
        CGRect frame = _startPicker.view.frame;
        frame.origin.x = 0;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
        _startPicker.view.frame = frame;
        
        
        [self.view addSubview:_startPicker.view];
    }
    else if (sender.tag == 1){
        CGRect frame = _endPicker.view.frame;
        frame.origin.x = 0;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
        _endPicker.view.frame = frame;
        [self.view addSubview:_endPicker.view];
    }

}

- (IBAction)touchManagerEvent:(id)sender {
    _personViewController = [[PersonViewController alloc] init];
    _personViewController.personType = PersonTypeNormal;
    _personViewController.caseID = _caseID;
    _personViewController.ywcpID = @"";
    [self.navigationController pushViewController:_personViewController animated:YES];
}

- (IBAction)touchGroupEvent:(UIButton *)sender {
    _personViewController = [[PersonViewController alloc] init];
    _personViewController.personType = PersonTypeGroup;
    _personViewController.caseID = _caseID;
    _personViewController.ywcpID = @"";
    _personViewController.datas = _groupArr;
    [self.navigationController pushViewController:_personViewController animated:YES];
}

- (IBAction)touchSureEvent:(id)sender {
    
    if (_groupArr.count == 0) {
        [self showHUDWithTextOnly:@"请选择小组成员"];
        return;
    }
    
    if (_proceeFragment == ProceeFragmentNew) {
        
        if (![_nameField hasText]) {
            [self showHUDWithTextOnly:@"请填写阶段名称"];
            return;
        }
        
        if ([[_statusDic objectForKey:@"gc_id"] length] == 0) {
            [self showHUDWithTextOnly:@"请填写进程状态"];
            return;
        }
        
        if ([_startButton.titleLabel.text length] == 0 || [_startButton.titleLabel.text isEqualToString:@"请选择"]) {
            [self showHUDWithTextOnly:@"请填写进程时间"];
            return;
        }
        
        if ([[_personDic objectForKey:@"gc_id"] length] == 0) {
            [self showHUDWithTextOnly:@"请填写负责人"];
            return;
        }
        
        if ([_groupButton.titleLabel.text length] == 0 || [_groupButton.titleLabel.text isEqualToString:@"请选择"]) {
            [self showHUDWithTextOnly:@"请选择小组成员"];
            return;
        }
        
        if (![_textView hasText]) {
            [self showHUDWithTextOnly:@"请填写进程描述"];
            return;
        }
        
        
        
//        if (_isUnDone) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"存在未上传的附件,是否忽略" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
//            alertView.delegate = self;
//            [alertView show];
//        }
//        
        [_httpClient startRequest:[self param:@""]];
        
    }
    else if (_proceeFragment == ProceeFragmentEdit){
        if (![_nameField hasText]) {
            [self showHUDWithTextOnly:@"请输入进程阶段名"];
            return;
        }
        
        if (![_textView hasText]) {
            [self showHUDWithTextOnly:@"请输入进程描述"];
            return;
        }
//        if (_proceeFragment == ProceeFragmentNew) {
//            
//        }
//        else if (_proceeFragment == ProceeFragmentEdit){
//            
//        }
        [_httpClient startRequest:[self param:_ywcpID]];

        
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
            }
}

- (IBAction)touchMediaEvent:(id)sender {
    
    MeidaViewController *_meidaViewController = [[MeidaViewController alloc] init];
    _meidaViewController.delegate = self;
    
    _meidaViewController.view.frame = self.navigationController.view.bounds;
    [self.navigationController.view addSubview:_meidaViewController.view];

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

- (void)uploadSuccess:(NSInteger)tag{

    NSMutableDictionary *dic = (NSMutableDictionary*)[_fileDatas objectAtIndex:tag];
    NSMutableDictionary *temp = [dic mutableCopy];
    [temp setObject:@"1" forKey:@"upload"];
    [_fileDatas replaceObjectAtIndex:tag withObject:temp];
 
    [self.tableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fileDatas.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UploadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UploadCell"];
    NSDictionary *dic = (NSDictionary*)[_fileDatas objectAtIndex:indexPath.row];
    cell.delegate = self;
    if (dic.count == 4) {
        cell.titelLabel.text = [dic objectForKey:@"name"];
        NSData *data = (NSData*)[dic objectForKey:@"data"];
        cell.sizeLabel.text = [NSString stringWithFormat:@"%.2fM",data.length/1024.0/1024.0];
        cell.uploadtype = UploadtypeProcess;
        cell.delegate = self;
        cell.tag = indexPath.row;
        [cell setProcessUploadFile:data type:[dic objectForKey:@"type"] caseID:_caseID title:[dic objectForKey:@"name"] ywcpID:@"" category:@"0"];
        cell.logoImageView.image = [self.view checkResourceType:[dic objectForKey:@"type"]];
        
        
        if ([[dic objectForKey:@"upload"] isEqualToString:@"1"]) {
            [cell.button setBackgroundImage:[UIImage imageNamed:@"download_done_logo.png"] forState:UIControlStateNormal];
            [cell.button setTitle:@"" forState:UIControlStateNormal];
            cell.button.enabled = NO;
            cell.button.hidden = NO;
        }
        else
        {
            [cell.button setBackgroundImage:[UIImage imageNamed:@"upload_btn.png"] forState:UIControlStateNormal];
            [cell.button setTitle:@"上传" forState:UIControlStateNormal];
            cell.button.enabled = YES;
            cell.button.hidden = NO;
        }


    }
    else {
        cell.titelLabel.text = [dic objectForKey:@"cpa_file_name"];
        cell.sizeLabel.text = [NSString stringWithFormat:@"%@M",[dic objectForKey:@"cpa_file_length"]];
        cell.logoImageView.image = [self.view checkResourceType:[dic objectForKey:@"cpa_file_type"]];
        cell.button.hidden = YES;
        
    }
    return cell;
}


- (void)alertView:(AlertView*)AlertView field:(NSString*)text{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_curData,@"data",text,@"name",_curType,@"type",@"0",@"upload", nil];
    self.navigationController.navigationBarHidden = NO;
    
    [_fileDatas addObject:dic];
    
    
    NSInteger num = _fileDatas.count;
    for (NSLayoutConstraint *layout in _tableview.constraints) {
        if (layout.firstAttribute == NSLayoutAttributeHeight) {
            layout.constant = num*55;
        }
    }
    for (NSLayoutConstraint *layout in _contentView.constraints) {
        if (layout.firstAttribute == NSLayoutAttributeHeight ) {
            layout.constant = num*55+600;
        }
    }
    
    [self.scrollView scrollsToTop];
    [_tableview reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
//        UploadCell *cell = (UploadCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
//        if (cell.button.enabled && !cell.button.selected) {
//            [_fileDatas removeObjectAtIndex:indexPath.row];
//            [_tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        }
//        
//        if (!cell.button.enabled || cell.button.selected) {
//            [self showHUDWithTextOnly:@"已上传文件不能删除"];
//        }
//        
        
        NSDictionary *dic = (NSDictionary*)[_fileDatas objectAtIndex:indexPath.row];
        _deleteIndex = indexPath.row;
        if ([dic count] > 5) {
            if ([[dic objectForKey:@"cpa_document_id"] length] > 0) {
                [self showHUDWithTextOnly:@"此文档已转存，不能删除"];
            }
            else{
                deleteHttpClient = [[HttpClient alloc] init];
                deleteHttpClient.delegate = self;
                NSString *ido_doc_id = [dic objectForKey:@"cpa_id"];
                [deleteHttpClient startRequest:[self deleteParam:ido_doc_id]];
            }
            
            
        }
        else{
            
            NSString *upload = [dic objectForKey:@"upload"];
            if ([upload isEqualToString:@"1"]) {
                [self showHUDWithTextOnly:@"已上传文件不能删除"];
            }
            else{
                [_fileDatas removeObjectAtIndex:_deleteIndex];
                [self.tableview reloadData];
            }
            
            
            
            
        }
        
    }
    
}

- (NSDictionary*)deleteParam:(NSString*)rdi_doc_id{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getAccount],@"userID",rdi_doc_id,@"cpaID",[_record objectForKey:@"ywcp_id"],@"ywcpID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"processAttachmentDelete",@"requestKey",fields,@"fields", nil];
    return param;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = (NSDictionary*)[_fileDatas objectAtIndex:indexPath.row];
    documentViewController = [[DocumentViewController alloc] init];
    if (dic.count == 3) {
        documentViewController.data = [dic objectForKey:@"data"];
        documentViewController.type = [dic objectForKey:@"type"];
        documentViewController.documentType = DocumentTypeLocal;
        documentViewController.name = [dic objectForKey:@"name"];
    }
    else {
        documentViewController.type = [dic objectForKey:@"cpa_file_type"];
        documentViewController.name = [dic objectForKey:@"cpa_file_name"];
        documentViewController.pathString = [dic objectForKey:@"cpa_file_url"];
        documentViewController.documentType = DocumentTypeWeb;
    }
    [self.navigationController pushViewController:documentViewController animated:YES];
}


- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    if (dateViewController == _startPicker) {
        [_startButton setTitle:date forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (dateViewController == _endPicker){
        [_endButton setTitle:date forState:UIControlStateNormal];
        [_endButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    if (generalViewController == _generalViewController) {
        _statusDic = data;
        [_statusButton setTitle:[_statusDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_statusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
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
    
    CGSize size = self.scrollView.contentSize;
    size.height = _contentView.frame.size.height + keyboardSize.height;
    self.scrollView.contentSize = size;
    
}



-(void)keyBoardHide
{
    
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _sureView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = 0;
        }
        
    }
}

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    
    if (request == _httpClient) {
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            // [self showHUDWithTextOnly:@"创建成功"];
            
            if (_proceeFragment == ProceeFragmentNew) {
                
                if (_isCustom) {
                    _rootViewController = [[RootViewController alloc] init];
                    [self presentViewController:_rootViewController animated:NO completion:nil];
                    [_rootViewController showInProcessDetail];
                    _rootViewController.processDetailViewController.ispop = YES;
                    _rootViewController.processDetailViewController.caseID = _caseID;
                    _rootViewController.processDetailViewController.isScrollBottom = YES;
                    
                }
                else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"receivesUpProcess" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
                
            }
            else if (_proceeFragment == ProceeFragmentEdit){
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else{
            [self showHUDWithTextOnly:@"创建失败"];
        }
    }
    else if (request == deleteHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"删除成功"];
            [_fileDatas removeObjectAtIndex:_deleteIndex];
            [self.tableview reloadData];
            
            
        }
        else{
//            [self showHUDWithTextOnly:@"删除失败"];
        }
    }
    
    
    _scrollHeight = self.scrollView.contentSize.height;
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    return YES;
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
