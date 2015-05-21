//
//  AttachViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-28.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "AttachViewController.h"

#import "HttpClient.h"

#import "GeneralViewController.h"

#import "RootViewController.h"
#import "FileViewController.h"
#import "CommomClient.h"

@interface AttachViewController ()<RequestManagerDelegate,FileViewControllerDelegate,GeneralViewControllerDelegate>{
    GeneralViewController *_docTypeViewController;
    NSDictionary *_docDic;
    NSString *_commomCode;
    
    HttpClient *_httpClient;
    
    NSString *_pathId;
    
    NSDictionary *_record;
    
    RootViewController *_fileRootViewController;
}

@end

@implementation AttachViewController

@synthesize caseID = _caseID;
@synthesize item = _item;

@synthesize caseName = _caseName;



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setTitle:@"附件转存" color:nil];
    
    _docTypeViewController = [[GeneralViewController alloc] init];
    _docTypeViewController.delegate = self;
    
    _commomCode = [NSString stringWithFormat:@"DOCT_%@",_caseID];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    
}

- (NSDictionary*)param{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_caseID,@"caseID",[_item objectForKey:@"cpa_id"],@"cpaID",[[CommomClient sharedInstance] getAccount],@"userID",_pathId,@"cpaDir", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"processattToCaseDoc",@"requestKey", nil];
    return param;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _titleLabel.text = [_item objectForKey:@"cpa_file_name"];
    _sizeLabel.text = [_item objectForKey:@"cpa_file_length"];
    _typeLabel.text = [_item objectForKey:@"cpa_file_type"];
    
    _contentLabel.text = [NSString stringWithFormat:@"文档中心/正式案件/%@",_caseName];
}


- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    if (request == _httpClient) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"转存成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"zhuancun" object:nil];
        }
        else{
            [self showHUDWithTextOnly:@"转存失败"];
        }
    }
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)touchDocEvent:(id)sender {
//    _docTypeViewController.commomCode = _commomCode;
//    [self.navigationController pushViewController:_docTypeViewController animated:YES];
    _fileRootViewController = [[RootViewController alloc] init];
    
    
    
    NSString *string = [[CommomClient sharedInstance] getValueFromUserInfo:@"docClassSplit"];
    
    
    NSString *clssid = [NSString stringWithFormat:@"M4%@%@",string,_caseID];
    
    [self presentViewController:_fileRootViewController animated:NO completion:nil];
    [_fileRootViewController showInFile];
    _fileRootViewController.fileViewController.delegate = self;
    _fileRootViewController.fileViewController.titleStr = [NSString stringWithFormat:@"%@/",_caseName];
    _fileRootViewController.fileViewController.fileOperation = FileOperationSelect;
    _fileRootViewController.fileViewController.caseClassId =clssid;
    _fileRootViewController.fileViewController.isFileSelect = YES;

}

- (void)returnSelectedDoc:(NSDictionary *)record{
    _record = record;
    [_fileRootViewController dismissViewControllerAnimated:YES completion:nil];
    _pathId = [record objectForKey:@"dc_doc_class"];;
    [_docButton setTitle:[record objectForKey:@"dc_description"] forState:UIControlStateNormal];
    [_docButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (IBAction)touchSureEvent:(id)sender {
    if (!_record) {
        [self showHUDWithTextOnly:@"请选择存放文件夹"];
        return;
    }
    [_httpClient startRequest:[self param]];
}

- (void)general:(GeneralViewController*)generalViewController data:(NSDictionary*)data{
    _docDic = data;
    [_docButton setTitle:[_docDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
    [_docButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}


@end
