//
//  CooperationViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CooperationViewController.h"

#import "CooperationCell.h"

#import "CooperationRightViewController.h"

#import "CloseView.h"

#import "CooperationDetailViewController.h"

#import "NSString+Utility.h"

#import "HttpClient.h"
#import "ShareViewController.h"
#import "RevealViewController.h"
#import "CommomClient.h"
#import "RootViewController.h"

#import "CooperationNewViewController.h"

#import "AlertView.h"

@interface CooperationViewController ()<UITableViewDataSource,CooperationRightViewControllerDelegate,UITableViewDelegate,SegmentViewDelegate,PullToRefreshDelegate,AlertViewDelegate,RequestManagerDelegate,CooperationCellDelegate>{
    CooperationRightViewController *_cooperationRightViewController;
    
    HttpClient *_httpClient;
    
    HttpClient *_seHttpClient;
    
    NSArray *_draws;
    
    UIView *_currentView;
    CloseView *_closeView;
    
    CooperationDetailViewController *_cooperationDetailViewController;
    
    int currentPage;
    
    HttpClient *_deleteHttpClient;
    
    
    NSString *_rdi_type;
    NSString *_rdi_order;
    
    NSString *_categoryID;
    NSString *_industryID;
    NSString *_regionID;
    NSString *_addressID;
    NSString *_searchKey;
    NSString *_startTime;
    NSString *_endTime;
    NSString *_request_area;
    
    NSString *_firstSelectTitle;
    NSString *_secondSelectTitle;
    
    RootViewController *_rootViewController;
    
    CooperationNewViewController *_cooperationNewViewController;
    
    CGFloat _height;
    
    NSIndexPath *_deleteIndexPath;
    
    ShareViewController *_shareViewController;
    
    NSString *_searchname;
    NSString *_categoryname;
    NSString *_guojia;
    NSString *_need;
    
    UILabel *_tipLabel;
}

@end

@implementation CooperationViewController

@synthesize fristView = _fristView;
@synthesize secondView = _secondView;

@synthesize fristImageView = _fristImageView;
@synthesize secondImageView = _secondImageView;
@synthesize thirdImageView = _thirdImageView;
@synthesize fourthImageView = _fourthImageView;


@synthesize titleField = _titleField;
@synthesize needField = _needField;

- (void)setRootView:(RootViewController*)rootViewController{
    _rootViewController = rootViewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.segmentView.frame.size.height+10, self.view.frame.size.width, self.view.frame.size.height)];
    _tipLabel.backgroundColor = [UIColor whiteColor];
    _tipLabel.textColor = [UIColor blackColor];
    _tipLabel.font = [UIFont systemFontOfSize:19];
    _tipLabel.text = @"无相关数据";
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    
    [self clearTableData];
    [_httpClient startRequest:[self requestParam]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_cooperationRightViewController.view removeFromSuperview];
}

- (void)touchNavRight:(UIButton*)button{
    if (button.tag == 0) {
        _cooperationNewViewController = [[CooperationNewViewController alloc] init];
        _cooperationNewViewController.cooperationType = CooperationTypeAdd;
        [self.navigationController pushViewController:_cooperationNewViewController animated:YES];
    }
    else if (button.tag == 1){
        [self.revealContainer showRight];
    }
    
}

- (NSDictionary*)requestParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_searchKey,@"rdi_name",
                            _categoryID,@"rdi_bigcategory",
                            _industryID,@"rdi_industry_id",
                            _regionID,@"rdi_category",
                            _addressID,@"rdi_regions",
                            _rdi_type,@"rdi_type",
                            _rdi_order,@"rdi_order",
                            _request_area,@"rdi_request_area",
                            _startTime,@"rdi_deadline_s",
                            _endTime,@"rdi_deadline_e",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"cooperationlist",@"requestKey",fields,@"fields",[NSString stringWithFormat:@"%d",currentPage],@"currentPage",@"20",@"pageSize", nil];
    return param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setTitle:@"合作信息" color:nil];
    [self showSegment:[NSArray arrayWithObjects:@"全部信息",@"排序方式", nil]];
    self.segmentView.isShow = YES;
    self.segmentView.isTouchEvent = YES;
    self.segmentView.backgroundColor = [@"#F9F9F9" colorValue];
    self.segmentView.delegate = self;
    
    _shareViewController = [[ShareViewController alloc] init];
    _shareViewController.shareType = ShareTypeCustom;
    
  
    _deleteHttpClient = [[HttpClient alloc] init];
    _deleteHttpClient.delegate = self;
    _deleteHttpClient.isChange = YES;
    
    CGRect frame = self.segmentView.frame;
    frame.origin.y = 5;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x*2;
    self.segmentView.frame = frame;
    
    self.view.backgroundColor = [@"#F9F9F9" colorValue];
    
    NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_add_btn.png"],@"image",nil,@"selectedImage", nil];
    NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
    NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
    [self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];

    _rootViewController.cooperationRightViewController.delegate = self;
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 78;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *cellNib = [UINib nibWithNibName:@"CooperationCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CooperationCell"];
    
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    self.bottomRefreshIndicator.pullToRefreshDelegate = self;
    
    [_titleField setText:@"请填写标题关键字"];
    [_titleField setText:@"请填选择需求类型"];
    
    _closeView = [[CloseView alloc] initWithFrame:self.view.frame];
    
    _seHttpClient = [[HttpClient alloc] init];
    _seHttpClient.delegate = self;
    _seHttpClient.isChange = YES;
    
    
    _searchname = @"";
    _categoryname = @"";
    _guojia = @"";
    
    _height = 88;
    [self clearTableData];
    
    _rdi_type = @"";
    _rdi_order = @"create_desc";
    _categoryID = @"";
    _industryID = @"";
    _regionID = @"";
    _addressID = @"";
    _searchKey = @"";
    _startTime = @"";
    _endTime = @"";
    _request_area = @"";
    _need = @"";
    
    currentPage = 1;
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    _httpClient.isChange = YES;
   // [_httpClient startRequest:[self requestParam]];
    
}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    
    if (button.tag == 0) {
        [self switchView:_fristView];
    }
    else if (button.tag == 1){
        [self switchView:_secondView];
    }


}

- (void)returnCooperationSearchKey:(NSString *)searchKey category:(NSString *)category industry:(NSString *)industry region:(NSString *)region address:(NSString *)address addressname:(NSString*)addressname startTime:(NSString *)startTime endTime:(NSString *)endTime request_area:(NSString *)request_area height:(CGFloat)height titile:(NSString *)titile {
    _height = height;
    
    
    _searchname = searchKey;
    
    
    [self setTitle:titile color:nil];
    if (category) {
        _categoryname = category;
        _categoryID = category;
        
        
    }
    else{
        _categoryID = @"";
    }
    
    if (industry) {
        _industryID = industry;
    }
    else{
        _industryID = @"";
    }
    
    if (region) {
        _regionID = region;
        
    }
    else{
        _regionID = @"";
    }
    
    if (addressname) {
        _guojia = addressname;
    }
    
    if (address) {
        
        _addressID = address;
    }
    else{
        _addressID = @"";
    }
    
    if (searchKey) {
        _searchKey = searchKey;
    }
    else{
        _searchKey = @"";
    }
    
    if (startTime) {
        _startTime = startTime;
    }
    else{
        _startTime = @"";
    }
    
    if (endTime) {
        _endTime = endTime;
    }
    else{
        _endTime = @"";
    }
    
    if (request_area) {
        _request_area = request_area;
    }
    else{
        _request_area = @"";
    }
    
    
    [_httpClient startRequest:[self requestParam]];
    [self clearTableData];
    [self.tableView reloadData];
}

- (void)switchView:(UIView*)contentView{
//    if (contentView.superview) {
//        [_currentView removeFromSuperview];
//        [_closeView removeFromSuperview];
//        return ;
//    }
    CGRect closeViewFrame = _closeView.frame;
    closeViewFrame.origin.y = self.segmentView.frame.origin.y+self.segmentView.frame.size.height;
    closeViewFrame.size.width = self.view.frame.size.width;
    _closeView.frame = closeViewFrame;
    
    CGRect currentViewFrame = contentView.frame;
    currentViewFrame.origin.y = 0;
    currentViewFrame.size.width = self.view.frame.size.width;
    contentView.frame = currentViewFrame;
    
    
    if (_currentView) {
        [_currentView removeFromSuperview];
        [_closeView removeFromSuperview];
    }
    
    
    _currentView = contentView;
    [_closeView addSubview:_currentView];
    [self.view addSubview:_closeView];
}

- (IBAction)touchFristEvent:(UIButton*)sender{
    [_currentView removeFromSuperview];
    [_closeView removeFromSuperview];
    int tag = (int)sender.tag;
    _draws = [NSArray arrayWithObjects:_fristImageView,_secondImageView,
              _thirdImageView,_fourthImageView, nil];

    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = (UIImageView*)[_draws objectAtIndex:i];
        if (imageView.tag == tag) {
            imageView.hidden = NO;
        }
        else{
            imageView.hidden = YES;
        }
    }
    
    
    if (tag == 0) {
        _firstSelectTitle = @"全部信息";
        _rdi_type = @"";
    }
    else if (tag == 1){
        _firstSelectTitle = @"等待合作";
        _rdi_type = @"N";
    }
    else if (tag == 2){
        _firstSelectTitle = @"已合作";
        _rdi_type = @"A";
    }
    else if (tag == 3){
        _firstSelectTitle = @"已过期";
        _rdi_type = @"B";
    }
    
    UIButton *button = (UIButton*)[self.segmentView.buttons objectAtIndex:0];
    button.titleLabel.text = _firstSelectTitle;
    [self clearTableData];
    [self.tableView reloadData];
    [_httpClient startRequest:[self requestParam]];
}

- (IBAction)touchSecondEvent:(UIButton*)sender{
    [_currentView removeFromSuperview];
    [_closeView removeFromSuperview];
    int tag = (int)sender.tag;
    _draws = [NSArray arrayWithObjects:_fristimageView,_secondimageView,
              _thirdimageView,_fourthimageView, nil];

    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = (UIImageView*)[_draws objectAtIndex:i];
        if (imageView.tag == tag) {
            imageView.hidden = NO;
        }
        else{
            imageView.hidden = YES;
        }
    }
    
    
    if (tag == 0) {
        _secondSelectTitle = @"截止日期";
        _rdi_order = @"deadline_desc";
    }
    else if (tag == 1) {
        _secondSelectTitle = @"发布日期";
        _rdi_order = @"create_desc";
    }
    else if (tag == 2) {
        _secondSelectTitle = @"关注度";
        _rdi_order = @"care_desc";
    }
    else if (tag == 3) {
        _secondSelectTitle = @"点赞数";
        _rdi_order = @"zan_desc";
    }
    UIButton *button = (UIButton*)[self.segmentView.buttons objectAtIndex:1];
    button.titleLabel.text = _secondSelectTitle;
    [self clearTableData];
    [self.tableView reloadData];
    [_httpClient startRequest:[self requestParam]];
}



#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CooperationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CooperationCell"];
    //cell.backgroundColor = [@"#F9F9F9" colorValue];
    
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    
    
    
    cell.dateLabel.text = [NSString stringWithFormat:@"截止：%@",[item objectForKey:@"rdi_deadline"]];
    
    cell.followerLabel.text = [item objectForKey:@"rdi_care_cnt"];
    cell.topLabel.text = [item objectForKey:@"rdi_zan_cnt"];
    [cell setState:[item objectForKey:@"rdi_type"]];
    cell.delegate = self;
    cell.tag = indexPath.row;
    if (_height == 88) {
        cell.buttonView.hidden = YES;
    }
    else{
        cell.buttonView.hidden = NO;
    }
    
    if ([[item objectForKey:@"rdi_is_read"] isEqualToString:@"0"]) {
        cell.titleLabel.textColor = [UIColor blackColor];
    }
    else{
        cell.titleLabel.textColor = [UIColor grayColor];
    }
    
    NSString *caseName = [NSString stringWithFormat:@"%@",[item objectForKey:@"rdi_name"]];
    NSRange range = [caseName rangeOfString:_searchname];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:caseName];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        cell.titleLabel.attributedText = caseString;
    }
    else
    {
        cell.titleLabel.text = caseName;
    }
    
    
    NSString *caseID = [NSString stringWithFormat:@"%@",[item objectForKey:@"rdi_bigcategory"]];
    NSRange caseIDRange = [caseID rangeOfString:_categoryname];
    if (caseIDRange.location != NSNotFound) {
//        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:[item objectForKey:@"rdi_bigcategory_name"]];
//        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [[item objectForKey:@"rdi_bigcategory_name"] length])];
//        cell.typeLabel.attributedText = caseString;
        cell.typeLabel.textColor = [UIColor redColor];
        cell.typeLabel.text = [item objectForKey:@"rdi_bigcategory_name"];
    }
    else{
        cell.typeLabel.text = [item objectForKey:@"rdi_bigcategory_name"];
    }
    
    
    NSString *addr = [NSString stringWithFormat:@"%@",[item objectForKey:@"rdi_regions_name"]];
    NSRange addrRange = [addr rangeOfString:_guojia];
    
    if (addrRange.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:addr];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:addrRange];
        cell.addressLabel.attributedText = caseString;
    }
    else{
        cell.addressLabel.text = addr;
    }
    
    
    return cell;
}

- (void)editCooperationCell:(CooperationCell *)cooperationCell tag:(NSInteger)tag{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:tag];
    NSString *cooID = [item objectForKey:@"rdi_id"];
    _cooperationNewViewController = [[CooperationNewViewController alloc] init];
    _cooperationNewViewController.cooperationType = CooperationTypeNew;
    _cooperationNewViewController.cooperationID = cooID;
    [self.navigationController pushViewController:_cooperationNewViewController animated:YES];
}

- (void)deleteCooperationCell:(CooperationCell*)cooperationCell tag:(NSInteger)tag{
   // NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:tag];
    
    _deleteIndexPath = [NSIndexPath indexPathForRow:tag inSection:0];
    
    
    
    AlertView* _fileAlertView = [[AlertView alloc] initWithFrame:CGRectMake(15, 120, self.view.frame.size.width-30, 125)];
    [self.view addSubview:_fileAlertView];
    _fileAlertView.delegate = self;
    [_fileAlertView setAlertButtonType:AlertButtonTwo];
    [_fileAlertView.tipLabel setText:@"是否删除"];
    _fileAlertView.textField = nil;
    [_fileAlertView.sureButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.view bringSubviewToFront:_fileAlertView];
    
}

- (void)alertView:(AlertView *)alertView field:(NSString *)text{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:_deleteIndexPath.row];
    NSString *cooID = [item objectForKey:@"rdi_id"];
    [_deleteHttpClient startRequest:[self topParam:cooID]];
}

- (void)shareCooperationCell:(CooperationCell*)cooperationCell tag:(NSInteger)tag{
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:tag];
    
    [_shareViewController sendInfo:nil title:[item objectForKey:@"rdi_name"] descri:[item objectForKey:@"rdi_desc"] redictUrl:[item objectForKey:@"rdi_share_url"]];
    [_shareViewController show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _cooperationDetailViewController = [[CooperationDetailViewController alloc] init];
    NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.row];
    _cooperationDetailViewController.cooperationId = [item objectForKey:@"rdi_id"];
    [self.navigationController pushViewController:_cooperationDetailViewController animated:YES];
}

- (NSDictionary*)topParam:(NSString*)cooperationId{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:cooperationId,@"rdi_id",[[CommomClient sharedInstance] getAccount],@"userID",@"delete",@"action_type", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"cooperationaction",@"requestKey", nil];
    return param;
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    if ([[result objectForKey:@"msg"] isEqualToString:@"nosession"]) {
        NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getValueFromUserInfo:@"userKey"],@"userKey",[[CommomClient sharedInstance] getValueFromUserInfo:@"userOffice"],@"userOffice", nil];
        
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"receivesession",@"requestKey",fields,@"fields", nil];
        [_seHttpClient startRequest:param];
        
        
    }
    else{
        if (request == _httpClient) {
            if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
                for (NSDictionary *item in [result objectForKey:@"record_list"]) {
                    if (![self.indexSet containsObject:[item objectForKey:@"rdi_id"]]) {
                        [self.indexSet addObject:[item objectForKey:@"rdi_id"]];
                        [self.tableDatas addObject:item];
                    }
                }
            }
            
            if (self.tableDatas.count == 0) {
                [self.view addSubview:_tipLabel];
            }
            else{
                [_tipLabel removeFromSuperview];
            }
            
            [self.topRefreshIndicator didLoadComplete:nil];
            [self.bottomRefreshIndicator didLoadComplete:nil];
            [self.tableView reloadData];
        }
        else if (request == _deleteHttpClient){
            if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
                [self showHUDWithTextOnly:@"删除成功"];
                NSDictionary *item = (NSDictionary*)[self.tableDatas objectAtIndex:_deleteIndexPath.row];
                [self.tableDatas removeObject:item];
                [self.tableView reloadData];
                // [_httpClient startRequest:[self requestParam]];
            }
            else{
                [self showHUDWithTextOnly:@"删除失败"];
            }
        }
        else if (_seHttpClient == request){
            if ([[result objectForKey:@"msg"] isEqualToString:@"rescivesessionsuccess"]) {
                [_httpClient startRequest:[self requestParam]];
            }
        }

    }
    
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

#pragma mark - PullToRefreshDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.topRefreshIndicator didPull];
    if (self.tableDatas.count == 0) {
        return;
    }
    
    
    [self.bottomRefreshIndicator didPull];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.topRefreshIndicator didPullReleased];
    if (self.tableDatas.count == 0) {
        return;
    }
    [self.bottomRefreshIndicator didPullReleased];
}

- (void)didStartLoading:(PullToRefreshIndicator*)indicator{
    if (indicator == self.topRefreshIndicator) {
        currentPage = 1;

    }
    else{
        currentPage = 1 + currentPage;
    }
    
    [_httpClient startRequest:[self requestParam]];
}

@end

/*
 
 
 {
 "rdi_bigcategory" = XS;
 "rdi_bigcategory_name" = "\U6cd5\U5f8b\U670d\U52a1\U7c7b----\U3010\U8bc9\U8bbc\U3011\U5211\U4e8b\U8bc9\U8bbc";
 "rdi_care_cnt" = 1;
 "rdi_deadline" = "2014-12-20";
 "rdi_deadline_full" = "2014-12-20 13:45:35";
 "rdi_id" = RE00000304;
 "rdi_is_care" = 0;
 "rdi_is_read" = 1;
 "rdi_is_user" = 0;
 "rdi_is_zan" = 0;
 "rdi_name" = "\U5f53\U524d\U4f4d\U7f6e\U7684";
 "rdi_regions" = 01;
 "rdi_regions_name" = "\U4e2d\U56fd";
 "rdi_type" = B;
 "rdi_type_name" = "\U5df2\U8fc7\U671f";
 "rdi_zan_cnt" = 1;
 }
 */
