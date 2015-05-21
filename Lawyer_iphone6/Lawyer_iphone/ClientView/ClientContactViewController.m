//
//  ClientContactViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-9.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ClientContactViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"

#import "ClientContactCell.h"
#import "ClientContactPersonCell.h"

#import "ClientContactNewViewController.h"

#import "ClientContactAddViewController.h"

#import "MapViewController.h"


@interface ClientContactViewController ()<RequestManagerDelegate,ClientContactPersonCellDelegate,UIAlertViewDelegate,ClientContactCellDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_contactHttpClient;
    
    HttpClient *_contactPersonHttpClient;
    
    NSString *_path;
    
    ClientContactNewViewController *_clientContactNewViewController;
    
    ClientContactAddViewController *_clientContactAddViewController;
    MapViewController *_mapViewController;
}

@end

@implementation ClientContactViewController

@synthesize clientID = _clientID;

@synthesize clientContactType = _clientContactType;

@synthesize hintView = _hintView;
@synthesize titleLabel = _titleLabel;
@synthesize sureButton = _sureButton;


- (NSDictionary*)requestParam:(NSString*)key{
    NSDictionary *field = [NSDictionary dictionaryWithObjectsAndKeys:_clientID,@"clientID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:key,@"requestKey",field,@"fields", nil];
    return param;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self clearTableData];
    
    if (_clientContactType == ClientContactTypeNormal) {
        [self setTitle:@"联系人信息" color:nil];
        
        UINib *cellNib = [UINib nibWithNibName:@"ClientContactCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ClientContactCell"];
       
        [_contactHttpClient startRequest:[self requestParam:@"clientgetDetailLinker"]];
        
    }
    else if (_clientContactType == ClientContactTypeRelate){
        [self setTitle:@"关联客户信息" color:nil];
        
        UINib *cellNib = [UINib nibWithNibName:@"ClientContactPersonCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ClientContactPersonCell"];
        
        [_contactPersonHttpClient startRequest:[self requestParam:@"clientgetDetailRelation"]];
        
    }

}

- (IBAction)touchSureEvent:(UIButton*)sender{
    [self touchAddEvent];
}

- (void)touchAddEvent{
    if (_clientContactType == ClientContactTypeNormal) {
        _clientContactNewViewController = [[ClientContactNewViewController alloc] init];
        _clientContactNewViewController.clientId = _clientID;
        _clientContactNewViewController.clientContactState = ClientContactStateNormal;
        [self.navigationController pushViewController:_clientContactNewViewController animated:YES];
    }
    else if (_clientContactType == ClientContactTypeRelate){
        _clientContactAddViewController = [[ClientContactAddViewController alloc] init];
        _clientContactAddViewController.clientAddState = ClientAddStateNormal;
        _clientContactAddViewController.clientID = _clientID;
        [self.navigationController pushViewController:_clientContactAddViewController animated:YES];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self setRightButton:[UIImage imageNamed:@"nav_add_btn.png"] title:nil target:self action:@selector(touchAddEvent)];
    
    _contactHttpClient = [[HttpClient alloc] init];
    _contactHttpClient.delegate = self;
    
    _contactPersonHttpClient = [[HttpClient alloc] init];
    _contactPersonHttpClient.delegate = self;
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    

}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_clientContactType == ClientContactTypeNormal) {
        ClientContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientContactCell"];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [cell setClientContactType:ClientContactTypeNormal];
        
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        cell.tag = indexPath.section;
        cell.namaLabel.text = [item objectForKey:@"clr_linker"];
        cell.dutyLabel.text = [item objectForKey:@"clr_duty"];
        cell.phoneLabel.text = [item objectForKey:@"clr_phone"];
        cell.telePhoneLabel.text = [item objectForKey:@"clr_combined"];
        cell.emailLabel.text = [item objectForKey:@"clr_email1"];
        cell.faxLabel.text = [item objectForKey:@"clr_fax"];
        cell.commentLabel.text = [item objectForKey:@"clr_memo"];
        return cell;
    }
    else if (_clientContactType == ClientContactTypeRelate){
        ClientContactPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientContactPersonCell"];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        cell.tag = indexPath.section;
        
        cell.nameLabel.text = [item objectForKey:@"ccri_name"];
        cell.fristLabel.text = [item objectForKey:@"ccri_type_name"];
        cell.secondLabel.text = [item objectForKey:@"ccri_linker"];
        cell.thirdLabel.text = [item objectForKey:@"ccri_phone"];
        cell.fourthLabel.text = [item objectForKey:@"ccri_address"];
        cell.fifthLabel.text = [item objectForKey:@"ccri_fax"];
        cell.sixLabel.text = [item objectForKey:@"ccri_email"];
        return cell;
    }
    return nil;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_clientContactType == ClientContactTypeNormal) {
        return @"联系人";
    }
    else if (_clientContactType == ClientContactTypeRelate){
        return @"关联客户";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_clientContactType == ClientContactTypeNormal) {
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
        return [ClientContactCell heightForRow:[item objectForKey:@"clr_memo"]];
    }
    return 407;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
//    if (_clientContactType == ClientContactTypeNormal) {
//        
//        _clientContactNewViewController = [[ClientContactNewViewController alloc] init];
//        _clientContactNewViewController.clientId = _clientID;
//        _clientContactNewViewController.record = item;
//        _clientContactNewViewController.clr_line = [item objectForKey:@"clr_line"];
//        _clientContactNewViewController.clientContactState = ClientContactStateEdit;
//        [self.navigationController pushViewController:_clientContactNewViewController animated:YES];
//
//        
//    }
//    else if (_clientContactType == ClientContactTypeRelate){
//        
//        _clientContactAddViewController = [[ClientContactAddViewController alloc] init];
//        _clientContactAddViewController.clientAddState = ClientAddStateEdit;
//        _clientContactAddViewController.clientID = _clientID;
//        _clientContactAddViewController.ccri_line = [item objectForKey:@"ccri_line"];
//        _clientContactAddViewController.record = item;
//        [self.navigationController pushViewController:_clientContactAddViewController animated:YES];
//       
//    }
}

- (void)didPhoneEvent:(NSString *)tag{
    _path = [NSString stringWithFormat:@"tel://%@",tag];
    [self showPhoneAlert];
}

- (void)didLocationEvent:(NSString *)tag{
    _mapViewController = [[MapViewController alloc] init];
    _mapViewController.address = tag;
    [self.navigationController pushViewController:_mapViewController animated:YES];
    [_mapViewController search];
}

- (void)didEmailEvent:(NSString *)tag{
    if (tag.length > 0) {
        if ([tag isValidateEmail:tag]) {
            NSString *path = [NSString stringWithFormat:@"mailto://%@",tag];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
        }
        else{
            [self showHUDWithTextOnly:@"邮箱格式错误"];
        }
        
    }
    else{
        [self showHUDWithTextOnly:@"该用户无邮箱"];
    }
    
}

- (void)didTouchMobleEvent:(NSString*)tag{
    _path = [NSString stringWithFormat:@"tel://%@",tag];
    [self showPhoneAlert];
}

- (void)didTouchPhoneEvent:(NSString*)tag{
    _path = [NSString stringWithFormat:@"tel://%@",tag];
    [self showPhoneAlert];
}

- (void)didTouchMessageEvent:(NSString*)tag{
    NSString *path = [NSString stringWithFormat:@"sms://%@",tag];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
    
}

- (void)didTouchEmailEvent:(NSString*)tag{

    if ([tag isValidateEmail:tag]) {
        NSString *path = [NSString stringWithFormat:@"mailto://%@",tag];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
        
    }
    else{
        [self showHUDWithTextOnly:@"邮箱格式错误"];
    }
    
}


- (void)showPhoneAlert{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否拨打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_path]];
    }
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    
    [self clearTableData];
    
    [self.tableDatas removeAllObjects];
    
    if (request == _contactHttpClient) {
        if ([[result objectForKey:@"record_list"] count] > 0) {
            for (NSDictionary *item in [result objectForKey:@"record_list"]) {
                [self.tableDatas addObject:item];
            }
            [_hintView removeFromSuperview];
        }
        else{
//            _titleLabel.text = @"没有客户联系人信息";
//            [_sureButton setTitle:@"创建客户联系人" forState:UIControlStateNormal];
//            _hintView.frame = self.view.bounds;
//            [self.view addSubview:_hintView];
        }
    }
    else if (request == _contactPersonHttpClient){
        if ([[result objectForKey:@"record_list"] count] > 0) {
            for (NSDictionary *item in [result objectForKey:@"record_list"]) {
                [self.tableDatas addObject:item];
            }
            [_hintView removeFromSuperview];
        }
        else{
//            _titleLabel.text = @"没有关联客户信息";
//            [_sureButton setTitle:@"创建关联客户" forState:UIControlStateNormal];
//            _hintView.frame = self.view.bounds;
//            [self.view addSubview:_hintView];
        }
        
        
        
    }
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}


@end
