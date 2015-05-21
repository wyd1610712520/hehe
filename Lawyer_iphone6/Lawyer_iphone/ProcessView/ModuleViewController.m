//
//  ModuleViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-23.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ModuleViewController.h"

#import "HttpClient.h"

#import "ModuleCell.h"

#import "ModuleSearchViewController.h"
#import "ProcessDetailViewController.h"

#import "ModulePreviewViewController.h"

#import "ProcessSelectedViewController.h"

@interface ModuleViewController ()<RequestManagerDelegate,ModuleSearchViewDelegate,SegmentViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    
    ProcessDetailViewController *_processDetailViewController;
    
    NSString *_cptc_description;
    NSString *_cptc_creator;
    NSString *_startTime;
    NSString *_endTime;
    NSString *_cptc_category;
    
    ModuleSearchViewController *_moduleSearchViewController;
    
    ModulePreviewViewController *_modulePreviewViewController;
    
    NSString *_searchName;
    NSString *_creator;
    
}

@end

@implementation ModuleViewController

- (void)touchSearchEvent{
    
    _moduleSearchViewController.delegate = self;
    [self.navigationController pushViewController:_moduleSearchViewController animated:YES];
    
    
}

- (void)returnModuleSearch:(NSString *)name creator:(NSString *)creator{
    _searchName = name;
    _creator = creator;
}

- (void)receivesModuleSearch:(NSNotification*)notification{
    self.segmentView.hidden = YES;
    
    NSDictionary *dic = (NSDictionary*)[notification object];
    
    [_httpClient startRequest:dic];
    
    CGRect frame = self.tableView.frame;
    frame.origin.y = 0;
    self.tableView.frame = frame;
}

- (void)receivesModuleback{
    self.segmentView.hidden = NO;
    CGRect frame = self.tableView.frame;
    frame.origin.y = self.segmentView.frame.size.height+self.segmentView.frame.origin.y+5;
    self.tableView.frame = frame;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"选择进程模板" color:nil];
    
    _moduleSearchViewController = [[ModuleSearchViewController alloc] init];
    
    _searchName = @"";
    _creator = @"";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesModuleSearch:) name:ModuleSearch object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesModuleback) name:ModuleBack object:nil];
    
    [self setRightButton:nil title:@"搜索" target:self action:@selector(touchSearchEvent)];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _cptc_category =@"";
    _cptc_description = @"";
    _cptc_creator = @"";
    _startTime = @"";
    _endTime = @"";
    
    [self showSegment:[NSArray arrayWithObjects:@"全部模板",@"所内模板",@"个人模板",@"常用模板", nil]];
    self.segmentView.delegate = self;
    [self showTable];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 88;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *cellNib = [UINib nibWithNibName:@"ModuleCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ModuleCell"];

    
}

- (NSDictionary*)requestParam:(NSString*)cptc_category{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:cptc_category,@"cptc_type",
                            _cptc_category,@"cptc_category",
                            _cptc_description,@"cptc_description",
                            _cptc_creator,@"cptc_creator",
                            _startTime,@"startTime",
                            _endTime,@"endTime", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"3000",@"pageSize",@"1",@"currentPage",@"processtmpllist",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    if (button.tag == 0) {
        [_httpClient startRequest:[self requestParam:@""]];
    }
    else if (button.tag == 1) {
        [_httpClient startRequest:[self requestParam:@"public"]];
    }
    else if (button.tag == 2) {
        [_httpClient startRequest:[self requestParam:@"person"]];
    }
    else if (button.tag == 3) {
        [_httpClient startRequest:[self requestParam:@"often"]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ModuleCell"];
    
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    NSString *name = [NSString stringWithFormat:@"%@",[item objectForKey:@"cptc_description"]];
    NSRange range = [name rangeOfString:_searchName];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:name];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        cell.titleLabel.attributedText = caseString;
    }
    else{
        cell.titleLabel.text = name;
    }
    
    NSString *creator = [NSString stringWithFormat:@"%@",[item objectForKey:@"cptc_creator"]];
    NSRange range1 = [creator rangeOfString:_creator];
    if (range1.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:creator];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
        cell.nameLabel.attributedText = caseString;
    }
    else{
        cell.nameLabel.text = creator;
    }
    //
    [cell.flagButton setTitle:[item objectForKey:@"cptc_itemcnt"] forState:UIControlStateNormal];
    
    cell.dateLabel.text = [item objectForKey:@"cptc_create_date"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    return [ModuleCell heightForRow:[item objectForKey:@"cptc_description"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    /*
     {
     "cptc_category" = FS;
     "cptc_category_name" = "\U3010\U975e\U8bc9\U3011\U4e13\U9879\U6cd5\U5f8b\U670d\U52a1";
     "cptc_create_date" = "2014-09-19";
     "cptc_creator" = "\U9093\U5929\U7136";
     "cptc_description" = "\U6d4b\U8bd5";
     "cptc_emp_name" = "\U9093\U5929\U7136";
     "cptc_id" = CPTC00000032;
     "cptc_is_often" = 1;
     "cptc_is_public" = 1;
     "cptc_itemcnt" = 2;
     "cptc_kindtype" = 0604;
     "cptc_kindtype_name" = "\U5916\U5546\U76f4\U63a5\U6295\U8d44\U4e0e\U5883\U5916\U6295\U8d44------\U5916\U5546\U6295\U8d44\U4f01\U4e1a\U7684\U91cd\U7ec4\U548c\U80a1\U6743\U8f6c\U8ba9";
     "cptc_memo" = "\U8303\U5fb7\U8428\U53d1\U6492\U65e6";
     }
     */
   // [[NSNotificationCenter defaultCenter] postNotificationName:ModulePost object:item];
   // [self.navigationController popViewControllerAnimated:YES];
    
    _modulePreviewViewController = [[ModulePreviewViewController alloc] init];
    _modulePreviewViewController.cptcID = [item objectForKey:@"cptc_id"];
    _modulePreviewViewController.caseID = _caseID;
    [self.navigationController pushViewController:_modulePreviewViewController animated:YES];
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    [self clearTableData];
    NSDictionary *dic = (NSDictionary*)responseObject;
    for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
        [self.tableDatas addObject:item];
    }
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
