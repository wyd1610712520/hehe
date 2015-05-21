//
//  EducationViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-15.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "EducationViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"

#import "ExperienceCell.h"

#import "ExperienceEditViewController.h"

@interface EducationViewController ()<RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    
    CommomClient *_commomClient;
    ExperienceEditViewController *_experienceEditViewController;
    
    HttpClient *_deleteHttpClient;
    
    NSIndexPath *_deleteIndexPath;
}



@end

@implementation EducationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setTitle:[Utility localizedStringWithTitle:@"education_nav_title"] color:nil];
    [self clearTableData];
    [_httpClient startRequest:[self requesParam]];
}

- (NSDictionary*)requesParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[_commomClient getValueFromUserInfo:@"userOffice"],@"officeID",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"usereducationlist",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isSet = YES;
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 115;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    UINib *cellNib = [UINib nibWithNibName:@"ExperienceCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ExperienceCell"];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _commomClient = [CommomClient sharedInstance];
    
    [self setRightButton:[UIImage imageNamed:@"nav_add_btn.png"] title:nil target:self action:@selector(touchAddEvent)];
    
    _deleteHttpClient = [[HttpClient alloc] init];
    _deleteHttpClient.delegate = self;
    
}

- (void)touchAddEvent{
    _experienceEditViewController = [[ExperienceEditViewController alloc] init];
    _experienceEditViewController.experienceState = EducationStateAdd;
    [self.navigationController pushViewController:_experienceEditViewController animated:YES];
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
        [_deleteHttpClient startRequest:[self deleteParam:@"education" upi_id:[mapping objectForKey:@"eed_id"]]];
        
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExperienceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExperienceCell"];
    NSDictionary *mapping = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    cell.firstLabel.text = [NSString stringWithFormat:@"%@ 至 %@",[self getDate:[mapping objectForKey:@"eed_start_date"] formatter:@"yyyy-MM-dd"],[self getDate:[mapping objectForKey:@"eed_end_date"] formatter:@"yyyy-MM-dd"]];
    cell.secondLabel.text = [mapping objectForKey:@"eed_school"];
    cell.thirdLabel.text = [mapping objectForKey:@"eed_education"];
    cell.foruthLabel.text = [mapping objectForKey:@"eed_level"];
    
    cell.firstHintLabel.text = @"时间:";
    cell.seconHintdLabel.text = @"学校:";
    cell.thirdHintLabel.text = @"专业:";
    cell.foruthHintLabel.text = @"学历:";
    
    
    return cell;
}

- (NSString*)getDate:(NSString*)string formatter:(NSString*)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:string];
    [dateFormatter setDateFormat:formatter];
    NSString *time = [dateFormatter stringFromDate:date];
    return time;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *mapping = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    _experienceEditViewController = [[ExperienceEditViewController alloc] init];
    _experienceEditViewController.experienceState = EducationStateEdit;
    _experienceEditViewController.educationMapping = mapping;
    [self.navigationController pushViewController:_experienceEditViewController animated:YES];
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    
    NSDictionary *setupMapping = (NSDictionary*)responseObject;
    
    [self.tableView reloadData];
   
    if (request == _httpClient) {
        [self.tableDatas removeAllObjects];
        for (NSDictionary *mapping in [setupMapping objectForKey:@"record_list"]) {
            [self.tableDatas addObject:mapping];
        }
        [self.tableView reloadData];
    }
    else if (request == _deleteHttpClient){
        if ([[setupMapping objectForKey:@"mgid"] isEqualToString:@"true"]) {
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
