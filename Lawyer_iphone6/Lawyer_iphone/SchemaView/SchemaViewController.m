//
//  SchemaViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-31.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "SchemaViewController.h"

#import "HttpClient.h"
#import "CommomClient.h"

#import "SchemaCell.h"
#import "AppDelegate.h"
#import "SchemaRightViewController.h"

#import "SchemaTypeViewController.h"
#import "NSDate+Calendar.h"
#import "RevealViewController.h"

@interface SchemaViewController ()<CalendarViewDelegate,SchemaTypeViewControllerDelegate,RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_listHttpClient;
    
    NSMutableArray *_tableDatas;
    NSMutableSet *_indexSet;
    
    SchemaRightViewController *_schemaRightViewController;
    
    SchemaTypeViewController *_schemaTypeViewController;
    
    NSDate *_curDate;
    
    
    NSDate *_selectDate;
    HttpClient *_todayHttpClient;
    HttpClient *_httpClient;
}

@end

@implementation SchemaViewController

@synthesize calendarView = _calendarView;
@synthesize tableView = _tableView;


UIImage *_zhuanImage = nil;

+ (void)initialize{
    _zhuanImage = [UIImage imageNamed:@"schema_status_zhuan_logo.png"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:@"工作日程" color:nil];
    
//    _schemaRightViewController = [[SchemaRightViewController alloc] init];
//    [_schemaRightViewController setSchemaView:self];
//    [self setRightViewController:_schemaRightViewController];
//    [self setCenterViewController:self];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_schemaRightViewController.view removeFromSuperview];
}

- (void)touchNavRight:(UIButton*)button{
    if (button.tag == 0) {
        NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
        dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
        NSString *time = [dateFormatter stringFromDate:_calendarView.unitView.selectedDate];
        
        _schemaTypeViewController = [[SchemaTypeViewController alloc] init];
        _schemaTypeViewController.schemaType = SchemaTypeAdd;
        _schemaTypeViewController.delegate = self;
        _schemaTypeViewController.time = time;
        [self.navigationController pushViewController:_schemaTypeViewController animated:YES];
    }
    else if (button.tag == 1){
     //   [self showRight];
        [self.revealContainer showRight];
    }
    
}

- (NSDictionary*)listParam:(NSString*)startDate endDate:(NSString*)endDate{
    NSDictionary *dicFields = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"", @"sc_search_key",
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

- (void)setFlag:(NSDate*)curDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compsDate = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:curDate];
    NSInteger year = [compsDate year];
    NSInteger months = [compsDate month];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:curDate];
    
    
    NSString *startDate = [NSString stringWithFormat:@"%ld-%ld-%d",(long)year,(long)months,1];
    if (months+1>12) {
        year = year+1;
        months = 1;
    }
    else{
        months += 1;
    }
    
    NSString *endDate = [NSString stringWithFormat:@"%ld-%ld-%d",(long)year,(long)months,1];
    [self startRequestList:startDate endDate:endDate];
    
}

- (void)startRequestList:(NSString*)startDate endDate:(NSString*)endDate{
    NSString *userId = [[CommomClient sharedInstance] getAccount];
    NSDictionary *dicFields = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"", @"sc_search_key",
                               userId, @"userID",
                               startDate, @"sc_start_date",
                               endDate, @"sc_end_date",
                               nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"myScheduleLst", @"requestKey",
                         dicFields, @"fields",
                         nil];
    
    [_listHttpClient cancelRequest];
    _listHttpClient = nil;
    _listHttpClient = [[HttpClient alloc] init];
    _listHttpClient.delegate = self;
    [_listHttpClient startRequest:dic];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_add_btn.png"],@"image",nil,@"selectedImage", nil];
    NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
    NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
    [self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];
    
    _calendarView.delegate = self;
    
    _curDate = [NSDate date];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateView) name:@"logrefresh" object:nil];
    

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _calendarView.unitView.frame.size.height, self.view.frame.size.width,self.view.frame.size.height - _calendarView.unitView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 50;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    UINib *cellNib = [UINib nibWithNibName:@"SchemaCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"SchemaCell"];

    [self.view addSubview:_tableView];
    
    
    
    _tableDatas = [[NSMutableArray alloc] init];
    _indexSet = [[NSMutableSet alloc] init];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    [self setFlag:_curDate];
    
    //[self checkToday];
}

- (void)updateView{
//    if (_selectDate) {
//        [self setFlag:_selectDate];
//    }
//    else{
//        
//    }
    [self setFlag:_curDate];
}

- (void)schemaViewRefresh:(BOOL)isAdd{
    [_indexSet removeAllObjects];
    [_tableDatas removeAllObjects];
    [_tableView reloadData];
    
    if (isAdd) {
        [_calendarView.unitView reloadEventsWithDate:_selectDate];
    }
    else{
        [_calendarView.unitView clearEventsWithDate:_selectDate];
    }
    

    [self setFlag:_selectDate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *time = @"";
    if (_selectDate) {
        time = [self.view getPerTime:[formatter stringFromDate:_selectDate]];
    }
    else{
        time = [self.view getPerTime:[formatter stringFromDate:_curDate]];
    }
    
    
    NSDictionary *dicFields = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"", @"sc_search_key",
                               [[CommomClient sharedInstance] getAccount], @"userID",
                               time, @"sc_start_date",
                               time, @"sc_end_date",
                               nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"myScheduleLst", @"requestKey",
                         dicFields, @"fields",
                         nil];
    [_httpClient startRequest:dic];
    
    
    
}

- (void)checkToday{
    _todayHttpClient = [[HttpClient alloc] init];
    _todayHttpClient.delegate = self;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compsDate = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:_curDate];
    NSInteger year = [compsDate year];
    NSInteger months = [compsDate month];
    NSInteger day = [compsDate day];
    
    NSString *today = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)months,(long)day];
    //[self startRequestList:today endDate:today];
    NSString *userid = [[CommomClient sharedInstance] getAccount];
    
    NSDictionary *dicFields = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"", @"sc_search_key",
                               userid, @"userID",
                               today, @"sc_start_date",
                               today, @"sc_end_date",
                               nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"myScheduleLst", @"requestKey",
                         dicFields, @"fields",
                         nil];
    [_todayHttpClient startRequest:dic];
}



#pragma marl -- CalendarViewDelegate

- (void)view:(CalendarView*)calendarView frameChange:(CGRect)frame{
    _tableView.frame = CGRectMake(0, frame.size.height, self.view.frame.size.width,self.view.frame.size.height - frame.size.height);
}

- (void)view:(CalendarView*)calendarView switchMonth:(NSDate*)date{
    _curDate = date;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];

    NSDictionary *dicFields = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"", @"sc_search_key",
                               [[CommomClient sharedInstance] getAccount], @"userID",
                               dateString, @"sc_start_date",
                               dateString, @"sc_end_date",
                               nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"myScheduleLst", @"requestKey",
                         dicFields, @"fields",
                         nil];
    [_httpClient startRequest:dic];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compsDate = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:_curDate];
    NSInteger year  = [compsDate year];
    NSInteger months = [compsDate month];
    
    
    
    for (NSInteger i = 1; i <= [_curDate numberOfDaysInMonth]; i++) {
        NSString *tempDate = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)months,(long)i];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        [_calendarView.unitView clearEventsWithDate:[dateFormatter dateFromString:tempDate]];
        
    }
    [self setFlag:_curDate];
}

- (void)view:(CalendarView*)calendarView selectDay:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *time = [self.view getPerTime:[formatter stringFromDate:date]];
    _selectDate = date;
    
    NSDictionary *dicFields = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"", @"sc_search_key",
                               [[CommomClient sharedInstance] getAccount], @"userID",
                               time, @"sc_start_date",
                               time, @"sc_end_date",
                               nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"myScheduleLst", @"requestKey",
                         dicFields, @"fields",
                         nil];
    [_httpClient startRequest:dic];
}


#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

/*
 {
 "sc_address" = "";
 "sc_attation_days" = 45;
 "sc_case_id" = "\U81ea\U52a8\U83b7\U53d6";
 "sc_case_name" = "\U8bf7\U9009\U62e9\U6848\U4ef6";
 "sc_client_id" = "\U81ea\U52a8\U83b7\U53d6";
 "sc_client_name" = "\U81ea\U52a8\U83b7\U53d6";
 "sc_description" = "\U8fc7\U5934";
 "sc_end_date" = "2015-03-18 00:00";
 "sc_isConvert" = 1;
 "sc_is_private" = 1;
 "sc_schedule_id" = SC0001284;
 "sc_start_date" = "2015-03-18 00:00";
 "sc_title" = "\U5403\U996d";
 "sc_work_type" = 20;
 "sc_work_typeName" = "\U5176\U4ed6";
 },
 
 */


- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    [_tableDatas removeAllObjects];
    [_indexSet removeAllObjects];
    NSDictionary *dic = (NSDictionary*)responseObject;
    if (request == _listHttpClient) {
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        NSDate *today = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString  *todayString = [formatter stringFromDate:today];
        NSDate *todayDate = [formatter dateFromString:todayString];
        
        for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
            NSDate *startDate = [dateFormatter dateFromString:[item objectForKey:@"sc_start_date"]];
            NSDate *endData = [dateFormatter dateFromString:[item objectForKey:@"sc_end_date"]];
            
            NSString *startString = [formatter stringFromDate:startDate];
            NSString *endString = [formatter stringFromDate:endData];
            
            startDate = [formatter dateFromString:startString];
            endData = [formatter dateFromString:endString];
            
            NSDate *tempStart = [startDate earlierDate:todayDate];
            NSDate *tempEnd = [endData laterDate:todayDate];
            
            BOOL containt = NO;
            
            if ([tempStart isEqualToDate:startDate] && [tempEnd isEqualToDate:endData]) {
                containt = YES;
            }
            
            if ([startDate isEqualToDate:todayDate] || [endData isEqualToDate:todayDate] || containt) {
                if (![_indexSet containsObject:[item objectForKey:@"sc_schedule_id"]]) {
                    [_indexSet addObject:[item objectForKey:@"sc_schedule_id"]];
                    [_tableDatas addObject:item];
                }
            }
            
            [self processDate:startDate end:endData];
        }
        

    }
    else if (request == _todayHttpClient){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        
        for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
            NSDate *startDate = [dateFormatter dateFromString:[item objectForKey:@"sc_start_date"]];
            NSDate *endData = [dateFormatter dateFromString:[item objectForKey:@"sc_end_date"]];
            
            [self processDate:startDate end:endData];
            
            
            if (![_indexSet containsObject:[item objectForKey:@"sc_schedule_id"]]) {
                [_indexSet addObject:[item objectForKey:@"sc_schedule_id"]];
                [_tableDatas addObject:item];
            }
        }
        
    }
    else if (request == _httpClient){
        for (NSDictionary *item in [dic objectForKey:@"record_list"]) {
            
            
            
            if (![_indexSet containsObject:[item objectForKey:@"sc_schedule_id"]]) {
                [_indexSet addObject:[item objectForKey:@"sc_schedule_id"]];
                [_tableDatas addObject:item];
            }
        }
    }
    [self.tableView reloadData];
}

- (void)processDate:(NSDate*)startDate end:(NSDate*)endDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *startCompsDate = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:startDate];
    NSInteger startYear  = [startCompsDate year];
    NSInteger startMonths = [startCompsDate month];
    NSInteger startDay = [startCompsDate day];
    
    NSDateComponents *endCompsDate = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:endDate];
    NSInteger endYear  = [endCompsDate year];
    NSInteger endMonths = [endCompsDate month];
    NSInteger endDay = [endCompsDate day];
    
    NSDateComponents *compsDate = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:_curDate];
     NSInteger year  = [compsDate year];
    NSInteger months = [compsDate month];
    
    for (NSInteger y = startYear; y <= endYear; y++) {
        for (NSInteger m = startMonths ; m <= endMonths; m++) {
            for (NSInteger d = startDay; d <= endDay; d++) {
                NSString *tempDate = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)y,(long)m,(long)d];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                
                [_calendarView.unitView reloadEventsWithDate:[dateFormatter dateFromString:tempDate]];
            }
        }
    }
    
//    if (endMonths == startMonths) {
//        for (NSInteger i = startDay;i <= endDay; i++) {
//            NSString *tempDate = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)months,(long)i];
//            
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//            
//            [_calendarView.unitView reloadEventsWithDate:[dateFormatter dateFromString:tempDate]];
//        }
//        
//    }
//    else if (endMonths > startMonths || endYear > startYear) {
//        if (startMonths == months) {
//            
//            for (NSInteger i = startDay;i <= [_curDate numberOfDaysInMonth]; i++) {
//                NSString *tempDate = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)months,(long)i];
//                
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//                
//                [_calendarView.unitView reloadEventsWithDate:[dateFormatter dateFromString:tempDate]];
//            }
//        }
//        else{
//            for (NSInteger i = 1;i <= endDay; i++) {
//                NSString *tempDate = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)endYear,(long)endMonths,(long)i];
//                
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//                
//                [_calendarView.unitView reloadEventsWithDate:[dateFormatter dateFromString:tempDate]];
//            }
//        }
//    }
    
    
   
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableDatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchemaCell"];
    NSDictionary *item = (NSDictionary*)[_tableDatas objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [item objectForKey:@"sc_title"];
    if ([[item objectForKey:@"sc_case_name"] length] == 0) {
        cell.typeLabel.text = @"无相关案件";
    }
    else{
        cell.typeLabel.text = [item objectForKey:@"sc_case_name"];
    }
    
    
    NSString *startTime = [item objectForKey:@"sc_start_date"];
    
    
    
    NSString *endTime = [item objectForKey:@"sc_end_date"];
    
    if ([self.view isEqual:[self.view getPerTime:startTime] secondDate:[self.view getPerTime:endTime]]) {
        cell.startLabel.text = [self.view getLastTime:startTime];
        cell.endLabel.text = [self.view getLastTime:endTime];
    }
    else{
        cell.startLabel.text = [self.view getDate:startTime formatter:@"MM月dd日"];
        cell.endLabel.text = [self.view getDate:endTime formatter:@"MM月dd日"];
    }
    
    
    
    if ([[item objectForKey:@"sc_isConvert"] isEqualToString:@"1"]) {
        cell.logoImageView.image = _zhuanImage;
    }
    else{
        cell.logoImageView.image = [UIImage imageNamed:@"schema_status_mo_logo.png"];
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _schemaTypeViewController = [[SchemaTypeViewController alloc] init];
    _schemaTypeViewController.delegate = self;
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
     NSDictionary *item = (NSDictionary*)[_tableDatas objectAtIndex:indexPath.row];
    
    if (delegate.isShowInSchema) {
        if ([[item objectForKey:@"sc_isConvert"] isEqualToString:@"1"]) {
            [self showHUDWithTextOnly:@"已转存的日程不能转日志"];
            return;
        }
        
        
    }
   
    
    NSString *schemaId = [item objectForKey:@"sc_schedule_id"];
    _schemaTypeViewController.schemaType = SchemaTypeDetail;
    _schemaTypeViewController.schemaId = schemaId;
    _schemaTypeViewController.state = [item objectForKey:@"sc_isConvert"];
    [self.navigationController pushViewController:_schemaTypeViewController animated:YES];
    
   
   
}

@end
