//
//  CounterViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CounterViewController.h"

#import "GeneralViewController.h"

#import "NSString+Utility.h"

@interface CounterViewController ()<SegmentViewDelegate,GeneralViewControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    UIView *_currentView;
    
    CGFloat result_shou;
    CGFloat result_bao;
    CGFloat result_zhi;
    
    CGFloat result_sl;
    NSString *_selectName;
    NSString *_selectSubId;
    
    NSArray *_secondDatas;
    NSArray *_thirdDatas;
    NSArray *_selectDatas;
    
    NSString *_thirdSelectId;
    CGFloat result_sq;
    
    GeneralViewController *_caichanViewController;
    
    GeneralViewController *_subViewController;
    
    GeneralViewController *_jobViewController;
    
    
    NSString *firstselectName;
}

@end

@implementation CounterViewController

@synthesize fristView = _fristView;
@synthesize secondView = _secondView;
@synthesize thirdView = _thirdView;

@synthesize fristButton = _fristButton;
@synthesize secondButton = _secondButton;
@synthesize thirdButton = _thirdButton;

@synthesize calculateView = _calculateView;

@synthesize tableView = _tableView;

@synthesize caichanButton = _caichanButton;
@synthesize noSubButton = _noSubButton;
@synthesize jobButton = _jobButton;

@synthesize secondTextField = _secondTextField;
@synthesize thirdTextField = _thirdTextField;

- (id)init{
    self = [super init];
    if (self) {
        [self generateData];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:[Utility localizedStringWithTitle:@"box_counter_nav_title"] color:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSegment:[NSArray arrayWithObjects:@"财产纠纷",@"受理费",@"申请费", nil]];
    self.segmentView.delegate = self;
    
    CGRect frame = self.segmentView.frame;
    frame.origin.y = 10;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x*2;
    self.segmentView.frame = frame;

    
    _caichanViewController = [[GeneralViewController alloc] init];
    _caichanViewController.delegate = self;
    _caichanViewController.datas = _secondDatas;
    
    _subViewController = [[GeneralViewController alloc] init];
    _subViewController.delegate = self;
    
    _jobViewController = [[GeneralViewController alloc] init];
    _jobViewController.delegate = self;
    _jobViewController.datas = _thirdDatas;
    
    _tableView.backgroundColor = [@"#F9F9F9" colorValue];
    _tableView.backgroundView = nil;
    
    self.view.backgroundColor = [@"#F9F9F9" colorValue];
    
    
    firstselectName = @"财产案件";
    _selectName = @"财产案件";
    [_caichanButton setTitle:@"财产案件" forState:UIControlStateNormal];
    
    [_noSubButton setTitle:@"无子类类型" forState:UIControlStateNormal];
    _noSubButton.enabled = NO;
    
    [_jobButton setTitle:@"执行申请费" forState:UIControlStateNormal];
    _thirdSelectId = @"0";
    
}

- (void) generateData
{
    //申请费类型数据
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"执行申请费", @"gc_name",
                          @"0", @"gc_id",
                          nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"诉讼保全申请费", @"gc_name",
                          @"1", @"gc_id",
                          nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"申请支付令", @"gc_name",
                          @"2", @"gc_id",
                          nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"申请公示催告", @"gc_name",
                          @"3", @"gc_id",
                          nil];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"申请撤销仲裁裁决或者认定仲裁协议效力", @"gc_name",
                          @"4", @"gc_id",
                          nil];
    NSDictionary *dic6 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"破产案件", @"gc_name",
                          @"5", @"gc_id",
                          nil];
    _thirdDatas = [[NSArray alloc] initWithObjects:dic1, dic2, dic3, dic4, dic5, dic6, nil];
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CalculateList" ofType:@"plist"];
    _secondDatas = [[NSArray alloc] initWithContentsOfFile:plistPath];
}

- (void)switchView:(UIView*)contentView{
    if (contentView.superview) {
        return ;
    }
    CGRect contentViewFrame = contentView.frame;
    contentViewFrame.origin.y = self.segmentView.frame.origin.y+self.segmentView.frame.size.height;
    contentViewFrame.size.width = self.view.frame.size.width;
    if (_currentView) {
        
        [_currentView removeFromSuperview];
    }

    contentView.frame = contentViewFrame;
    _currentView = contentView;
    [self.view addSubview:_currentView];
    
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


- (IBAction)touchCalculate:(UIButton*)sender{
    
    
    
    if (sender.tag == 0) {
        if( ![self isPureInt:_fristTextField.text] && ![self isPureFloat:_fristTextField.text])
        {
            [self showHUDWithTextOnly:@"你输入的金额有误!"];
            return;
        }
        
        [self calculateFrist];
    }
    else if (sender.tag == 1){
        if( ![self isPureInt:_secondTextField.text] && ![self isPureFloat:_secondTextField.text])
        {
            [self showHUDWithTextOnly:@"你输入的金额有误!"];
            return;
        }
        
        if ([firstselectName isEqualToString:@"非财产案件"] || [firstselectName isEqualToString:@"知识产权民事案件"] || [firstselectName isEqualToString:@"行政案件"]) {
            
            if (_selectSubId.length == 0) {
                [self showHUDWithTextOnly:@"请选择子类"];
                return;
            }
        }
        
        
        [self calculateSecond];
    }
    else if (sender.tag == 2){
        if( ![self isPureInt:_thirdTextField.text] && ![self isPureFloat:_thirdTextField.text])
        {
            [self showHUDWithTextOnly:@"你输入的金额有误!"];
            return;
        }
        
        if (_thirdSelectId.length == 0) {
            [self showHUDWithTextOnly:@"请选择子类"];
            return;
        }
        
        [self calculateThird];
    }
    
    
    [_calculateView removeFromSuperview];
    _calculateView.frame = CGRectMake(0, sender.frame.origin.y+sender.frame.size.height+15, self.view.frame.size.width, _calculateView.frame.size.height);
    [_currentView addSubview:_calculateView];
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView reloadData];
    
    
}


- (IBAction)touchCaiChanEvent:(UIButton*)sender{
    _selectDatas = nil;
    [_noSubButton setTitle:@"" forState:UIControlStateNormal];
    [self.navigationController pushViewController:_caichanViewController animated:YES];
    
}

- (IBAction)touchSubEvent:(id)sender{
    _subViewController.datas = _selectDatas;
    [self.navigationController pushViewController:_subViewController animated:YES];
}

- (IBAction)touchJobEvent:(id)sender{
    [self.navigationController pushViewController:_jobViewController animated:YES];
}

- (void)general:(GeneralViewController *)generalViewController data:(NSDictionary *)data{
    
    if (generalViewController == _caichanViewController) {
        
        _selectSubId = @"";
        _thirdSelectId = @"";
        
        
        
        
        NSString *name = [data objectForKey:@"gc_name"];
        
        firstselectName = name;
        if ([name isEqualToString:@"财产案件"] || [name isEqualToString:@"劳动争议案件"]) {
            [_noSubButton setTitle:@"无子类类型" forState:UIControlStateNormal];
            _noSubButton.enabled = NO;
        }
        else{
            _noSubButton.enabled = YES;
            _selectDatas = [data objectForKey:@"record_list"];
        }
        
        _selectName = name;
        [_caichanButton setTitle:name forState:UIControlStateNormal];
    }
    else if (generalViewController == _subViewController){
        NSString *name = [data objectForKey:@"gc_name"];
        _selectSubId = [data objectForKey:@"gc_id"];
        [_noSubButton setTitle:name forState:UIControlStateNormal];
        _noSubButton.titleLabel.numberOfLines = 0;
        [_noSubButton.titleLabel sizeToFit];
    }
    else if (generalViewController == _jobViewController){
        NSString *name = [data objectForKey:@"gc_name"];
        _thirdSelectId = [data objectForKey:@"gc_id"];
        [_jobButton setTitle:name forState:UIControlStateNormal];
    }
}


- (void)calculateFrist{
    [_fristTextField resignFirstResponder];

    
    CGFloat shuru = _fristTextField.text.floatValue;
    shuru = shuru*10000;
    
    if ((shuru>0)&&(shuru<=10000)){
        result_shou=50;
        if(shuru<1000){
            result_bao=30;
        }else{
            result_bao=shuru*0.01+20;
        }
        //result_bao=shuru*0.01+20;
        result_zhi=50;
    }
    else if ((shuru>10000)&&(shuru<=100000)){
        result_shou=shuru*0.025-200;
        result_bao=shuru*0.01+20;
        result_zhi=shuru*0.015-100;
    }
    else if ((shuru>100000)&&(shuru<=200000)){
        result_shou=shuru*0.02+300;
        result_bao=shuru*0.005+520;
        result_zhi=shuru*0.015-100;
    }
    else if ((shuru>200000)&&(shuru<=500000)){
        result_shou=shuru*0.015+1300;
        result_bao=shuru*0.005+520;
        result_zhi=shuru*0.015-100;
    }
    else if ((shuru>500000)&&(shuru<=1000000)){
        result_shou=shuru*0.01+3800;
        if(shuru<896000){
            result_bao=shuru*0.005+520;
        }else{
            result_bao=5000;
        }
        result_zhi=shuru*0.01+2400;
    }
    else if ((shuru>1000000)&&(shuru<=2000000)){
        result_shou=shuru*0.009+4800;
        result_bao=5000;
        result_zhi=shuru*0.01+2400;
    }
    else if ((shuru>2000000)&&(shuru<=5000000)){
        result_shou=shuru*0.008+6800;
        result_bao=5000;
        result_zhi=shuru*0.01+2400;
    }
    else if ((shuru>5000000)&&(shuru<=10000000)){
        result_shou=shuru*0.007+11800;
        result_bao=5000;
        result_zhi=shuru*0.005+27400;
    }
    else if ((shuru>10000000)&&(shuru<=20000000)){
        result_shou=shuru*0.006+21800;
        result_bao=5000;
        result_zhi=shuru*0.001+67400;
    }
    else if (shuru>20000000){
        result_shou=shuru*0.005+41800;
        result_bao=5000;
        result_zhi=shuru*0.001+67400;
    }
}

- (void)calculateSecond{
    CGFloat sl = _secondTextField.text.floatValue;
    sl = sl*10000;
    [_secondTextField resignFirstResponder];
    if ([_selectName isEqualToString:@"财产案件"]) {
        if ((sl>0)&&(sl<=10000)){
            result_sl=50;
        }
        else if ((sl>10000)&&(sl<=100000)){
            result_sl=sl*0.025-200;
        }
        else if ((sl>100000)&&(sl<=200000)){
            result_sl=sl*0.02+300;
        }
        else if ((sl>200000)&&(sl<=500000)){
            result_sl=sl*0.015+1300;
        }
        else if ((sl>500000)&&(sl<=1000000)){
            result_sl=sl*0.01+3800;
        }
        else if ((sl>1000000)&&(sl<=2000000)){
            result_sl=sl*0.009+4800;
        }
        else if ((sl>2000000)&&(sl<=5000000)){
            result_sl=sl*0.008+6800;
        }
        else if ((sl>5000000)&&(sl<=10000000)){
            result_sl=sl*0.007+11800;
        }
        else if ((sl>10000000)&&(sl<=20000000)){
            result_sl=sl*0.006+21800;
        }
        else if (sl>20000000){
            result_sl=sl*0.005+41800;
        }
    }
    else if ([_selectName isEqualToString:@"非财产案件"]) {
        if ([_selectSubId isEqualToString:@"0"]) {
            if ((sl>0)&&(sl<200000)){
                result_sl=150;
            }
            else if(sl>=200000){
                result_sl=(sl-200000)*0.005+150;
            }
        }
        else if ([_selectSubId isEqualToString:@"1"]) {
            if((sl>0)){
                result_sl=150;
            }
        }
        else if ([_selectSubId isEqualToString:@"2"]) {
            if ((sl>0)&&(sl<50000)){
                result_sl=300;
            }
            else if((sl>=50000)&&(sl<=100000)){
                result_sl=(sl-50000)*0.01+300;//超过5万元至10万元的部分，按照1％交纳
            }
            else if(sl>100000){
                result_sl=sl*0.005+300;
            }
        }
        else if ([_selectSubId isEqualToString:@"3"]) {
            if((sl>0)){
                result_sl=300;
            }
        }
        else if ([_selectSubId isEqualToString:@"4"]) {
            if((sl>0)){
                result_sl=70;
            }
        }
    }
    else if ([_selectName isEqualToString:@"知识产权民事案件"]) {
        if ([_selectSubId isEqualToString:@"0"]) {
            if((sl>0)){
                result_sl=750;
            }
        }
        else if ([_selectSubId isEqualToString:@"1"]) {
            if ((sl>0)&&(sl<=10000)){
                result_sl=50;
            }
            else if ((sl>10000)&&(sl<=100000)){
                result_sl=sl*0.025-200;
            }
            else if ((sl>100000)&&(sl<=200000)){
                result_sl=sl*0.02+300;
            }
            else if ((sl>200000)&&(sl<=500000)){
                result_sl=sl*0.015+1300;
            }
            else if ((sl>500000)&&(sl<=1000000)){
                result_sl=sl*0.01+3800;
            }
            else if ((sl>1000000)&&(sl<=2000000)){
                result_sl=sl*0.009+4800;
            }
            else if ((sl>2000000)&&(sl<=5000000)){
                result_sl=sl*0.008+6800;
            }
            else if ((sl>5000000)&&(sl<=10000000)){
                result_sl=sl*0.007+11800;
            }
            else if ((sl>10000000)&&(sl<=20000000)){
                result_sl=sl*0.006+21800;
            }
            else if (sl>20000000){
                result_sl=sl*0.005+41800;
            }
        }

    }
    else if ([_selectName isEqualToString:@"劳动争议案件"]) {
        if((sl>0)){
            result_sl=10;
        }
    }
    else if ([_selectName isEqualToString:@"行政案件"]) {
        if ([_selectSubId isEqualToString:@"0"]) {
            if((sl>0)){
                result_sl=100;
            }
        }
        else if ([_selectSubId isEqualToString:@"1"]) {
            if((sl>0)){
                result_sl=50;
            }
        }

    }
}

- (void)calculateThird{
    CGFloat sq = _thirdTextField.text.floatValue;
    sq = sq*10000;
    
    [_thirdTextField resignFirstResponder];
    
    if ([_thirdSelectId isEqualToString:@"0"]) {
        if ((sq>0)&&(sq<=10000)){
            result_sq=50;
        }
        else if ((sq>10000)&&(sq<=100000)){
            result_sq=sq*0.015-100;
        }
        else if ((sq>100000)&&(sq<=200000)){
            result_sq=sq*0.015-100;
        }
        else if ((sq>200000)&&(sq<=500000)){
            result_sq=sq*0.015-100;
        }
        else if ((sq>500000)&&(sq<=1000000)){
            result_sq=sq*0.01+2400;
        }
        else if ((sq>1000000)&&(sq<=2000000)){
            result_sq=sq*0.01+2400;
        }
        else if ((sq>2000000)&&(sq<=5000000)){
            result_sq=sq*0.01+2400;
        }
        else if ((sq>5000000)&&(sq<=10000000)){
            result_sq=sq*0.005+27400;
        }
        else if ((sq>10000000)&&(sq<=20000000)){
            result_sq=sq*0.001+67400;
        }
        else if (sq>20000000){
            result_sq=sq*0.001+67400;
        }
    }
    else if ([_thirdSelectId isEqualToString:@"1"]) {
        if ((sq>0)&&(sq<=10000)){
            if(sq<1000){
                result_sq=30;
            }else{
                result_sq=sq*0.01+20;
            }
        }
        else if ((sq>10000)&&(sq<=100000)){
            result_sq=sq*0.01+20;
        }
        else if ((sq>100000)&&(sq<=200000)){
            result_sq=sq*0.005+520;
        }
        else if ((sq>200000)&&(sq<=500000)){
            result_sq=sq*0.005+520;
        }
        else if ((sq>500000)&&(sq<=1000000)){
            if(sq<896000){
                result_sq=sq*0.005+520;
            }else{
                result_sq=5000;
            }
        }
        else if ((sq>1000000)&&(sq<=2000000)){
            result_sq=5000;
        }
        else if ((sq>2000000)&&(sq<=5000000)){
            result_sq=5000;
        }
        else if ((sq>5000000)&&(sq<=10000000)){
            result_sq=5000;
        }
        else if ((sq>10000000)&&(sq<=20000000)){
            result_sq=5000;
        }
        else if (sq>20000000){
            result_sq=5000;
        }
    }
    else if ([_thirdSelectId isEqualToString:@"2"]) {
        if ((sq>0)&&(sq<=10000)){
            result_sq=50/3;
        }
        else if ((sq>10000)&&(sq<=100000)){
            result_sq=(sq*0.025-200)/3;
        }
        else if ((sq>100000)&&(sq<=200000)){
            result_sq=(sq*0.02+300)/3;
        }
        else if ((sq>200000)&&(sq<=500000)){
            result_sq=(sq*0.015+1300)/3;
        }
        else if ((sq>500000)&&(sq<=1000000)){
            result_sq=(sq*0.01+3800)/3;
        }
        else if ((sq>1000000)&&(sq<=2000000)){
            result_sq=(sq*0.009+4800)/3;
        }
        else if ((sq>2000000)&&(sq<=5000000)){
            result_sq=(sq*0.008+6800)/3;
        }
        else if ((sq>5000000)&&(sq<=10000000)){
            result_sq=(sq*0.007+11800)/3;
        }
        else if ((sq>10000000)&&(sq<=20000000)){
            result_sq=(sq*0.006+21800)/3;
        }
        else if (sq>20000000){
            result_sq=(sq*0.005+41800)/3;
        }
    }
    else if ([_thirdSelectId isEqualToString:@"3"]) {
        if(sq>0){
            result_sq=100;
        }
    }
    else if ([_thirdSelectId isEqualToString:@"4"]) {
        if(sq>0){
            result_sq=400;
        }
    }
    else if ([_thirdSelectId isEqualToString:@"5"]) {
        if ((sq>0)&&(sq<=10000)){
            result_sq=50/2;
        }
        else if ((sq>10000)&&(sq<=100000)){
            result_sq=(sq*0.025-200)/2;
        }
        else if ((sq>100000)&&(sq<=200000)){
            result_sq=(sq*0.02+300)/2;
        }
        else if ((sq>200000)&&(sq<=500000)){
            result_sq=(sq*0.015+1300)/2;
        }
        else if ((sq>500000)&&(sq<=1000000)){
            result_sq=(sq*0.01+3800)/2;
        }
        else if ((sq>1000000)&&(sq<=2000000)){
            result_sq=(sq*0.009+4800)/2;
        }
        else if ((sq>2000000)&&(sq<=5000000)){
            result_sq=(sq*0.008+6800)/2;
        }
        else if ((sq>5000000)&&(sq<=10000000)){
            result_sq=(sq*0.007+11800)/2;
        }
        else if ((sq>10000000)&&(sq<=20000000)){
            result_sq=(sq*0.006+21800)/2;
        }
        else if (sq>20000000){
            result_sq=(sq*0.005+41800)/2;
        }
        //受理费>300000，全安300000计算
        if(result_sq>300000){
            result_sq=300000;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_currentView == _fristView) {
        return 3;
    }
    else if (_currentView == _secondView){
        return 1;
    }
    else if (_currentView == _thirdView){
        return 1;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)];
    view.backgroundColor = [@"#F1F1F2" colorValue];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 22)];
    titleLabel.text = @"计算结果";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [view addSubview:titleLabel];
    
    return view;
}



- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"计算结果";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.backgroundColor = [@"#F9F9F9" colorValue];
        
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 45)];
        hintLabel.textColor = [UIColor blackColor];
        hintLabel.font = [UIFont systemFontOfSize:12];
        hintLabel.tag = 1001;
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 150, 45)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.tag = 1002;
        
        [cell addSubview:hintLabel];
        [cell addSubview:titleLabel];

    }
    
    UILabel *hintLabel = (UILabel*)[cell viewWithTag:1001];
    UILabel *titleLabel = (UILabel*)[cell viewWithTag:1002];
    
    
    
    if (_currentView == _fristView) {
        CGRect frame = titleLabel.frame;
        frame.origin.x = 65;
        titleLabel.frame = frame;
        if (indexPath.row == 0) {
            hintLabel.text = @"诉讼费：";
            titleLabel.text = [NSString stringWithFormat:@"%.1f",result_shou];
        }
        else if(indexPath.row == 1){
            hintLabel.text = @"保全费：";
            titleLabel.text = [NSString stringWithFormat:@"%.1f",result_bao];
        }
        else if(indexPath.row == 2){
            hintLabel.text = @"执行费：";
            titleLabel.text = [NSString stringWithFormat:@"%.1f",result_zhi];
        }

    }
    else if (_currentView == _secondView){
        hintLabel.text = @"收费金额：";
        CGRect frame = titleLabel.frame;
        frame.origin.x = 85;
        titleLabel.frame = frame;
        
        titleLabel.text = [NSString stringWithFormat:@"%.1f",result_sl];
    }
    else if (_currentView == _thirdView){
        hintLabel.text = @"收费金额：";
        CGRect frame = titleLabel.frame;
        frame.origin.x = 85;
        titleLabel.frame = frame;
        titleLabel.text = [NSString stringWithFormat:@"%.1f",result_sq];
    }
    
    return cell;
}

- (void)didClickSegment:(SegmentView*)segment button:(UIButton*)button{
    if (button.tag == 0) {
        [self switchView:_fristView];
        [_fristTextField becomeFirstResponder];
    }
    else if (button.tag == 1){
        [self switchView:_secondView];
    }
    else if (button.tag == 2){
        [self switchView:_thirdView];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
