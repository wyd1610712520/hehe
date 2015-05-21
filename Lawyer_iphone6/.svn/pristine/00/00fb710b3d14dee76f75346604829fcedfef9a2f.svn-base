//
//  ClientDocViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ClientDocViewController.h"

#import "HttpClient.h"

#import "MeidaViewController.h"
#import "UploadCell.h"

#import "AlertView.h"


#import "DocumentViewController.h"

@interface ClientDocViewController ()<UITableViewDataSource,AlertViewDelegate,DocumentViewControllerDelegate,UITableViewDelegate,UploadCellDelegate,MeidaViewControllerDelegate,RequestManagerDelegate>{
    HttpClient *_httpClient;
    
    MeidaViewController *_meidaViewController;
    
    NSMutableArray *_uploadTableDatas;
    
    AlertView *_alertView;
    
    NSData *_curData;
    NSString *_curType;
    
    
    DocumentViewController *documentViewController;
}

@end

@implementation ClientDocViewController

@synthesize clientDocCell = _clientDocCell;
@synthesize clientID = _clientID;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self setTitle:@"相关文档信息" color:nil];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    [_httpClient startRequest:[self requestParam]];

}

- (NSDictionary*)requestParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_clientID,@"clientID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"clientgetDetailDoc",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTable];
    [self setDismissButton];
    [self setRightButton:[UIImage imageNamed:@"nav_add_btn.png"] title:nil target:self action:@selector(touchAddEvent)];
    
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    _uploadTableDatas = [[NSMutableArray alloc] init];
    
    
    
}

- (void)touchAddEvent{
    _meidaViewController = [[MeidaViewController alloc] init];
    _meidaViewController.delegate = self;

    _meidaViewController.view.frame = self.navigationController.view.bounds;
    [self.navigationController.view addSubview:_meidaViewController.view];
}

- (void)meidaViewController:(MeidaViewController*)meidaViewController fileData:(NSData*)fileData type:(NSString *)type{
    _curData = fileData;
    _curType = type;
    
//    UIView *lastView = [self.navigationController.view.subviews lastObject];
//    [lastView removeFromSuperview];
//    
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
    UINib *nib = [UINib nibWithNibName:@"UploadCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"UploadCell"];
    
    [self.tableView reloadData];
}

#pragma mark-UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_uploadTableDatas.count > 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_uploadTableDatas.count > 0) {
        if (section == 0) {
            return _uploadTableDatas.count;
        }
    }
    
    return self.tableDatas.count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_uploadTableDatas.count > 0 && section == 0) {
        return @"上传列表";
    }
    return @"文档列表";
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_uploadTableDatas.count > 0 && indexPath.section == 0) {
        [_uploadTableDatas removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    

    if (_uploadTableDatas.count > 0 && indexPath.section == 0) {
        UploadCell *cell = (UploadCell*)[tableView dequeueReusableCellWithIdentifier:@"UploadCell"];
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"UploadCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        cell.delegate = self;
        cell.tag = indexPath.row;
        NSDictionary *dic = (NSDictionary*)[_uploadTableDatas objectAtIndex:indexPath.row];
        cell.titelLabel.text = [dic objectForKey:@"name"];
        NSData *data = (NSData*)[dic objectForKey:@"data"];
        cell.sizeLabel.text = [NSString stringWithFormat:@"%.2fM",data.length/1024.0/1024.0];
        cell.logoImageView.image = [self.view checkResourceType:[dic objectForKey:@"type"]];
        
        

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

        
        [cell setUploadFile:data doc_class:[NSString stringWithFormat:@"M3@%@",_clientID] relate_case:@"" location:@"" type:[dic objectForKey:@"type"] title:[dic objectForKey:@"name"]];
        
       return cell;
    }
    else{
        ClientDocCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientDocCell"];
        if (!cell) {
            [[NSBundle mainBundle] loadNibNamed:@"ClientDocCell" owner:self options:nil];
            cell = _clientDocCell;
           // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        NSDictionary *item =  (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        cell.titleLabel.text = [item objectForKey:@"do_title"];
        cell.nameLabel.text = [item objectForKey:@"do_creator_name"];
        cell.dateLabel.text = [item objectForKey:@"do_create_date"];
        cell.logoImageView.image = [self.view checkResourceType:[item objectForKey:@"do_file_type"]];
        return cell;
    }
    
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_uploadTableDatas.count > 0 && indexPath.section == 0) {
        NSDictionary *dic = (NSDictionary*)[_uploadTableDatas objectAtIndex:indexPath.row];
        
        documentViewController = [[DocumentViewController alloc] init];
        documentViewController.data = [dic objectForKey:@"data"];
        documentViewController.type = [dic objectForKey:@"type"];
        documentViewController.documentType = DocumentTypeLocal;
        documentViewController.name = [dic objectForKey:@"name"];
        [self.navigationController pushViewController:documentViewController animated:YES];
    }
    else{
        NSDictionary *item =  (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        documentViewController = [[DocumentViewController alloc] init];

        documentViewController.delegate = self;
        documentViewController.pathString = [item objectForKey:@"do_url"];
        documentViewController.type = [item objectForKey:@"do_file_type"];
        documentViewController.name = [item objectForKey:@"do_title"];
        [self.navigationController pushViewController:documentViewController animated:YES];
    }
}

- (void)closeDocument{
  //  [documentViewController.navigationController popViewControllerAnimated:YES];
}

- (void)uploadSuccess:(NSInteger)tag{
//    [self.tableView beginUpdates];
//    [self.tableView endUpdates];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:tag inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];

    [_uploadTableDatas removeObjectAtIndex:tag];
    [_httpClient startRequest:[self requestParam]];
}

- (void)uploadFail{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    [self.tableDatas removeAllObjects];
    for (NSDictionary *item in [result objectForKey:@"file_list"]) {
        [self.tableDatas addObject:item];
    }
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}



@end
