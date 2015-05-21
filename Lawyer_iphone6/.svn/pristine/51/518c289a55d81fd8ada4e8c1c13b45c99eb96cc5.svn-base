//
//  NewFileViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-20.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "NewFileViewController.h"

#import "MapViewController.h"

#import "MeidaViewController.h"

#import "AlertView.h"

#import "UploadCell.h"

#import "DocumentViewController.h"

@interface NewFileViewController ()<MapViewControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UploadCellDelegate,MeidaViewControllerDelegate,AlertViewDelegate>{
    MapViewController *_mapViewController;
    
    MeidaViewController *_meidaViewController;
    
    NSMutableArray *_uploadTableDatas;
    
    AlertView *_alertView;
    
    NSData *_curData;
    NSString *_curType;

    NSMutableArray *_tags;
    NSMutableArray *_tagsStart;
    
    DocumentViewController *documentViewController;
    
    NSInteger isback;
}

@end

@implementation NewFileViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _titleLabel.text = _path;
}

- (void)popSelf{
    if (isback > 0) {
        [self showHUDWithTextOnly:@"请等待文件上传成功后返回"];
    }
    else{
        [super popSelf];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"上传文件" color:nil];
    
    UINib *nib = [UINib nibWithNibName:@"UploadCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"UploadCell"];
    _uploadTableDatas = [[NSMutableArray alloc] init];
     _tags = [[NSMutableArray alloc] init];
    _tagsStart = [[NSMutableArray alloc] init];
    
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"file_update" object:nil];
}

- (IBAction)touchLocationEvent:(id)sender {
    _mapViewController = [[MapViewController alloc] init];
    [self.navigationController pushViewController:_mapViewController animated:YES];
    _mapViewController.delegate = self;
    [_mapViewController location];
}

- (void)returnUserLocation:(NSString *)address{
    _addressField.text = address;
    [_tableView reloadData];
}

- (IBAction)touchMediaEvent:(id)sender {
    _meidaViewController = [[MeidaViewController alloc] init];
    _meidaViewController.delegate = self;
    _meidaViewController.fileButton.hidden = YES;
    _meidaViewController.view.frame = self.navigationController.view.bounds;
    [self.navigationController.view addSubview:_meidaViewController.view];

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
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_curData,@"data",text,@"name",_curType,@"type", nil];
    self.navigationController.navigationBarHidden = NO;
    
    [_uploadTableDatas addObject:dic];
    _viewLayout.constant= self.view.frame.size.height + _uploadTableDatas.count*60;
    _tableViewLayout.constant = _uploadTableDatas.count*60;
    
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _uploadTableDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UploadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UploadCell"];
//    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"UploadCell" owner:self options:nil];
//    cell = [nib objectAtIndex:0];
    
    cell.delegate = self;
    cell.tag = indexPath.row;
    NSDictionary *dic = (NSDictionary*)[_uploadTableDatas objectAtIndex:indexPath.row];
    cell.titelLabel.text = [dic objectForKey:@"name"];
    NSData *data = (NSData*)[dic objectForKey:@"data"];
    cell.sizeLabel.text = [NSString stringWithFormat:@"%.2fM",data.length/1024.0/1024.0];
    cell.logoImageView.image = [self.view checkResourceType:[dic objectForKey:@"type"]];
    
    cell.uploadtype = UploadtypeNormal;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell.uploadStatus == UploadDone) {
        [cell.button setBackgroundImage:[UIImage imageNamed:@"download_done_logo.png"] forState:UIControlStateNormal];
        [cell.button setTitle:@"" forState:UIControlStateNormal];
        cell.button.enabled = NO;
    }
    else if (cell.uploadStatus == Uploading){
        [cell.button setTitle:@"" forState:UIControlStateNormal];
        [cell.button setBackgroundImage:[UIImage imageNamed:@"download_process_logo.png"] forState:UIControlStateNormal];
    }
    else{
        [cell.button setBackgroundImage:[UIImage imageNamed:@"upload_btn.png"] forState:UIControlStateNormal];
        [cell.button setTitle:@"上传" forState:UIControlStateNormal];
        cell.button.enabled = YES;
    }
    
//    if ([_tags containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
//        [cell.button setBackgroundImage:[UIImage imageNamed:@"download_done_logo.png"] forState:UIControlStateNormal];
//        [cell.button setTitle:@"" forState:UIControlStateNormal];
//        cell.button.enabled = NO;
//    }
//    else{
//        [cell.button setBackgroundImage:[UIImage imageNamed:@"upload_btn.png"] forState:UIControlStateNormal];
//        [cell.button setTitle:@"上传" forState:UIControlStateNormal];
//        cell.button.enabled = YES;
//    }
    
   
    
    [cell setUploadFile:data doc_class:_do_doc_class relate_case:@"" location:_addressField.text type:[dic objectForKey:@"type"] title:[dic objectForKey:@"name"]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UploadCell *cell = (UploadCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        if (cell.button.enabled && !cell.button.selected) {
            [_tags removeObject:[NSNumber numberWithInteger:indexPath.row]];
            [_uploadTableDatas removeObjectAtIndex:indexPath.row];
            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        if (!cell.button.enabled || cell.button.selected) {
            [self showHUDWithTextOnly:@"已上传文件不能删除"];
        }
        
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = (NSDictionary*)[_uploadTableDatas objectAtIndex:indexPath.row];
    
    documentViewController = [[DocumentViewController alloc] init];
    documentViewController.data = [dic objectForKey:@"data"];
    documentViewController.type = [dic objectForKey:@"type"];
    documentViewController.documentType = DocumentTypeLocal;
    documentViewController.name = [dic objectForKey:@"name"];
    [self.navigationController pushViewController:documentViewController animated:YES];

}

- (void)startUpload:(NSInteger)tag{
    isback ++;
}

- (void)uploadSuccess:(NSInteger)tag{
    isback --;
    if (_uploadTableDatas.count > 0) {
        [_tags addObject:[NSNumber numberWithInteger:tag]];
        //[_tableView beginUpdates];
        //[_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:tag inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        //[_tableView endUpdates];
        [_tableView reloadData];
       
    }
    
    // [_httpClient startRequest:[self requestParam]];
}

- (void)uploadFail{
    isback --;
    [_tableView reloadData];
}


@end
