//
//  SchemaNewViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-25.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "SchemaNewViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"

#import "SchemaCell.h"

#import "SchemaTypeViewController.h"

@interface SchemaNewViewController ()<RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    
    SchemaTypeViewController *_schemaTypeViewController;
}


@end

@implementation SchemaNewViewController

@synthesize schemaRightType = _schemaRightType;

@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize searchKey = _searchKey;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    
    if (_schemaRightType == SchemaRightTypeNormal) {
        [self setTitle:[Utility localizedStringWithTitle:@"schema_tody_nan_title"] color:nil];
        [_httpClient startRequest:[self todayParam]];
    }
    else if (_schemaRightType == SchemaRightTypeSearch){
        [self setTitle:[Utility localizedStringWithTitle:@"schema_search_nan_title"] color:nil];
        if (_startTime.length == 0 ) {
            _startTime = @"";
        }
        if (_endTime.length == 0) {
            _endTime = @"";
        }
        if (_searchKey.length == 0) {
            _searchKey = @"";
        }
        
        [_httpClient startRequest:[self listParam:_startTime endDate:_endTime]];
    }
}

- (NSDictionary*)todayParam{
    NSDictionary *fileds = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"sc_search_key",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"currentAddScheduleLst",@"requestKey",fileds,@"fields", nil];
    return param;
}

- (NSDictionary*)listParam:(NSString*)startDate endDate:(NSString*)endDate{
    NSDictionary *dicFields = [NSDictionary dictionaryWithObjectsAndKeys:
                               _searchKey, @"sc_search_key",
                               [[CommomClient sharedInstance] getAccount], @"userID",
                               startDate, @"sc_start_date",
                               endDate, @"sc_end_date",
                               nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"myScheduleLst", @"requestKey",
                         dicFields, @"fields",
                         nil];
    return dic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 50;
    _searchKey = @"";
    
    UINib *cellNib = [UINib nibWithNibName:@"SchemaCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"SchemaCell"];

    _schemaTypeViewController = [[SchemaTypeViewController alloc] init];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
    NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
    return datas.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchemaCell"];
    NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
    NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
    
    NSDictionary *item = [datas objectAtIndex:indexPath.row];
    
    
    NSString *caseID = [NSString stringWithFormat:@"%@",[item objectForKey:@"sc_title"]];
    NSRange caseIDRange = [caseID rangeOfString:_searchKey];
    if (caseIDRange.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:caseID];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:caseIDRange];
        cell.titleLabel.attributedText = caseString;
    }
    else{
        cell.titleLabel.text = caseID;
    }
    cell.typeLabel.text = [item objectForKey:@"sc_client_name"];
    NSString *startTime = [item objectForKey:@"sc_start_date"];
    cell.startLabel.text = [self.view getLastTime:startTime];
    
    
    NSString *endTime = [item objectForKey:@"sc_end_date"];
    
    if ([self.view isEqual:[self.view getPerTime:startTime] secondDate:[self.view getPerTime:endTime]]) {
        cell.endLabel.text = [self.view getLastTime:endTime];
    }
    else{
        cell.endLabel.text = [self.view getDate:endTime formatter:@"MM月dd日"];
    }
    
    
    
    if ([[item objectForKey:@"sc_isConvert"] isEqualToString:@"1"]) {
        cell.logoImageView.image = [UIImage imageNamed:@"schema_status_zhuan_logo.png"];
    }
    else{
        cell.logoImageView.image = [UIImage imageNamed:@"schema_status_mo_logo.png"];

    }
    
    
    return cell;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
    return [temDic objectForKey:@"time"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *temDic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
    NSArray *datas = (NSArray*)[temDic objectForKey:@"data"];
    
    NSDictionary *item = [datas objectAtIndex:indexPath.row];
    
    _schemaTypeViewController = [[SchemaTypeViewController alloc] init];
    NSString *schemaId = [item objectForKey:@"sc_schedule_id"];
    _schemaTypeViewController.schemaType = SchemaTypeDetail;
    _schemaTypeViewController.schemaId = schemaId;
    _schemaTypeViewController.state = [item objectForKey:@"sc_isConvert"];
    [self.navigationController pushViewController:_schemaTypeViewController animated:YES];

    
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}


- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;
    [self clearTableData];
    
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
        NSString *time = [item objectForKey:@"sc_start_date"];
        time = [self.view getPerTime:time];
        if (![dates containsObject:time]) {
            [dates addObject:time];
        }
    }
    
    NSArray *tempDate = [dates sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *date1 = [formatter dateFromString:obj1];
        NSDate *date2 = [formatter dateFromString:obj2];
        
        return [date2 compare:date1];
    }];
    
    for (NSString *tmpTime in tempDate) {
        NSMutableArray *tempD = [[NSMutableArray alloc] init];
        for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
            NSString *time = [item objectForKey:@"sc_start_date"];
            time = [self.view getPerTime:time];

            if ([tmpTime isEqualToString:time]) {
                [tempD addObject:item];
            }
        }
        NSDictionary *temDic = [NSDictionary dictionaryWithObjectsAndKeys:tmpTime,@"time",tempD,@"data", nil];
        [self.tableDatas addObject:temDic];
    }

    
    [self.tableView reloadData];
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
