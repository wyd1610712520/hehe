//
//  ClientDetailViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-9.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ClientDetailViewController.h"

#import "RevealViewController.h"

#import "HttpClient.h"
#import "CommomClient.h"

#import "NSString+Utility.h"

#import "ClientContactViewController.h"

#import "ClientDocViewController.h"

#import "VisiteAndCaseViewController.h"
#import "MapViewController.h"
#import "ClientIncreaseViewController.h"

@interface ClientDetailViewController ()<RequestManagerDelegate>{
    UIButton *_favoriteButton;
    
    HttpClient *_detailhttpClient;
    
    HttpClient *_favoriteHttpClient;
    HttpClient *_cancelHttpClient;

    ClientContactViewController *_clientContactViewController;
    
    ClientDocViewController *_clientDocViewController;
    
    VisiteAndCaseViewController *_visiteAndCaseViewController;
    MapViewController *_mapViewController;

}

@end

@implementation ClientDetailViewController

@synthesize clientId = _clientId;

@synthesize topView = _topView;

@synthesize clientNameLabel = _clientNameLabel;
@synthesize enNameLabel = _enNameLabel;
@synthesize dateLabel = _dateLabel;
@synthesize clientIDLabel = _clientIDLabel;
@synthesize classLabel = _classLabel;

@synthesize officeLabel = _officeLabel;
@synthesize clientTypeLabel = _clientTypeLabel;
@synthesize industryLabel = _industryLabel;
@synthesize guojiaLabel = _guojiaLabel;
@synthesize emailLabel = _emailLabel;
@synthesize webLabel = _webLabel;
@synthesize addressLabel = _addressLabel;

@synthesize record = _record;

- (IBAction)touchMapEvent:(id)sender{
    _mapViewController = [[MapViewController alloc] init];
    _mapViewController.address = _addressLabel.text;
    [self.navigationController pushViewController:_mapViewController animated:YES];
    [_mapViewController search];
}


- (NSDictionary*)favoriteParam{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"client",@"collect_type",
                         @"客户",@"collect_item_type",
                         _clientId,@"collect_key_id",
                         [[CommomClient sharedInstance] getAccount],@"userID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"addCollection",@"requestKey",
                           dic,@"fields",
                           nil];
    return param;
}

- (NSDictionary*)cancelFavoriteParam{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _clientId,@"collect_key_id",
                         [[CommomClient sharedInstance] getAccount],@"userID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"deleteCollection",@"requestKey",
                           dic,@"fields",
                           nil];
    return param;
}

- (NSDictionary*)requestDetail:(NSString*)clientID{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:clientID, @"clientID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"clientgetDetail",@"requestKey",
                           dic,@"fields",
                           nil];
    return param;
}

- (IBAction)touchProfileEvent:(id)sender{
//    ClientIncreaseViewController* clientIncreaseViewController = [[ClientIncreaseViewController alloc] init];
//
//    clientIncreaseViewController.record = _record;
//    clientIncreaseViewController.clientIncreaseType = ClientIncreaseTypeEdit;
//    [self.navigationController pushViewController:clientIncreaseViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setTitle:@"客户详情" color:nil];
    
    NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"favorite_normal.png"],@"image",[UIImage imageNamed:@"favorite_selected.png"],@"selectedImage", nil];
    NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
    
    NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
    _favoriteButton = [self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];
    
    _favoriteHttpClient = [[HttpClient alloc] init];
    _favoriteHttpClient.delegate = self;
    
    _cancelHttpClient = [[HttpClient alloc] init];
    _cancelHttpClient.delegate = self;

    
    _detailhttpClient = [[HttpClient alloc] init];
    _detailhttpClient.delegate = self;
    [_detailhttpClient startRequest:[self requestDetail:_clientId]];
    
    
    _clientContactViewController = [[ClientContactViewController alloc] init];
    
    _clientDocViewController = [[ClientDocViewController alloc] init];
    
    _visiteAndCaseViewController = [[VisiteAndCaseViewController alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesUserUpda) name:@"receivesUserUpda" object:nil];
    
}

- (void)receivesUserUpda{
    [_detailhttpClient startRequest:[self requestDetail:_clientId]];
}

- (void)touchNavRight:(UIButton*)button{
    if (button.tag == 0) {
        if (button.selected) {
            [_cancelHttpClient startRequest:[self cancelFavoriteParam]];
        }
        else{
            [_favoriteHttpClient startRequest:[self favoriteParam]];
            
        }
    }
    else if (button.tag == 1){
        [self.revealContainer showRight];
    }
    
}

- (IBAction)touchSegButtonEvent:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    if (tag == 0) {
        _clientContactViewController.clientID = [_record objectForKey:@"cl_client_id"];
        _clientContactViewController.clientContactType = ClientContactTypeNormal;
        [self.navigationController pushViewController:_clientContactViewController animated:YES];
    }
    else if (tag == 1){
        _clientContactViewController.clientID = [_record objectForKey:@"cl_client_id"];
        _clientContactViewController.clientContactType = ClientContactTypeRelate;
        [self.navigationController pushViewController:_clientContactViewController animated:YES];
        
    }
    else if (tag == 2){
        _clientDocViewController.clientID = [_record objectForKey:@"cl_client_id"];
        [self.navigationController pushViewController:_clientDocViewController animated:YES];
    }
    else if (tag == 3){
        _visiteAndCaseViewController.clientId = [_record objectForKey:@"cl_client_id"];
        _visiteAndCaseViewController.visiteAndCaseType = VisiteType;
        [self.navigationController pushViewController:_visiteAndCaseViewController animated:YES];
    }
    else if (tag == 4){
        _visiteAndCaseViewController.clientId = [_record objectForKey:@"cl_client_id"];
        _visiteAndCaseViewController.visiteAndCaseType = CaseStatType;
        [self.navigationController pushViewController:_visiteAndCaseViewController animated:YES];
    }

}

#pragma mark -- RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    NSString *mgid = [result objectForKey:@"mgid"];
    if (request == _favoriteHttpClient) {
        if ([mgid isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"收藏成功"];
            _favoriteButton.selected = YES;
    
        }
        else{
            [self showHUDWithTextOnly:@"收藏失败"];
            _favoriteButton.selected = NO;
        }
    }
    else if (request == _cancelHttpClient){
        if ([mgid isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"取消成功"];
            _favoriteButton.selected = NO;
        }
        else{
            [self showHUDWithTextOnly:@"取消失败"];
            _favoriteButton.selected = YES;
        }
    }
    else if (request == _detailhttpClient){
        if ([mgid isEqualToString:@"true"]) {
            NSDictionary *record = (NSDictionary*)[result objectForKey:@"record"];
            _record = record;
            _clientNameLabel.text = [record objectForKey:@"cl_client_name"];
            
            if ([[record objectForKey:@"cl_english_name"] length] == 0) {
                for (NSLayoutConstraint *constraint in _topView.constraints) {
                    if (constraint.firstItem == _topView && constraint.firstAttribute == NSLayoutAttributeHeight) {
                        constraint.constant = 73;
                    }
                }
            }
            else{
                for (NSLayoutConstraint *constraint in _topView.constraints) {
                    if (constraint.firstItem == _topView && constraint.firstAttribute == NSLayoutAttributeHeight) {
                        constraint.constant = 95;
                    }
                }
            }
            
            _enNameLabel.text = [record objectForKey:@"cl_english_name"];
            _dateLabel.text = [[record objectForKey:@"cl_create_date"] processTime:@"yyyy-MM-dd"];
            _clientIDLabel.text = [NSString stringWithFormat:@"客户编号：%@",[record objectForKey:@"cl_client_id"]];
            _classLabel.text = [record objectForKey:@"cl_import_client"];
            
            _officeLabel.text = [record objectForKey:@"cl_area"];
            _clientTypeLabel.text = [record objectForKey:@"cl_type"];
            _industryLabel.text = [record objectForKey:@"cl_industry"];
            _guojiaLabel.text = [record objectForKey:@"cl_guojia"];
            
            _emailLabel.text = [record objectForKey:@"cl_post_code"];
            _webLabel.text = [record objectForKey:@"cl_homepage"];
            
            _addressLabel.text = [record objectForKey:@"cl_address"];
            
            if ([[record objectForKey:@"cl_iscollect"] isEqualToString:@"0"]) {
                _favoriteButton.selected = NO;
            }
            else{
                _favoriteButton.selected = YES;
            }
        }
        else{
            [self showHUDWithTextOnly:@"请求失败"];
        }
    }

}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

/* detail response
 
 {
 mgid = true;
 msg = "";
 record =     {
 "cl_address" = "\U4e0a\U6d77\U5e02\U6d66\U4e1c\U65b0\U533a\U90ed\U5b88\U656c\U8def498\U53f7\U6d66\U4e1c\U8f6f\U4ef6\U56ed3\U53f7\U697c3216\U5ba4";
 "cl_area" = "\U4e0a\U6d77";
 "cl_area_id" = SH;
 "cl_client_id" = 0199;
 "cl_client_name" = 11232;
 "cl_create_date" = "2014-08-25 15:12:58";
 "cl_diqu" = "";
 "cl_english_name" = "";
 "cl_guojia" = "";
 "cl_guojia_id" = "";
 "cl_homepage" = "";
 "cl_import_client" = "";
 "cl_import_client_id" = "";
 "cl_industry" = "";
 "cl_industry_id" = "";
 "cl_iscollect" = 1;
 "cl_post_code" = "";
 "cl_type" = "\U6709\U9650\U8d23\U4efb\U516c\U53f8";
 "cl_type_id" = 17;
 };
 responsetime = "2015-01-09 20:58:59";
 }
 */


@end
