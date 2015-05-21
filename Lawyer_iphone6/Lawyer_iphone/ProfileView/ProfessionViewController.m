//
//  ProfessionViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-3.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProfessionViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"

@interface ProfessionViewController ()<RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_httpClient;
    HttpClient *_uploadClient;
    
    
    NSArray *_sections;
    
    NSMutableArray *_selectArr;
    
    NSMutableString *_idStrings;
    
}

@end

@implementation ProfessionViewController

@synthesize professionType = _professionType;
@synthesize professionLabel = _professionLabel;
@synthesize hintLabel = _hintLabel;
@synthesize sureButton = _sureButton;

UIImage *_markImage = nil;

+ (void)initialize{
    _markImage = [UIImage imageNamed:@"green_mark_logo.png"];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setTitle:[Utility localizedStringWithTitle:@"profession_nav_title"] color:nil];
        [_httpClient startRequest:[self param]];
    
    
    
}





- (NSDictionary*)param{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getAccount],@"userID",[[CommomClient sharedInstance] getValueFromUserInfo:@"userOffice"],@"officeID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"userspecialtylist",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    
    _uploadClient = [[HttpClient alloc] init];
    _uploadClient.delegate = self;
    
    
    self.isSet = YES;
    
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, _hintLabel.frame.size.height+_hintLabel.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height -_professionLabel.frame.size.height-_hintLabel.frame.size.height-_sureButton.frame.size.height-40-100);
}




#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 50)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
    titleLabel.text = [dic objectForKey:@"gc_name"];
    
    [view addSubview:titleLabel];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 48, self.view.frame.size.width, 0.5)];
    lineImageView.image = [UIImage imageNamed:@"gray_line.png"];
    [view addSubview:lineImageView];
    

    
    UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tapButton setImage:_markImage forState:UIControlStateSelected];
    [tapButton setImage:nil forState:UIControlStateNormal];
    [tapButton setTitle:[dic objectForKey:@"gc_name"] forState:UIControlStateNormal];
    [tapButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    
    [tapButton addTarget:self action:@selector(selecteButton:) forControlEvents:UIControlEventTouchUpInside];
    tapButton.frame = view.frame;
    tapButton.tag = section;
    [view addSubview:tapButton];
    tapButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.view.frame.size.width-30, 0, 0);
   // tapButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    
    if ([[dic objectForKey:@"gc_select"] isEqualToString:@"0"]) {
        tapButton.selected = NO;
    }
    else{

        tapButton.selected = YES;
    }
    
 
    if (![_selectArr containsObject:dic]) {
        tapButton.selected = NO;
    }
    else{
        tapButton.selected = YES;
    }
    
    return view;
}

- (void)selecteButton:(UIButton*)sender{
    NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:sender.tag];
    if (sender.selected) {
        sender.selected = NO;
        [_selectArr removeObject:dic];
    }
    else{
        if (_selectArr.count  < 10) {
            [_selectArr addObject:dic];
            sender.selected = YES;

        }
    }
   [self updateTextView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:section];
    NSArray *kind_list = [dic objectForKey:@"kind_list"];
    if (kind_list.count > 0) {
        return kind_list.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
    
    
   
    
    NSArray *kind_list = [dic objectForKey:@"kind_list"];
    if (kind_list.count > 0) {
        NSDictionary *subDic = (NSDictionary*)[kind_list objectAtIndex:indexPath.row];
        cell.textLabel.text = [subDic objectForKey:@"gc_name"];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        CGRect frame = cell.textLabel.frame;
        frame.origin.x = 30;
        cell.textLabel.frame = frame;
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 48, self.view.frame.size.width, 0.5)];
        lineImageView.image = [UIImage imageNamed:@"gray_line.png"];
        [cell addSubview:lineImageView];
        
        UIImageView* _markImageView = [[UIImageView alloc] initWithImage:_markImage];
        _markImageView.frame = CGRectMake(0, 0, _markImage.size.width, _markImage.size.height);
        
        if ([[subDic objectForKey:@"gc_select"] isEqualToString:@"0"]) {
            cell.accessoryView = nil;
        }
        else{
            cell.accessoryView = _markImageView;
            
        }
        
        if (![_selectArr containsObject:subDic]) {
            cell.accessoryView = nil;
        }
        else{
            cell.accessoryView = _markImageView;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIImageView* _markImageView = [[UIImageView alloc] initWithImage:_markImage];
    _markImageView.frame = CGRectMake(0, 0, _markImage.size.width, _markImage.size.height);

    NSDictionary *dic = (NSDictionary*)[self.tableDatas objectAtIndex:indexPath.section];
    NSArray *kind_list = [dic objectForKey:@"kind_list"];
    NSDictionary *subDic = (NSDictionary*)[kind_list objectAtIndex:indexPath.row];
    
    UITableViewCell *cellView = [tableView cellForRowAtIndexPath:indexPath];
    if (cellView.accessoryView != nil) {
        cellView.accessoryView = nil;
        
        [_selectArr removeObject:subDic];
    }
    else {
        if (_selectArr.count < 10) {
            cellView.accessoryView = _markImageView;
            [_selectArr addObject:subDic];
        }
        
    }
    
   [self updateTextView];
}

- (NSDictionary*)editParam{
    NSMutableString * selectedString = [[NSMutableString alloc] init];
    for (NSDictionary *dic in _selectArr) {
        [selectedString appendString:[NSString stringWithFormat:@"%@,",[dic objectForKey:@"gc_id"]]];
    }
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:selectedString,@"emp_zy",[[CommomClient sharedInstance] getAccount],@"userID",[[CommomClient sharedInstance] getValueFromUserInfo:@"userOffice"],@"user_officeID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"userspecialtymodify",@"requestKey",fields,@"fields", nil];
    return param;
}

- (IBAction)touchSureEvent:(id)sender{
    [_uploadClient startRequest:[self editParam]];
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    _selectArr = [[NSMutableArray alloc] init];

    [self clearTableData];
    NSDictionary *dic = (NSDictionary*)responseObject;
    if (request == _httpClient) {
        
        NSArray *datas = [dic objectForKey:@"record_list"];
        if (datas.count > 0) {
            for (NSDictionary *dic  in datas) {
                if ([[dic objectForKey:@"gc_select"] isEqualToString:@"1"]) {
                    [_selectArr addObject:dic];
                }
                [self.tableDatas addObject:dic];
                
                NSArray *temps = [dic objectForKey:@"kind_list"];
                
                for (NSDictionary *item in temps) {
                    if ([[item objectForKey:@"gc_select"] isEqualToString:@"1"]) {
                        [_selectArr addObject:dic];
                    }
                }
            }
        }
        [self updateTextView];
        [self.tableView reloadData];
    }
    else{
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"修改失败"];
        }
    }
    
    
}

- (void)updateTextView{
    NSMutableString * selectedString = [[NSMutableString alloc] init];
    for (NSDictionary *dic in _selectArr) {
        [selectedString appendString:[NSString stringWithFormat:@"%@,  ",[dic objectForKey:@"gc_name"]]];
    }
    _textView.text = selectedString;
    
    
    NSString *name = [NSString stringWithFormat:@"请选择(最多选择10个,已经选择%lu个)",(unsigned long)_selectArr.count];
    NSRange range = [name rangeOfString:[NSString stringWithFormat:@"%lu",_selectArr.count]];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:name];
        [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        _hintLabel.attributedText = caseString;
    }
    else{
        _hintLabel.text = name;
    }

}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

@end
