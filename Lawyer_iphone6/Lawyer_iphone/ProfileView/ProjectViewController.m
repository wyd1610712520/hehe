//
//  ProjectViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-15.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProjectViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"

#import "ProjectEditViewController.h"


@interface ProjectViewController ()<RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    
    HttpClient *_deleteHttpClient;
    NSIndexPath *_deleteIndexPath;
    
    ProjectEditViewController *_projectEditViewController;
}

@end

@implementation ProjectViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setTitle:[Utility localizedStringWithTitle:@"project_nav_title"] color:nil];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    [_httpClient startRequest:[self param]];
}

- (NSDictionary*)param{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            [[CommomClient sharedInstance] getAccount],@"userID",
                            [[CommomClient sharedInstance] getValueFromUserInfo:@"userOffice"],@"user_officeID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"userprojectexperiencelist",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)touchAddEvent{
    _projectEditViewController = [[ProjectEditViewController alloc] init];
    _projectEditViewController.projectState = ProjectStateAdd;
    [self.navigationController pushViewController:_projectEditViewController animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isSet = YES;
    [self setRightButton:[UIImage imageNamed:@"nav_add_btn.png"] title:nil target:self action:@selector(touchAddEvent)];
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 50;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _deleteHttpClient = [[HttpClient alloc] init];
    _deleteHttpClient.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *mapping = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        
        _deleteIndexPath = indexPath;
        [_deleteHttpClient startRequest:[self deleteParam:@"projectexper" upi_id:[mapping objectForKey:@"gc_id"]]];
        
    }
    
}

- (NSDictionary*)deleteParam:(NSString*)type upi_id:(NSString*)upi_id{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:upi_id,@"upi_id",
                            type,@"upi_type",
                            [[CommomClient sharedInstance] getAccount],@"userID",
                            @"",@"user_officeID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"userpartinfodelete",@"requestKey",fields,@"fields", nil];
    return param;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    }
    NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"gc_name"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.numberOfLines = 0;
    [cell sizeToFit];
    //cell.detailTextLabel.text = [dic objectForKey:@"gc_id"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:@"gc_name"];
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CGSize size = CGSizeMake(self.view.frame.size.width, 1000);
    CGSize labelsize = [title sizeWithFont:font constrainedToSize:size];
    return labelsize.height+75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    _projectEditViewController = [[ProjectEditViewController alloc] init];
    _projectEditViewController.projectState = ProjectStateEdit;
    _projectEditViewController.pro_id = [dic objectForKey:@"gc_id"];
    _projectEditViewController.pro_name = [dic objectForKey:@"gc_name"];
    [self.navigationController pushViewController:_projectEditViewController animated:YES];
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
   
    NSDictionary *dic = (NSDictionary*)responseObject;
   
    if (request == _httpClient) {
         [self.tableDatas removeAllObjects];
        NSArray *datas = [dic objectForKey:@"record_list"];
        if (datas.count > 0) {
            for (NSDictionary *dic  in datas) {
                [self.tableDatas addObject:dic];
            }
        }
        else{
            
        }
        [self.tableView reloadData];
    }
    else if (request == _deleteHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"删除成功"];
            [self.tableDatas removeObjectAtIndex:_deleteIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_deleteIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }
        else{
            [self showHUDWithTextOnly:@"删除失败"];
        }
    }
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
