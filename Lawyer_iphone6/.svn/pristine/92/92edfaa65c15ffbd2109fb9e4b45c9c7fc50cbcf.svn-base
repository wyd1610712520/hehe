//
//  CooperationNewViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-14.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CooperationNewViewController.h"

#import "HttpClient.h"

#import "GeneralViewController.h"

#import "DateViewController.h"

#import "MeidaViewController.h"

#import "AlertView.h"
#import "CommomClient.h"
#import "UploadCell.h"

#import "DocumentViewController.h"

@interface CooperationNewViewController ()<UITableViewDataSource,UITableViewDelegate,RequestManagerDelegate,GeneralViewControllerDelegate,AlertViewDelegate,UploadCellDelegate,DateViewControllerDelegate,MeidaViewControllerDelegate,UITextFieldDelegate>{
    HttpClient *_httpClient;
    HttpClient *_detailHttpClient;
    
    GeneralViewController *_bViewController;
    GeneralViewController *_categoryViewController;
    GeneralViewController *_industryViewController;
    GeneralViewController *_regionViewController;
    GeneralViewController *_addressViewController;
    
    GeneralViewController *_statusViewController;
    
    MeidaViewController *_meidaViewController;
    
    DateViewController *_startPicker;
    
    HttpClient *deleteHttpClient;
    
    NSDictionary *_categoryDic;
    NSDictionary *_industyDic;
    NSDictionary *_regionDic;
    NSDictionary *_addressDic;
    NSDictionary *_bDic;
    NSDictionary *_statusDic;
    
    NSData *_curData;
    NSString *_curType;
    
    NSMutableArray *_file_list;
    
    AlertView *_alertView;
    
    NSMutableArray *_uploadTableDatas;
    
    NSMutableArray *_uploadFiles;
    
    UIWindow *_window;
    
    DocumentViewController *documentViewController;
    
    BOOL isEdit;
    
    NSInteger _deleteIndex;
    
}

@end

@implementation CooperationNewViewController

@synthesize cooperationID = _cooperationID;

@synthesize record = _record;

@synthesize cooperationType = _cooperationType;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_cooperationType == CooperationTypeAdd) {
        [self setTitle:@"创建合作信息" color:nil];
        _cooperationID=@"";
    }
    else if (_cooperationType == CooperationTypeNew){
        [self setTitle:@"编辑合作信息" color:nil];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardDidHideNotification object:nil];
    
    isEdit = NO;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.frame = [UIScreen mainScreen].bounds;
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    _httpClient.isChange = YES;
    
    _categoryViewController = [[GeneralViewController alloc] init];
    _categoryViewController.delegate = self;
    _categoryViewController.commomCode = @"CPCT";
    
    _industryViewController = [[GeneralViewController alloc] init];
    _industryViewController.delegate = self;
    _industryViewController.commomCode = @"CLIDT";
    
    _regionViewController = [[GeneralViewController alloc] init];
    _regionViewController.delegate = self;
    _regionViewController.commomCode = @"FIELD";
    
    _addressViewController = [[GeneralViewController alloc] init];
    _addressViewController.delegate = self;
    _addressViewController.commomCode = @"CLCNT";
    
    _bViewController = [[GeneralViewController alloc] init];
    _bViewController.delegate = self;
    _bViewController.commomCode = @"Currency";
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"N",@"gc_id",@"未合作",@"gc_name", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"A",@"gc_id",@"已合作",@"gc_name", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"B",@"gc_id",@"已过期",@"gc_name", nil];
    
    NSArray *arr = [NSArray arrayWithObjects:dic1,dic2,dic3, nil];
    
    _statusViewController = [[GeneralViewController alloc] init];
    _statusViewController.delegate = self;
    _statusViewController.datas = arr;

    
    _startPicker = [[DateViewController alloc] init];
    _startPicker.delegate = self;
    _startPicker.dateformatter = @"yyyy-MM-dd";
    _uploadTableDatas = [[NSMutableArray alloc] init];
    
    UINib *nib = [UINib nibWithNibName:@"UploadCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"UploadCell"];
    
    _uploadFiles = [[NSMutableArray alloc] init];
    
    if (_cooperationType == CooperationTypeNew) {
        _detailHttpClient = [[HttpClient alloc] init];
        _detailHttpClient.delegate = self;
        _detailHttpClient.isChange = YES;
        [_detailHttpClient startRequest:[self detailParam]];
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesFIle:) name:@"file_list_coo" object:nil];
}

- (void)receivesFIle:(NSNotification*)notification{
    NSString *pathId = (NSString*)[notification object];
    [_uploadFiles addObject:pathId];
}


- (NSDictionary*)detailParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_cooperationID,@"rdi_id", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"cooperationdetail",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)datePicker:(DateViewController*)dateViewController date:(NSString*)date{
    [_dateButton setTitle:date forState:UIControlStateNormal];
    [_dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (NSDictionary*)requestParam{
    NSString *category = @"";
    if (!_categoryDic) {
        category = [_record objectForKey:@"rdi_bigcategory"];
    }
    else{
        if ([[_categoryDic objectForKey:@"gc_id"] length] > 0) {
            category = [_categoryDic objectForKey:@"gc_id"];
        }
    }
    
    
    NSString *region = @"";
    if (!_regionDic) {
        region = [_record objectForKey:@"rdi_category"];
    }
    else{
        if ([[_regionDic objectForKey:@"gc_id"] length] > 0) {
            region = [_regionDic objectForKey:@"gc_id"];
        }
    }
    
    
    NSString *industy = @"";
    if (!_industyDic) {
        industy = [_record objectForKey:@"rdi_industry_id"];
    }
    else{
        if ([[_industyDic objectForKey:@"gc_id"] length] > 0) {
            industy = [_industyDic objectForKey:@"gc_id"];
        }
    }

    
    NSString *address = @"";
    
    
    if (!_addressDic) {
        address = [_record objectForKey:@"rdi_regions"];
    }
    else{
        if ([[_addressDic objectForKey:@"gc_id"] length] > 0) {
            address = [_addressDic objectForKey:@"gc_id"];
        }
    }
    
    
    
    
    
    NSString *date = @"";
    if ([_dateButton.titleLabel.text length] > 0) {
        date = _dateButton.titleLabel.text;
    }
    
    NSString *calcaulateField =@"";
    if (_calcaulateField.text.length > 0) {
        calcaulateField = _calcaulateField.text;
    }
    
    NSString *type =@"";
    if ([_typeTextView hasText]) {
        type = _typeTextView.text;
    }
  
    
    
    NSString *describe = @"";
    if ([_describeTextView hasText]) {
        describe = _describeTextView.text;
    }
    else {
        describe = [_record objectForKey:@"rdi_business_desc"];
    }
    
    NSString *rdi_desc =@"";
    if ([_typeTextView hasText]) {
        rdi_desc = _typeTextView.text;
    }
    else{
        rdi_desc = [_record objectForKey:@"rdi_desc"];
    }
    
    NSString *b = @"";
    if (!_bDic) {
        b = [_record objectForKey:@"rdi_currency"];
    }
    else{
        if (_bDic.count > 0) {
            b = [_bDic objectForKey:@"gc_id"];
        }
    }
    
    NSMutableString *pa = [[NSMutableString alloc] init];
    for (NSString *s in _uploadFiles) {
        [pa appendFormat:@"%@,",s];
    }
  
    NSString *status = @"N";
    if (_statusDic) {
        status = [_statusDic objectForKey:@"gc_id"];
    }
    else{
        if ([_statusButton.titleLabel.text isEqualToString:@"未合作"]) {
            status = @"N";
        }
        else if ([_statusButton.titleLabel.text isEqualToString:@"已合作"]) {
            status = @"A";
        }
        else if ([_statusButton.titleLabel.text isEqualToString:@"已过期"]) {
            status = @"B";
        }
    }
    
 
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_cooperationID,@"rdi_id",
                            _titleLabel.text,@"rdi_name",
                            category,@"rdi_bigcategory",
                            region,@"rdi_category",
                            industy,@"rdi_industry_id",
                            address,@"rdi_regions",
                            date,@"rdi_deadline",
                            calcaulateField,@"rdi_money",
                            b,@"rdi_currency",
                            describe,@"rdi_business_desc",
                            rdi_desc,@"rdi_desc",
                            pa,@"rdi_file_list",
                            status,@"rdi_type",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"cooperationedit",@"requestKey",fields,@"fields", nil];
    return param;
}

- (IBAction)touchBEvent:(id)sender {
    [self.navigationController pushViewController:_bViewController animated:YES];
}

- (IBAction)touchCategoryEvent:(id)sender {
    [self.navigationController pushViewController:_categoryViewController animated:YES];
}

- (IBAction)touchStatusEvent:(id)sender{
    [self.navigationController pushViewController:_statusViewController animated:YES];
}

- (IBAction)touchRegionEvent:(id)sender {
    [self.navigationController pushViewController:_regionViewController animated:YES];
}

- (IBAction)touchIndustyEvent:(id)sender {
        [self.navigationController pushViewController:_industryViewController animated:YES];
}

- (IBAction)touchAddressEvent:(id)sender {
        [self.navigationController pushViewController:_addressViewController animated:YES];
}

- (IBAction)touchDateEvent:(id)sender {
    [_describeTextView resignFirstResponder];
    [_typeTextView resignFirstResponder];
    [_calcaulateField resignFirstResponder];
    [_titleLabel resignFirstResponder];
    
    CGRect frame = _startPicker.view.frame;
    frame.origin.x = 0;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x;
    _startPicker.view.frame = frame;
    
    [self.view addSubview:_startPicker.view];
}

- (IBAction)touchMediaView:(id)sender{
    _meidaViewController = [[MeidaViewController alloc] init];
    _meidaViewController.delegate = self;
    
    _meidaViewController.view.frame = self.navigationController.view.bounds;
    
    _window = [UIApplication sharedApplication].keyWindow;
    
    [_window addSubview:_meidaViewController.view];
}

- (void)meidaViewController:(MeidaViewController*)meidaViewController fileData:(NSData*)fileData type:(NSString *)type{
    _curData = fileData;
    _curType = type;
    
   
    


//    for (UIView *view in self.navigationController.view.subviews) {
//        if ([view isKindOfClass:[meidaViewController class]]) {
//            [view removeFromSuperview];
//        }
//    }
    
    _alertView = [[AlertView alloc] initWithFrame:CGRectMake(15, 120, self.view.frame.size.width-30, 125)];
    [meidaViewController.view addSubview:_alertView];
    _alertView.delegate = self;
    [_alertView setAlertButtonType:AlertButtonOne];
    [_alertView showField:[self.view getCurrentDate]];
    [_alertView.tipLabel setText:@"重命名文件"];
    
    [meidaViewController.view bringSubviewToFront:_alertView];
}

- (void)alertView:(AlertView*)AlertView field:(NSString*)text{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_curData,@"data",text,@"name",_curType,@"type",@"0",@"upload", nil];
    self.navigationController.navigationBarHidden = NO;
    
    if (_uploadTableDatas && dic) {
        [_uploadTableDatas addObject:dic];
    }
    
    
    for (NSLayoutConstraint *layout in _contentView.constraints) {
        if (layout.firstAttribute == NSLayoutAttributeHeight) {
            layout.constant = 800+ _uploadTableDatas.count * 55;
        }
    }
    for (NSLayoutConstraint *layout in self.tableView.constraints) {
        if (layout.firstAttribute == NSLayoutAttributeHeight) {
            layout.constant = _uploadTableDatas.count * 55;
        }
    }
    
    
    [self.view bringSubviewToFront:_tableView];
    [self.tableView reloadData];
}

- (void)general:(GeneralViewController *)generalViewController data:(NSDictionary *)data{
    if (generalViewController == _categoryViewController) {
        _categoryDic = data;
        [_categoryButton setTitle:[_categoryDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_categoryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _regionViewController){
        _regionDic = data;
        
        [_regionButton setTitle:[_regionDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_regionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _industryViewController){
        _industyDic = data;
        [_industyButton setTitle:[_industyDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_industyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _addressViewController){
        _addressDic = data;
        [_addressButton setTitle:[_addressDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_addressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _bViewController){
        _bDic = data;
        [_bButton setTitle:[_bDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_bButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (generalViewController == _statusViewController){
        _statusDic = data;
        [_statusButton setTitle:[_statusDic objectForKey:@"gc_name"] forState:UIControlStateNormal];
        [_statusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _uploadTableDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UploadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UploadCell"];
    
  

    
    NSDictionary *dic = (NSDictionary*)[_uploadTableDatas objectAtIndex:indexPath.row];
    
    if ([dic count] > 5) {

        cell.titelLabel.text = [dic objectForKey:@"ido_title"];
        cell.logoImageView.image = [self.view checkResourceType:[dic objectForKey:@"ido_file_type"]];
        cell.sizeLabel.text = [dic objectForKey:@"ido_create_date"];
        cell.button.hidden = YES;
        
        cell.delegate = self;
        cell.tag = indexPath.row;

        
    }
    else{
        cell.delegate = self;
        cell.tag = indexPath.row;

        cell.titelLabel.text = [dic objectForKey:@"name"];
        NSData *data = (NSData*)[dic objectForKey:@"data"];
        cell.sizeLabel.text = [NSString stringWithFormat:@"%.2fM",data.length/1024.0/1024.0];
        cell.logoImageView.image = [self.view checkResourceType:[dic objectForKey:@"type"]];
        
        cell.uploadtype = UploadtypeCooperation;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([[dic objectForKey:@"upload"] isEqualToString:@"1"]) {
            [cell.button setBackgroundImage:[UIImage imageNamed:@"download_done_logo.png"] forState:UIControlStateNormal];
            [cell.button setTitle:@"" forState:UIControlStateNormal];
            cell.button.enabled = NO;
            cell.button.hidden = NO;
        }
        else
        {
            [cell.button setBackgroundImage:[UIImage imageNamed:@"upload_btn.png"] forState:UIControlStateNormal];
            [cell.button setTitle:@"上传" forState:UIControlStateNormal];
            cell.button.enabled = YES;
            cell.button.hidden = NO;
        }
        
       
        
        if (_cooperationType == CooperationTypeAdd) {
            [cell setCooUploadFile:data type:[dic objectForKey:@"type"] title:[dic objectForKey:@"name"] rdi_id:@"" rdi_doc_id:@""];
        }
        else if (_cooperationType == CooperationTypeNew){
            [cell setCooUploadFile:data type:[dic objectForKey:@"type"] title:[dic objectForKey:@"name"] rdi_id:[_record objectForKey:@"rdi_id"] rdi_doc_id:@""];
        }
        else{
            [cell setUploadFile:data doc_class:@"" relate_case:@"" location:@"" type:[dic objectForKey:@"type"] title:[dic objectForKey:@"name"]];
            
        }
        

    }
    
    

    
    return cell;
}

- (void)uploadSuccess:(NSInteger)tag{
   NSMutableDictionary *dic = (NSMutableDictionary*)[_uploadTableDatas objectAtIndex:tag];
    [dic setValue:@"1" forKey:@"upload"];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
   // UploadCell *cell = (UploadCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
//    if (cell.button.enabled && !cell.button.selected) {
//        [_uploadTableDatas removeObjectAtIndex:indexPath.row];
//        [self.tableView reloadData];
//    }
    
//    if (!cell.button.enabled || cell.button.selected) {
//        [self showHUDWithTextOnly:@"已上传文件不能删除"];
//    }
    NSDictionary *dic = (NSDictionary*)[_uploadTableDatas objectAtIndex:indexPath.row];
    _deleteIndex = indexPath.row;
    if ([dic count] > 5) {
        deleteHttpClient = [[HttpClient alloc] init];
        deleteHttpClient.delegate = self;
        deleteHttpClient.isChange = YES;
        NSString *ido_doc_id = [dic objectForKey:@"ido_doc_id"];
        [deleteHttpClient startRequest:[self deleteParam:ido_doc_id]];
    }
    else{
        [_uploadTableDatas removeObjectAtIndex:_deleteIndex];
        [self.tableView reloadData];

    }
    
}

- (NSDictionary*)deleteParam:(NSString*)rdi_doc_id{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:[[CommomClient sharedInstance] getAccount],@"userID",[_record objectForKey:@"rdi_id"],@"rdi_id",rdi_doc_id,@"rdi_doc_id", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"cooperationfiledelete",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = (NSDictionary*)[_uploadTableDatas objectAtIndex:indexPath.row];
    documentViewController = [[DocumentViewController alloc] init];
    if ([dic count] > 5) {
        
        documentViewController.type = [dic objectForKey:@"ido_file_type"];
        documentViewController.pathString = [dic objectForKey:@"ido_file_url"];
        documentViewController.documentType = DocumentTypeWeb;
        documentViewController.name = [dic objectForKey:@"ido_title"];
    }
    else{
        documentViewController.data = [dic objectForKey:@"data"];
        documentViewController.type = [dic objectForKey:@"type"];
        documentViewController.documentType = DocumentTypeLocal;
        documentViewController.name = [dic objectForKey:@"name"];
    }
    
    
    
    [self.navigationController pushViewController:documentViewController animated:YES];
    
}

- (void)uploadFail{
    [self.tableView reloadData];
}

-(void)keyboarShow:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _sureView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = keyboardSize.height;
        }
        
    }
    
    CGSize size = self.scorll.contentSize;
    size.height = _contentView.frame.size.height + keyboardSize.height;
    self.scorll.contentSize = size;
    
}



-(void)keyBoardHide
{
    
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _sureView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = 0;
        }
        
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView{
    NSInteger max = 300;
    
    
    
    if (textView.text.length >= max)
    {
        textView.text = [textView.text substringToIndex:max];
    }
    
    NSInteger number = [textView.text length];
    
    if (textView == _typeTextView) {
        _wayLabel.text = [NSString stringWithFormat:@"您还可以输入%ld个字",max-number];
    }
    else if (textView == _describeTextView){
        _describeLabel.text = [NSString stringWithFormat:@"您还可以输入%ld个字",max-number];
    }

}


- (IBAction)touchSureEvent:(id)sender{
    if (_cooperationType == CooperationTypeAdd) {
        
    }
    else if (_cooperationType == CooperationTypeNew){
        
    }
    
    if (![_titleLabel hasText]) {
        [self showHUDWithTextOnly:@"请填写标题"];
        return;
    }
    
    if ([_categoryButton.titleLabel.text isEqualToString:@"请选择需求类型"]) {
        [self showHUDWithTextOnly:@"请选择需求类型"];
        return;
    }
    if ([_regionButton.titleLabel.text isEqualToString:@"请选择涉及领域"]) {
        [self showHUDWithTextOnly:@"请选择涉及领域"];
        return;
    }
    if ([_industyButton.titleLabel.text isEqualToString:@"请选择行业"]) {
        [self showHUDWithTextOnly:@"请选择行业"];
        return;
    }
    if ([_addressButton.titleLabel.text isEqualToString:@"请选择地区"]) {
        [self showHUDWithTextOnly:@"请选择地区"];
        return;
    }
    if ([_dateButton.titleLabel.text isEqualToString:@"请选择截止日期"]) {
        [self showHUDWithTextOnly:@"请选择截止日期"];
        return;
    }
    
    if (![_calcaulateField hasText]) {
        [self showHUDWithTextOnly:@"请填写项目总额"];
        return;
    }
    if ([_bButton.titleLabel.text isEqualToString:@"请选择币种"]) {
        [self showHUDWithTextOnly:@"请选择币种"];
        return;
    }
    
    if (![_describeTextView hasText]) {
        [self showHUDWithTextOnly:@"请填写合作描述"];
        return;
    }
    
    [_httpClient startRequest:[self requestParam]];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _calcaulateField) {
        if (textField.text.length > 20) {
            [self showHUDWithTextOnly:@"超过20个数字了"];
        }
        if (![self isPureNumandCharacters:string]) {
            [self showHUDWithTextOnly:@"请输入数字"];
        }
    }
    
    return YES;
}



- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

#pragma mark -- RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    if (request == _httpClient) {
        if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"操作成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDWithTextOnly:@"操作失败"];
        }
    }
    else if (request == _detailHttpClient){
        if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
            NSDictionary *item = [result objectForKey:@"record"];
            _record = item;
            _titleLabel.text = [item objectForKey:@"rdi_name"];
            [_categoryButton setTitle:[item objectForKey:@"rdi_bigcategory_name"] forState:UIControlStateNormal];
            [_regionButton setTitle:[item objectForKey:@"rdi_category_name"] forState:UIControlStateNormal];
            [_industyButton setTitle:[item objectForKey:@"rdi_industry_name"] forState:UIControlStateNormal];
            [_addressButton setTitle:[item objectForKey:@"rdi_regions_name"] forState:UIControlStateNormal];
            [_dateButton setTitle:[item objectForKey:@"rdi_deadline"] forState:UIControlStateNormal];
            [_bButton setTitle:[item objectForKey:@"rdi_currency"] forState:UIControlStateNormal];
            _calcaulateField.text = [item objectForKey:@"rdi_money"];
            _typeTextView.text = [item objectForKey:@"rdi_business_desc"];
            _describeTextView.text = [item objectForKey:@"rdi_desc"];
            
            if ([[item objectForKey:@"rdi_type"] isEqualToString:@"N"]) {
                [_statusButton setTitle:@"未合作" forState:UIControlStateNormal];
                
            }
            else if ([[item objectForKey:@"rdi_type"] isEqualToString:@"A"]) {
                [_statusButton setTitle:@"已合作" forState:UIControlStateNormal];
            }
            else if ([[item objectForKey:@"rdi_type"] isEqualToString:@"B"]) {
                [_statusButton setTitle:@"已过期" forState:UIControlStateNormal];
            }
            
            [_statusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [_categoryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_regionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_industyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_addressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_bButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            _file_list = [item objectForKey:@"file_list"];
            NSInteger num = _file_list.count;
            for (NSLayoutConstraint *layout in _tableView.constraints) {
                if (layout.firstAttribute == NSLayoutAttributeHeight) {
                    layout.constant = (num+1)*55;
                }
            }
            for (NSLayoutConstraint *layout in _contentView.constraints) {
                if (layout.firstAttribute == NSLayoutAttributeHeight && layout.firstItem == _contentView) {
                    layout.constant = num*55+750;
                }
            }
            
            [_uploadTableDatas addObjectsFromArray:_file_list] ;
            isEdit = YES;
            
            [_tableView reloadData];
        }
    }
    else if (request == deleteHttpClient){
        if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"删除成功"];
            [_uploadTableDatas removeObjectAtIndex:_deleteIndex];
            [self.tableView reloadData];


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
