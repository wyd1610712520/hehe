//
//  LawResultViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-21.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "LawResultViewController.h"
#import "LawRuleCell.h"
#import "HttpClient.h"
#import "WebViewController.h"

#import "LawHotCell.h"

#import "BeidaSearchViewController.h"

@interface LawResultViewController ()<RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_latelyHttpClient;
    HttpClient *_hotHttpClient;
    HttpClient *_historyHttpClient;
    
    WebViewController *_webViewController;
    
    BeidaSearchViewController *_beidaSearchViewController;
}

@end

@implementation LawResultViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _latelyHttpClient = [[HttpClient alloc] init];
    _latelyHttpClient.delegate = self;
    
    _hotHttpClient = [[HttpClient alloc] init];
    _hotHttpClient.delegate = self;
    
    _historyHttpClient = [[HttpClient alloc] init];
    _historyHttpClient.delegate = self;
    
    if (_lawResultType == LawResultTypeNormal) {
        if ([_requestKey isEqualToString:@"Lawrulehistorylst"]) {
            [self setTitle:@"最近浏览" color:nil];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"currentPage",@"1000",@"pageSize",@"Lawrulehistorylst",@"requestKey", nil];
            [_latelyHttpClient startRequest:dic];
            
            [self showTable];
            self.tableView.dataSource = self;
            self.tableView.delegate = self;
            self.tableView.rowHeight = 75;
            self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            
            
            CGRect frame = self.tableView.frame;
            frame.size.width = [UIScreen mainScreen].bounds.size.width;
            self.tableView.frame = frame;
            
            UINib *cellNib = [UINib nibWithNibName:@"LawRuleCell" bundle:nil];
            [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawRuleCell"];
        }
        else if ([_requestKey isEqualToString:@"lawrulehotsearchlst"]) {
            [self setTitle:@"搜索热词" color:nil];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"lawrulehotsearchlst",@"requestKey", nil];
            [_hotHttpClient startRequest:dic];
            
            
            [self showTable];
            self.tableView.dataSource = self;
            self.tableView.delegate = self;
            self.tableView.rowHeight = 75;
            self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            
            CGRect frame = self.tableView.frame;
            frame.size.width = [UIScreen mainScreen].bounds.size.width;
            self.tableView.frame = frame;
            UINib *cellNib = [UINib nibWithNibName:@"LawHotCell" bundle:nil];
            [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawHotCell"];

        }
        else if ([_requestKey isEqualToString:@"Lawrulesearchhistorylst"]) {
            [self setTitle:@"搜索历史" color:nil];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"lawrulehotsearchlst",@"requestKey", nil];
            [_historyHttpClient startRequest:dic];
            
            
            [self showTable];
            self.tableView.dataSource = self;
            self.tableView.delegate = self;
            self.tableView.rowHeight = 75;
            self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            UINib *cellNib = [UINib nibWithNibName:@"LawHotCell" bundle:nil];
            [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawHotCell"];
        }
        
        
        
    }
    else if (_lawResultType == LawResultTypeSearch){
        
    }
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_lawResultType == LawResultTypeNormal) {
        if ([_requestKey isEqualToString:@"Lawrulehistorylst"]) {
            return 75;
            
        }
        else if ([_requestKey isEqualToString:@"lawrulehotsearchlst"]) {
            return 63;
        }
        else if ([_requestKey isEqualToString:@"Lawrulesearchhistorylst"]) {
            return 63;
            
        }
        
    }
    else if (_lawResultType == LawResultTypeSearch){
        return 63;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_lawResultType == LawResultTypeNormal) {
        if ([_requestKey isEqualToString:@"Lawrulehistorylst"]) {
            
            LawRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LawRuleCell"];
            NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
            
            NSString *title = [NSString stringWithFormat:@"<font size='4'>%@</font>",[item objectForKey:@"Title"]];
            NSDictionary *textAttributes = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[title dataUsingEncoding:NSUnicodeStringEncoding] options:textAttributes documentAttributes:nil error:nil];
            cell.titleLabel.attributedText = attrStr;
            
            cell.timeLabel.text = [item objectForKey:@"IssueDate"];
            cell.companyLabel.text = [self checkType:[item objectForKey:@"Lib"]];
            return cell;
        
        }
        else if ([_requestKey isEqualToString:@"lawrulehotsearchlst"]) {
            LawHotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LawHotCell"];
            NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
            
            cell.titleLabel.text = [item objectForKey:@"SearchKey"];
            cell.detaiLabel.text = [NSString stringWithFormat:@"搜素法库：%@",[self checkType:[item objectForKey:@"Lib"]]];
            [cell.recordButton setTitle:[item objectForKey:@"Count"] forState:UIControlStateNormal];
            
            return cell;

        }
        else if ([_requestKey isEqualToString:@"Lawrulesearchhistorylst"]) {
            LawHotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LawHotCell"];
            NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
            
            cell.titleLabel.text = [item objectForKey:@"SearchKey"];
            cell.detaiLabel.text = [NSString stringWithFormat:@"搜素法库：%@",[self checkType:[item objectForKey:@"Lib"]]];
            cell.recordButton.hidden = YES;
            return cell;
        
        }
        
    }
    else if (_lawResultType == LawResultTypeSearch){
       
    }

    
    return nil;

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_lawResultType == LawResultTypeNormal) {
        if ([_requestKey isEqualToString:@"Lawrulehistorylst"]) {
            NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
            NSString *library = [item objectForKey:@"Lib"];
            NSString *gid = [item objectForKey:@"Gid"];
            
            NSString *strUrl = [NSString stringWithFormat:@"http://www.elinklaw.com/zsglmobile/lawrule_view.htm?library=%@&gid=%@&word=", library, gid];
            
            _webViewController = [[WebViewController alloc] init];
            _webViewController.path = strUrl;
            _webViewController.title = @"法律法规正文";
            [self.navigationController pushViewController:_webViewController animated:YES];
            
        }
        else if ([_requestKey isEqualToString:@"lawrulehotsearchlst"]) {
            NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
            _beidaSearchViewController = [[BeidaSearchViewController alloc] init];
            _beidaSearchViewController.lib = [item objectForKey:@"Lib"];
            _beidaSearchViewController.category = @"";
            _beidaSearchViewController.searchKey = [item objectForKey:@"SearchKey"];
            [self.navigationController pushViewController:_beidaSearchViewController animated:YES];

        }
        else if ([_requestKey isEqualToString:@"Lawrulesearchhistorylst"]) {
            NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
            _beidaSearchViewController = [[BeidaSearchViewController alloc] init];
            _beidaSearchViewController.lib = [item objectForKey:@"Lib"];
            _beidaSearchViewController.category = @"";
            _beidaSearchViewController.searchKey = [item objectForKey:@"SearchKey"];
            [self.navigationController pushViewController:_beidaSearchViewController animated:YES];
        }
        
    }
    else if (_lawResultType == LawResultTypeSearch){
        
    }
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
    [self.view bringSubviewToFront:self.progressHUD];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    [self clearTableData];
    NSDictionary *result = (NSDictionary*)responseObject;
    if (request == _latelyHttpClient){
        for (NSDictionary *item in [result objectForKey:@"record_list"]) {
            [self.tableDatas addObject:item];
        }
    }
    else if (request == _hotHttpClient){
        for (NSDictionary *item in [result objectForKey:@"record_list"]) {
            [self.tableDatas addObject:item];
        }
    }
    else if (request == _historyHttpClient){
        for (NSDictionary *item in [result objectForKey:@"record_list"]) {
            [self.tableDatas addObject:item];
        }
    }
    
    [self.topRefreshIndicator didLoadComplete:nil];
    [self.bottomRefreshIndicator didLoadComplete:nil];
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}


- (NSString*)checkType:(NSString*)type{
    NSString *company = @"";
    if ([type isEqualToString:@"AOM"]) {
        company = @"澳门法律法规";
    }
    else if ([type isEqualToString:@"ATR"]) {
        company = @"仲裁案例";
    }
    else if ([type isEqualToString:@"CHL"]) {
        company = @"中央法规司法解释";
    }
    else if ([type isEqualToString:@"CON"]) {
        company = @"合同范本";
    }
    else if ([type isEqualToString:@"EAGN"]) {
        company = @"中外条约";
    }
    else if ([type isEqualToString:@"FMT"]) {
        company = @"文书范本";
    }
    else if ([type isEqualToString:@"HKD"]) {
        company = @"香港法律法规";
    }
    else if ([type isEqualToString:@"IEL"]) {
        company = @"外国法律法规";
    }
    else if ([type isEqualToString:@"LAR"]) {
        company = @"地方法规规章";
    }
    else if ([type isEqualToString:@"LFBJ"]) {
        company = @"立法背景资料";
    }
    else if ([type isEqualToString:@"NEWS"]) {
        company = @"法律动态";
    }
    else if ([type isEqualToString:@"PAL"]) {
        company = @"案例报道";
    }
    else if ([type isEqualToString:@"PAYZ"]) {
        company = @"案例要旨";
    }
    else if ([type isEqualToString:@"PCAS"]) {
        company = @"公报案例";
    }
    else if ([type isEqualToString:@"PFNL"]) {
        company = @"司法案例";
    }
    else if ([type isEqualToString:@"TWD"]) {
        company = @"台湾法律法规";
    }
    return company;
}
@end
