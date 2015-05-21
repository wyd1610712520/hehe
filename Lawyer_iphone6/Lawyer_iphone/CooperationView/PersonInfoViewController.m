//
//  PersonInfoViewController.m
//  Lawyer_iphone
//
//  Created by bitzsoft_mac on 15/3/14.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "PersonInfoViewController.h"

#import "HttpClient.h"

#import "UIButton+AFNetworking.h"


@interface PersonInfoViewController ()<RequestManagerDelegate,UITableViewDataSource>{
    HttpClient *_httpClient;
    NSDictionary *_record;
    
    NSArray *_datas;
}

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"用户信息" color:nil];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    _httpClient.isChange = YES;
    [_httpClient startRequest:[self getProfileParam]];
}


- (NSDictionary*)getProfileParam{
    NSDictionary *fileds = [NSDictionary dictionaryWithObjectsAndKeys:_rdi_creator,@"rdi_resume_id", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"cooperationresume",@"requestKey",fileds,@"fields", nil];
    return param;
}



- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    _record = [dic objectForKey:@"record"];
    NSString *url = [_record objectForKey:@"rdi_resume_photo"];
    
    [_avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:url]];
    _avatorButton.layer.borderWidth = 0;
    _avatorButton.layer.borderColor = [UIColor clearColor].CGColor;
    _nameLabel.text = [_record objectForKey:@"rdi_resume_name"];
    _jobLabel.text = [_record objectForKey:@"rdi_resume_category"];
    _deLabel.text = [_record objectForKey:@"rdi_resume_office"];
    _contentLabel.text = [_record objectForKey:@"rdi_resume_project"];
     
    _datas = [_record objectForKey:@"zy_list"];
    

    
    _tableHeight.constant = _datas.count*44;
    
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CGSize size = CGSizeMake(self.view.frame.size.width - 20, 20000);
    
    NSDictionary *textAttributes = @{NSFontAttributeName: font};
    
    
    CGRect labelsize = [[_record objectForKey:@"rdi_resume_project"] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
    
    _viewHeight.constant = labelsize.size.height+self.view.frame.size.height;
    
    
    [_tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    NSDictionary *item = (NSDictionary*)[_datas objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [item objectForKey:@"zy_name"];
    
    
    
    return cell;
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
