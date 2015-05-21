//
//  ModulePreviewViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-2-4.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ModulePreviewViewController.h"

#import "ModulePreviewCell.h"

#import "HttpClient.h"
#import "CommomClient.h"

#import "RootViewController.h"

#import "NSString+Utility.h"

#import "ProcessFragmentNewViewController.h"

@interface ModulePreviewViewController ()<UITableViewDataSource,UITableViewDelegate,RequestManagerDelegate>{
    HttpClient *_httpClient;
    
    NSMutableArray *_tableDatas;
    
    HttpClient *_creatHttpClient;
    
    RootViewController *_rootViewController;
}

@end

@implementation ModulePreviewViewController

@synthesize cptcID = _cptcID;

- (NSDictionary*)param:(NSString*)cptcID{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:cptcID,@"cptcID",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"processtmpldetail",@"requestKey", nil];
    return param;
}

- (void)receivesPop{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [@"F9F9F9" colorValue];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesPop) name:@"backpop" object:nil];
    
    if (_moduleType == ModuleTypeCustom) {
        [self setTitle:@"自定义案件进程" color:nil];
        self.tableView.hidden = YES;
        
        _moduleNameLabel.text = [_record objectForKey:@"ca_case_name"];
        _manageLabel.text = [NSString stringWithFormat:@"案件编号：%@",[_record objectForKey:@"ca_case_id"]];
        _dateLabel.text = [NSString stringWithFormat:@"客户：%@",[_record objectForKey:@"cl_client_name"]];
        _categoryLabel.text = [NSString stringWithFormat:@"案件类别：%@",[_record objectForKey:@"ca_category"]];
        _typeLabel.text = [NSString stringWithFormat:@"创建人：%@",[_record objectForKey:@"ca_manager_name"]];
        
        _customView.backgroundColor = [@"F9F9F9" colorValue];
        _customView.hidden = NO;
        
    }
    else{
        _customView.hidden = YES;
        _httpClient = [[HttpClient alloc] init];
        _httpClient.delegate = self;
        [_httpClient startRequest:[self param:_cptcID]];

        
        self.tableView.hidden = NO;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self setTitle:@"模板预览" color:nil];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
        self.view.backgroundColor = [@"#F9F9F9" colorValue];
        
        UINib *cellNib = [UINib nibWithNibName:@"ModulePreviewCell" bundle:nil];
        [_tableView registerNib:cellNib forCellReuseIdentifier:@"ModulePreviewCell"];
    }
    
    
}

- (IBAction)touchProEvent:(id)sender{
    ProcessFragmentNewViewController *processFragmentNewViewController = [[ProcessFragmentNewViewController alloc] init];
    processFragmentNewViewController.caseID = _caseID;
    processFragmentNewViewController.proceeFragment = ProceeFragmentNew;
    processFragmentNewViewController.ywcpID = @"";
    
    if (_moduleType == ModuleTypeCustom) {
        processFragmentNewViewController.isCustom = YES;
    }
    
    [self.navigationController pushViewController:processFragmentNewViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModulePreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ModulePreviewCell"];
    
    NSDictionary *item = (NSDictionary*)[_tableDatas objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = [item objectForKey:@"cpt_title"];
    cell.contentLabel.text = [item objectForKey:@"cpt_description"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = (NSDictionary*)[_tableDatas objectAtIndex:indexPath.row];
    return [ModulePreviewCell heightForRow:[item objectForKey:@"cpt_description"]];
}

- (IBAction)touchSureEvent:(id)sender{
    _creatHttpClient = [[HttpClient alloc] init];
    _creatHttpClient.delegate = self;
    [_creatHttpClient startRequest:[self createParam]];
}

- (NSDictionary*)createParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_cptcID,@"cptcID",[[CommomClient sharedInstance] getAccount],@"userID",_caseID,@"caseID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"registprocessitembytmpl",@"requestKey", nil];
    return param;
}



- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    if (request == _httpClient) {
        if ([dic objectForKey:@"record_list"]) {
            NSDictionary *record = (NSDictionary*)[[dic objectForKey:@"record_list"] lastObject];
            _moduleNameLabel.text = [record objectForKey:@"cptc_description"];
            _manageLabel.text = [NSString stringWithFormat:@"创建人：%@",[record objectForKey:@"cptc_creator_name"]];
            _dateLabel.text = [NSString stringWithFormat:@"创建日期：%@",[record objectForKey:@"cptc_create_date"]];
            _categoryLabel.text = [NSString stringWithFormat:@"案件类别：%@",[record objectForKey:@"cptc_category_name"]];
            _typeLabel.text = [NSString stringWithFormat:@"业务类别：%@",[record objectForKey:@"cptc_kindtype_name"]];
            
            
            _tableDatas = [[NSMutableArray alloc] init];
            
            for (NSDictionary *item in [record objectForKey:@"item_list"]) {
                [_tableDatas addObject:item];
            }
        }
        [_tableView reloadData];
    }
    else{
        if (![[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"创建失败"];
        }
        else{
            _rootViewController = [[RootViewController alloc] init];
            [self presentViewController:_rootViewController animated:NO completion:nil];
            [_rootViewController showInProcessDetail];
            _rootViewController.processDetailViewController.ispop = YES;
            _rootViewController.processDetailViewController.caseID = _caseID;
//            [self showHUDWithTextOnly:@"创建成功"];
//            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
