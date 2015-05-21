//
//  ResearchViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ResearchViewController.h"

#import "CaseViewController.h"

#import "UploadCell.h"

#import "MeidaViewController.h"

#import "RootViewController.h"

#import "GeneralViewController.h"

#import "UploadClient.h"

#import "MapViewController.h"

#import "AlertView.h"

#import "UploadClient.h"

#import "FileViewController.h"
#import "CommomClient.h"

#import "DocumentViewController.h"

#import "AlertView.h"
#import "CommomClient.h"

@interface ResearchViewController ()<CaseViewControllerDelegate,UIGestureRecognizerDelegate,GeneralViewControllerDelegate,MeidaViewControllerDelegate,UploadCellDelegate,UITextFieldDelegate,MapViewControllerDelegate,UITableViewDataSource,AlertViewDelegate,UploadClientDelegate,FileViewControllerDelegate,UITableViewDelegate>{
    CaseViewController *_caseViewController;
    
    MeidaViewController *_meidaViewController;
    
    RootViewController *_rootViewController;
    
    NSMutableArray *_fileDatas;
    
    GeneralViewController *_docTypeViewController;
    NSDictionary *_docDic;
    
    NSString *_commomCode;
    
    NSDictionary *_caseMapping;
    
    MapViewController *_mapViewController;
    
    AlertView *_alertView;
    
    NSData *_curData;
    NSString *_curType;
    
    RootViewController *_fileRootViewController;
    
    RootViewController *_readFileViewController;
    
    NSString *_caseId;
    NSString *_pathId;
    
    DocumentViewController *documentViewController;
    
    AlertView *_fileAlertView;
}

@end

@implementation ResearchViewController

@synthesize scrollView = _scrollView;

@synthesize tableView = _tableView;
@synthesize locationButton = _locationButton;

@synthesize caseNameButton = _caseNameButton;
@synthesize caseIdField = _caseIdField;
@synthesize clientNameField = _clientNameField;
@synthesize clientIdField = _clientIdField;
@synthesize pathField = _pathField;
@synthesize docButton = _docButton;
@synthesize addressField = _addressField;

@synthesize record = _record;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:[Utility localizedStringWithTitle:@"research_nav_title"] color:nil];
    
    
}

- (IBAction)touchLocationEvent:(id)sender{
    _mapViewController = [[MapViewController alloc] init];
    [self.navigationController pushViewController:_mapViewController animated:YES];
    _mapViewController.delegate = self;
    [_mapViewController location];

}

- (void)returnUserLocation:(NSString *)address{
    _addressField.text = address;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];

    
    
    UINib *nib = [UINib nibWithNibName:@"UploadCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"UploadCell"];
    
    if (_record) {
        _commomCode = [NSString stringWithFormat:@"DOCT_%@",[_record objectForKey:@"ca_case_id"]];
        _caseId = [_record objectForKey:@"ca_case_id"];
        [_caseNameButton setTitle:[_record objectForKey:@"ca_case_name"]  forState:UIControlStateNormal];
        _caseIdField.text = [_record objectForKey:@"ca_case_id"];
        _clientNameField.text = [_record objectForKey:@"cl_client_name"];
        _clientIdField.text = [_record objectForKey:@"cl_client_id"];
        _pathField.text = [NSString stringWithFormat:@"文档中心/正式案件/%@/",[_record objectForKey:@"ca_case_name"]];
        
        [_caseNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
    }
    

    _docTypeViewController = [[GeneralViewController alloc] init];
    _docTypeViewController.delegate = self;
    
    _fileDatas = [[NSMutableArray alloc] init];
    
    _meidaViewController = [[MeidaViewController alloc] init];
    _meidaViewController.fileButton.hidden = YES;
    _meidaViewController.delegate = self;
    _pathId = @"";

//    UILongPressGestureRecognizer *oneTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
//    oneTap.delegate = self;
//    oneTap.numberOfTouchesRequired = 1;
//    [_contentView addGestureRecognizer:oneTap];
}

- (void)hideKeyBoard{
    
}

- (IBAction)touchCaseEvent:(id)sender{
    
    _rootViewController = [[RootViewController alloc] init];
    
    [self presentViewController:_rootViewController animated:YES completion:nil];
    
    [_rootViewController showInCase];
    _rootViewController.caseViewController.caseStatuts = CaseStatutsSelectable;
    _rootViewController.caseViewController.delegate = self;
}

- (IBAction)touchAttachEvent:(id)sender{
    if (_caseId.length > 0) {
        _meidaViewController.view.frame = self.navigationController.view.bounds;
        [self.navigationController.view addSubview:_meidaViewController.view];
    }
    else{
        [self showHUDWithTextOnly:@"请选择案件"];
    }
    
    
}

- (IBAction)touchSureEvent:(id)sender{
    if (_caseId.length > 0) {
        _fileAlertView = [[AlertView alloc] initWithFrame:CGRectMake(15, 120, self.view.frame.size.width-30, 125)];
        [self.view addSubview:_fileAlertView];
        _fileAlertView.delegate = self;
        [_fileAlertView setAlertButtonType:AlertButtonTwo];
        [_fileAlertView.tipLabel setText:@"是否进行查看"];
        _fileAlertView.textField = nil;
        [_fileAlertView.sureButton setTitle:@"查看" forState:UIControlStateNormal];
        [self.view bringSubviewToFront:_fileAlertView];

    }
    else{
        [self showHUDWithTextOnly:@"请选择案件"];
    }
    //    [self dismissViewControllerAnimated:YES completion:nil];

}



- (IBAction)touchDocEvent:(id)sender{
    //_docTypeViewController.commomCode = _commomCode;
    //[self.navigationController pushViewController:_docTypeViewController animated:YES];
    
    if (_caseId.length > 0) {
        _fileRootViewController = [[RootViewController alloc] init];
        
        
        
        NSString *string = [[CommomClient sharedInstance] getValueFromUserInfo:@"docClassSplit"];
        
        
        NSString *clssid = [NSString stringWithFormat:@"M4%@%@",string,_caseId];
        
        [self presentViewController:_fileRootViewController animated:NO completion:nil];
        [_fileRootViewController showInFile];
        _fileRootViewController.fileViewController.delegate = self;
        _fileRootViewController.fileViewController.titleStr = [NSString stringWithFormat:@"%@/",_caseNameButton.titleLabel.text];
        _fileRootViewController.fileViewController.fileOperation = FileOperationSelect;
        _fileRootViewController.fileViewController.caseClassId =clssid;
        _fileRootViewController.fileViewController.isFileSelect = YES;
    }
    else{
        [self showHUDWithTextOnly:@"请选择案件"];
    }
}

- (void)returnSelectedDoc:(NSDictionary *)record{
    [_fileRootViewController dismissViewControllerAnimated:YES completion:nil];
    _pathId = [record objectForKey:@"dc_doc_class"];;
    [_tableView reloadData];
    
    [_docButton setTitle:[record objectForKey:@"dc_description"] forState:UIControlStateNormal];
    [_docButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    _docDic = data;
    [_docButton setTitle:[_docDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
    [_docButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

- (void)uploadTint{
    [self showHUDWithTextOnly:@"请选择文件夹"];
}

#pragma mark - CaseViewControllerDelegate

- (void)returnDataToProcess:(NSDictionary*)item{
    _caseMapping = item;
    
    _commomCode = [NSString stringWithFormat:@"DOCT_%@",[_caseMapping objectForKey:@"ca_case_id"]];
    [_caseNameButton setTitle:[_caseMapping objectForKey:@"ca_case_name"]  forState:UIControlStateNormal];
    _caseIdField.text = [_caseMapping objectForKey:@"ca_case_id"];
    
    _caseId = [_caseMapping objectForKey:@"ca_case_id"];
    
    _clientNameField.text = [_caseMapping objectForKey:@"cl_client_name"];
    _clientIdField.text = [_caseMapping objectForKey:@"cl_client_id"];
    _pathField.text = [NSString stringWithFormat:@"文档中心/正式案件/%@/",[_caseMapping objectForKey:@"ca_case_name"]];
    
    [_caseNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fileDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return YES;
    }
    return  YES;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UploadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UploadCell"];
    NSDictionary *dic = (NSDictionary*)[_fileDatas objectAtIndex:indexPath.row];
    cell.titelLabel.text = [dic objectForKey:@"name"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSData *data = (NSData*)[dic objectForKey:@"data"];
    cell.sizeLabel.text = [NSString stringWithFormat:@"%.2fM",data.length/1024.0/1024.0];
    cell.uploadtype = UploadtypeResearch;
    cell.delegate = self;
    [cell setUploadFile:data doc_class:[NSString stringWithFormat:@"%@",_pathId] relate_case:_caseIdField.text location:_addressField.text type:[dic objectForKey:@"type"] title:[dic objectForKey:@"name"]];
    cell.logoImageView.image = [self.view checkResourceType:[dic objectForKey:@"type"]];
    
    if (cell.uploadStatus == UploadDone) {
        [cell.button setBackgroundImage:[UIImage imageNamed:@"download_done_logo.png"] forState:UIControlStateNormal];
        [cell.button setTitle:@"" forState:UIControlStateNormal];
        cell.button.enabled = NO;
    }
    else if (cell.uploadStatus == Uploading){
        //[cell.button setTitle:@"" forState:UIControlStateNormal];
        //[cell.button setBackgroundImage:[UIImage imageNamed:@"download_process_logo.png"] forState:UIControlStateNormal];
    }
    else{
        [cell.button setBackgroundImage:[UIImage imageNamed:@"upload_btn.png"] forState:UIControlStateNormal];
        [cell.button setTitle:@"上传" forState:UIControlStateNormal];
        cell.button.enabled = YES;
    }
 
    return cell;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
        return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UploadCell *cell = (UploadCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];

        
        if (cell.button.enabled && !cell.button.selected) {
            [_fileDatas removeObjectAtIndex:indexPath.row];
            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        if (!cell.button.enabled) {
            
            if (cell.button.selected) {
                [self showHUDWithTextOnly:@"文件正在上传中请勿操作"];
            }
            else{
                [self showHUDWithTextOnly:@"已上传文件请到文档中心进行管理"];
            }
        }

        
    }
    
}

- (void)uploadFail{
    [self showHUDWithTextOnly:@"当前网络状态不稳地，请稍后再试"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



- (void)meidaViewController:(MeidaViewController*)meidaViewController fileData:(NSData*)fileData type:(NSString *)type{
    _curData = fileData;
    _curType = type;
    
    
    _alertView = [[AlertView alloc] initWithFrame:CGRectMake(15, 120, self.view.frame.size.width-30, 125)];
    [meidaViewController.view addSubview:_alertView];
     _alertView.delegate = self;
    [_alertView setAlertButtonType:AlertButtonOne];
    [_alertView showField:[self.view getCurrentDate]];
    [_alertView.tipLabel setText:@"重命名文件"];
    [meidaViewController.view bringSubviewToFront:_alertView];
    
    
}

- (void)alertView:(AlertView*)AlertView field:(NSString*)text{
    if (AlertView == _alertView) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_curData,@"data",text,@"name",_curType,@"type", nil];
        self.navigationController.navigationBarHidden = NO;
        
        [_fileDatas addObject:dic];
        
         
        NSInteger num = _fileDatas.count;
        for (NSLayoutConstraint *layout in _tableView.constraints) {
            if (layout.firstAttribute == NSLayoutAttributeHeight) {
                layout.constant = (num+1)*55;
            }
        }
        for (NSLayoutConstraint *layout in _contentView.constraints) {
            if (layout.firstAttribute == NSLayoutAttributeHeight && layout.firstItem == _contentView) {
                layout.constant = num*55+600;
            }
        }
        
        

    }
    else if (AlertView == _fileAlertView){
        _readFileViewController = [[RootViewController alloc] init];
        
        NSString *string = [[CommomClient sharedInstance] getValueFromUserInfo:@"docClassSplit"];
        
        
        
        
        [self presentViewController:_readFileViewController animated:NO completion:nil];
        [_readFileViewController showInFile];
        _readFileViewController.fileViewController.fileOperation = FileOperationRead;
        
        NSString *pathStr = [NSString stringWithFormat:@"%@",_pathField.text];
        if (_docButton.titleLabel.text.length > 0 && ![_docButton.titleLabel.text isEqualToString:@"请选择"]) {
            pathStr = [pathStr stringByAppendingFormat:@"%@/",_docButton.titleLabel.text];
        }
        
        _readFileViewController.fileViewController.titleStr = pathStr;
        
        if (_pathId.length > 0) {
            _readFileViewController.fileViewController.caseClassId =_pathId;
        }
        else{
            NSString *clssid = [NSString stringWithFormat:@"M4%@%@",string,_caseId];
            _readFileViewController.fileViewController.caseClassId = clssid;
        }
    }
    [self.view bringSubviewToFront:_tableView];
    [_tableView reloadData];
}

@end
