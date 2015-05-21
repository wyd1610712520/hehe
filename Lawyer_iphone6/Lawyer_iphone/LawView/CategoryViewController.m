//
//  CategoryViewController.m
//  Lawyer_iphone
//
//  Created by bitzsoft_mac on 15/3/22.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CategoryViewController.h"

#import "LawRuleCell.h"
#import "LawCell.h"

#import "HttpClient.h"
#import "WebViewController.h"

@interface CategoryViewController ()<SegmentViewDelegate,UITableViewDataSource,PullToRefreshDelegate,UITableViewDelegate,RequestManagerDelegate>{
    NSInteger _curTag;
    
    HttpClient *_httpClient;
    
    HttpClient *_searchHttpCLient;
    
    NSString *_lib;
    NSString *_key;
    
    NSInteger _paper;
    
    NSDictionary *_beidaDic;
    int curPage;
    NSMutableArray *_selectArr;
    NSString *_searchKey;
    NSString *_category;
}

@end

@implementation CategoryViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGRect frame = self.segmentView.frame;
    frame.origin.y = _headerView.frame.size.height;
    frame.size.width = self.view.frame.size.width-20;
    self.segmentView.frame = frame;
    
    CGRect frame1 = self.tableView.frame;
    frame1.origin.y = self.segmentView.frame.size.height+self.segmentView.frame.origin.y+10;
    frame1.size.height = self.view.frame.size.height - frame1.origin.y;
    self.tableView.frame = frame1;
}

- (NSDictionary*)beidaParam:(NSString*)lib key:(NSString*)key{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:lib,@"Library",@"Category",@"Property",key,@"ParentKey", nil];
    return param;
}

- (void)popSelf{
    _paper--;
    if (_paper<0) {
        _paper = 0;
    }
    if (_paper == 0) {
        [super popSelf];
    }
    else{
        
        if (_selectArr.count > 1) {
            
            NSDictionary *dic = [_selectArr lastObject];
            
            if (_paper == 1){
                [_httpClient startBeidaRequest:[self beidaParam:_lib key:@""] path:@"GetCategory"];
            }
            else{
                [_httpClient startBeidaRequest:[self beidaParam:_lib key:[dic objectForKey:@"key"]] path:@"GetCategory"];
                
            }
            
            [_selectArr removeLastObject];
            
        }
        else if ( _selectArr.count == 1){
            [_httpClient startBeidaRequest:[self beidaParam:_lib key:@""] path:@"GetCategory"];
            
            [_selectArr removeLastObject];
            
            
        }
        else{
            [_selectArr removeAllObjects];
            _paper = 0;
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectArr = [[NSMutableArray alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[_item objectForKey:@"gc_id"],@"key",[_item objectForKey:@"gc_name"],@"value", nil];
    
    [_selectArr addObject:dic];
    [self updateHint];
    _paper = 1;
    
    _searchHttpCLient= [[HttpClient alloc] init];
    _searchHttpCLient.delegate =self;
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate =self;
    
    [self setTitle:_navtitle color:nil];
   
    
    [self showSegment:[NSArray arrayWithObjects:@"下属分类",@"下属法规", nil]];
    self.segmentView.delegate = self;
    
    _searchKey = @"";
    _category = @"";
    
    _key = @"";
    _lib = [_item objectForKey:@"gc_id"];
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UINib *cellNib = [UINib nibWithNibName:@"LawCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawCell"];

}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    _curTag = button.tag;
    if (_curTag == 0) {
        self.topRefreshIndicator.pullToRefreshDelegate = nil;
        self.bottomRefreshIndicator.pullToRefreshDelegate = nil;
        
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UINib *cellNib = [UINib nibWithNibName:@"LawCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawCell"];
        
        if (_paper > 1) {
            NSDictionary *dic = [_selectArr lastObject];
            _key = [dic objectForKey:@"key"];
        }
        
        
        [_httpClient startBeidaRequest:[self beidaParam:_lib key:_key] path:@"GetCategory"];
    }
    else if (_curTag == 1){
        self.topRefreshIndicator.pullToRefreshDelegate = self;
        self.bottomRefreshIndicator.pullToRefreshDelegate = self;

        [self clearTableData];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        UINib *cellNib = [UINib nibWithNibName:@"LawRuleCell" bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LawRuleCell"];
        
        NSDictionary *dic = [_selectArr lastObject];
        
        [_searchHttpCLient startBeidaRequest:[self searchParam:[dic objectForKey:@"key"] searchkey:@""] path:@"LibraryRecordList"];
        
    }
    [self.tableView reloadData];
}
//http://124.192.33.50:6031/Db/LibraryRecordList?Library=CHL&PageSize=20&PageIndex=0&Model.Title=中国&Model.Category=03%2C04&Model.IssueDate=%7B%22Start%22%3A%222010-1-1%22%2C%22End%22%3A%222010-12-30%22%7D
- (NSDictionary*)searchParam:(NSString*)category searchkey:(NSString*)searchkey{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"20",@"PageSize",[NSString stringWithFormat:@"%d",curPage],@"PageIndex",_lib,@"Library",category,@"Model.Category",searchkey,@"Model.Title", nil];
    return param;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_curTag == 0) {
        return _beidaDic.count;
    }
    else if (_curTag == 1){
        return self.tableDatas.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_curTag == 0) {
        LawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LawCell"];
        NSArray *titles = [_beidaDic allValues];
        cell.titleLabel.text = [titles objectAtIndex:indexPath.row];
        cell.logoImageView.image = [UIImage imageNamed:@"law_fa_logo.png"];
        return cell;
    }
    else if (_curTag == 1){
        LawRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LawRuleCell"];
        if (self.tableDatas.count > 0) {
            NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
            
//            NSString *title = [NSString stringWithFormat:@"<font size='4'>%@</font>",[item objectForKey:@"Title"]];
//            NSDictionary *textAttributes = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
//            
//            
//            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[title dataUsingEncoding:NSUnicodeStringEncoding] options:textAttributes documentAttributes:nil error:nil];
            
            cell.titleLabel.text = [item objectForKey:@"Title"];
            cell.timeLabel.text = [item objectForKey:@"IssueDate"];
        }

        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_curTag == 0) {
        return 50;
    }
    else if (_curTag == 1){
        return 75;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_curTag == 0) {
        _paper ++;
        NSArray *titles = [_beidaDic allKeys];
        NSArray *values = [_beidaDic allValues];
        [_httpClient startBeidaRequest:[self beidaParam:_lib key:[titles objectAtIndex:indexPath.row]] path:@"GetCategory"];
        NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:[titles objectAtIndex:indexPath.row],@"key",[values objectAtIndex:indexPath.row],@"value", nil];
        [_selectArr addObject:dic];
    }
    else if (_curTag == 1){
        
        
        NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
        NSString *library = _lib;
        NSString *gid = [item objectForKey:@"Gid"];
        
        NSString *strUrl = [NSString stringWithFormat:@"http://www.elinklaw.com/zsglmobile/lawrule_view.htm?library=%@&gid=%@&word=", library, gid];
    
        
        WebViewController* _webViewController = [[WebViewController alloc] init];
        _webViewController.path = strUrl;
        _webViewController.title = @"法律法规正文";
        [self.navigationController pushViewController:_webViewController animated:YES];

    }
}

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    if (request == _httpClient){
        if ([[result objectForKey:@"Data"] count] == 0) {
            _paper--;
            
//            [self showHUDWithTextOnly:@"该法库下没有内容!"];
            UIButton *btn = (UIButton*)[self.segmentView.buttons objectAtIndex:1];
            [self didClickSegment:self.segmentView button:btn];
            [self.segmentView clickSegment:btn];
            [_selectArr removeLastObject];
        }
        else{
            _beidaDic = [result objectForKey:@"Data"];
            [self.tableView reloadData];
        }
        [self updateHint];
    }
    else{
         NSDictionary *record = [result objectForKey:@"Data"];
//        NSLog(@"num====%d",[[record objectForKey:@"Collection"] count]);
        for (NSDictionary *item in [record objectForKey:@"Collection"]) {
            [self.tableDatas addObject:item];
        }
        
        [self.topRefreshIndicator didLoadComplete:nil];
        [self.bottomRefreshIndicator didLoadComplete:nil];
        [self.tableView reloadData];
    }
    
    
}

- (void)updateHint{
    NSMutableString *ti = [[NSMutableString alloc] initWithFormat:@""];
    for (NSDictionary *item in _selectArr) {
        [ti appendFormat:@"%@>",[item objectForKey:@"value"]];
    }
    _hintLabel.text = ti;
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_curTag == 1) {
        [self.topRefreshIndicator didPull];
        if (self.tableDatas.count == 0) {
            return;
        }
        
        
        [self.bottomRefreshIndicator didPull];
    }
   
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_curTag == 1) {
        [self.topRefreshIndicator didPullReleased];
        if (self.tableDatas.count == 0) {
            return;
        }
        [self.bottomRefreshIndicator didPullReleased];
    }
    
}

- (void)didStartLoading:(PullToRefreshIndicator*)indicator{
    if (_curTag == 1) {
        if (indicator == self.topRefreshIndicator) {
            curPage = 0;
            [self clearTableData];
        }
        else{
            curPage = 1 + curPage;
        }
        NSDictionary *dic = [_selectArr lastObject];
        
        [_searchHttpCLient startBeidaRequest:[self searchParam:[dic objectForKey:@"key"] searchkey:@""] path:@"LibraryRecordList"];
    }
    
   
}


@end
