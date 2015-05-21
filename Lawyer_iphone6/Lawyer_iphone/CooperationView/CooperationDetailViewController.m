//
//  CooperationDetailViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-9.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CooperationDetailViewController.h"

#import "PartnerViewController.h"

#import "CommentViewController.h"

#import "HttpClient.h"

#import "UIButton+AFNetworking.h"

#import "FileView.h"

#import "UIImageView+AFNetworking.h"

#import "DocumentViewController.h"

#import "CommomClient.h"

#import "CloseView.h"

#import "ShareViewController.h"

#import "PersonInfoViewController.h"

DocumentViewController *documentViewController;

@interface CooperationDetailViewController ()<RequestManagerDelegate,FileViewDelegate>{
    UIButton *_rightButton;
    
    PartnerViewController *_partnerViewController;
    
    CommentViewController *_commentViewController;
    
    HttpClient *_httpClient;
    HttpClient *_topHttpClient;
    
    NSDictionary *_record;
    
    BOOL _isPass;
    
    NSTimer *_timer;
    
    NSDate *_deaDate;
    
    NSString *_public;
    
    CGFloat _keyHeight;
    BOOL isEdit;
    
    NSNotification *_notification;
    
    HttpClient *_sendHttpClient;
    
    UIView *_closeView;
    
    UIButton *_curButton;
    
    ShareViewController *_shareViewController;
}



@end

@implementation CooperationDetailViewController

@synthesize contentView = _contentView;
@synthesize titleLabel = _titleLabel;
@synthesize nameLabel = _nameLabel;
@synthesize dateLabel = _dateLabel;
@synthesize followerLabel = _followerLabel;
@synthesize stateLabel = _stateLabel;
@synthesize timeLabel = _timeLabel;

@synthesize typeLabel = _typeLabel;
@synthesize categoryLabel = _categoryLabel;
@synthesize industryLabel = _industryLabel;
@synthesize areaLabel = _areaLabel;
@synthesize deadlineLabel = _deadlineLabel;

@synthesize describeLabel = _describeLabel;

@synthesize moneyLabel = _moneyLabel;
@synthesize businessLabel = _businessLabel;

@synthesize publicLabel = _publicLabel;
@synthesize parterLabel = _parterLabel;
@synthesize companyLabel = _companyLabel;
@synthesize avatorButton = _avatorButton;

@synthesize attachLabel = _attachLabel;

@synthesize cooperationId = _cooperationId;
@synthesize attachView = _attachView;

@synthesize timeImageView = _timeImageView;

@synthesize avatorView = _avatorView;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_httpClient startRequest:[self requestParam]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)touchRight{
    _commentViewController.cooperationID = [_record objectForKey:@"rdi_id"];
    _commentViewController.rdi_creator = [_record objectForKey:@"rdi_creator"];
    [self.navigationController pushViewController:_commentViewController animated:YES];
}

- (NSDictionary*)requestParam{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_cooperationId,@"rdi_id", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"cooperationdetail",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _timeLabel.hidden = YES;
    _timeLabel.text = @"";
    _timeImageView.hidden = YES;
    [_timer invalidate];
    [_textView resignFirstResponder];
    [self keyBoardHide];
}

- (void)calculateTime:(NSDate*)deadDate{
    NSTimeInterval nowTimeInterval = [deadDate timeIntervalSinceNow];
    if (nowTimeInterval <= 0) {
        _isPass = YES;
        _timeLabel.hidden = YES;
        _timeImageView.hidden = YES;
        [_timer invalidate];
        _timeLabel.text = @"";
        
        [_httpClient startRequest:[self requestParam]];
        
        return;
    }
    
    NSString *day = [NSString stringWithFormat:@"%ld",(long)nowTimeInterval/86400];
    nowTimeInterval = nowTimeInterval - day.intValue*86400;
    NSString *hour = [NSString stringWithFormat:@"%ld",(long)nowTimeInterval/3600];
    nowTimeInterval = nowTimeInterval - hour.intValue*3600;
    NSString *minte = [NSString stringWithFormat:@"%ld",(long)nowTimeInterval/60];
    
    NSInteger miao = nowTimeInterval - minte.intValue*60;
    NSString *second = [NSString stringWithFormat:@"%ld",(long)miao];

    NSString *time = [NSString stringWithFormat:@"%@天%@小时%@分钟%@秒 后截止",day,hour,minte,second];
    _timeLabel.text = time;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    for (NSLayoutConstraint *layout in _contentView.constraints) {
        if (layout.firstAttribute == NSLayoutAttributeWidth) {
            layout.constant = [UIScreen mainScreen].bounds.size.width;
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [[UIImage imageNamed:@"comment_background.png"] stretchableImageWithLeftCapWidth:3 topCapHeight:10];
    [_rightButton setBackgroundImage:image forState:UIControlStateNormal];
    _rightButton.frame = CGRectMake(0, 0, 59, 25);
    _rightButton.titleEdgeInsets = UIEdgeInsetsMake(3, 0, 0, 5);
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [_rightButton addTarget:self action:@selector(touchRight) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesProfile:) name:@"moProfile" object:nil];
    
    _partnerViewController = [[PartnerViewController alloc] init];
    
    _commentViewController = [[CommentViewController alloc] init];
    
    _httpClient = [[HttpClient alloc] init];
    _httpClient.delegate = self;
    _httpClient.isChange = YES;
    
    _topHttpClient = [[HttpClient alloc] init];
    _topHttpClient.delegate = self;
    _topHttpClient.isChange = YES;
    
    
    _sendHttpClient = [[HttpClient alloc] init];
    _sendHttpClient.delegate = self;
    _sendHttpClient.isChange = YES;
    _public = @"1";
    
    _shareViewController = [[ShareViewController alloc] init];
    _shareViewController.shareType = ShareTypeCustom;
    
    _closeView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _closeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
}

- (IBAction)touchPartnerEvent:(id)sender{
    PersonInfoViewController *personInfoViewController = [[PersonInfoViewController alloc] init];
    personInfoViewController.rdi_creator = [_record objectForKey:@"rdi_creator"];
    
    [self.navigationController pushViewController:personInfoViewController animated:YES];
}

- (IBAction)touchCommentEvent:(UIButton *)sender {
    _commentView.hidden = NO;
    [_textView becomeFirstResponder];
    [self.view insertSubview:_closeView atIndex:1];
}

- (NSDictionary*)topParam:(NSString*)type{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_cooperationId,@"rdi_id",[[CommomClient sharedInstance] getAccount],@"userID",type,@"action_type", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:fields,@"fields",@"cooperationaction",@"requestKey", nil];
    return param;
}

- (IBAction)touchTopEvent:(UIButton *)sender {
    _curButton = sender;
    if (sender.selected) {
        sender.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 15, -18);
        [_topHttpClient startRequest:[self topParam:@"unzan"]];
    }
    else{
        sender.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 15, -25);
        [_topHttpClient startRequest:[self topParam:@"zan"]];
    }
    
}

- (IBAction)touchFollowerEvent:(UIButton *)sender {
    _curButton = sender;
    if (sender.selected) {
        [_topHttpClient startRequest:[self topParam:@"uncare"]];
    }
    else{
        [_topHttpClient startRequest:[self topParam:@"care"]];
    }
}

- (IBAction)touchCollection:(UIButton *)sender {
    _curButton = sender;
    if (sender.selected) {
        [_topHttpClient startRequest:[self topParam:@"uncollect"]];
    }
    else{
        [_topHttpClient startRequest:[self topParam:@"collect"]];
    }

}

- (IBAction)touchShareEvent:(UIButton *)sender {
    [_shareViewController sendInfo:nil title:[_record objectForKey:@"rdi_name"] descri:[_record objectForKey:@"rdi_desc"] redictUrl:[_record objectForKey:@"rdi_share_url"]];
    [_shareViewController show];
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (NSDate*)convertDateFromString:(NSString*)uiDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date=[formatter dateFromString:uiDate];
    return date;
}

- (void)calculate{
    [self calculateTime:_deaDate];
}


- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *result = (NSDictionary*)responseObject;
    
    if (request == _httpClient) {
        if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
            NSDictionary *item = [result objectForKey:@"record"];
            _record = item;
            NSString *count= [NSString stringWithFormat:@"%@评论",[item objectForKey:@"rdi_reply_cnt"]];
            [_rightButton setTitle:count forState:UIControlStateNormal];
            
            _titleLabel.text = [_record objectForKey:@"rdi_name"];
            _nameLabel.text = [item objectForKey:@"rdi_creator_name"];
            _dateLabel.text = [item objectForKey:@"rdi_deadline"];
            _followerLabel.text = [item objectForKey:@"rdi_care_cnt"];
            _stateLabel.text = [item objectForKey:@"rdi_type_name"];
            
            if ([[item objectForKey:@"rdi_type"] isEqualToString:@"N"]) {

                
                NSString *dateStr = [item objectForKey:@"rdi_deadline_full"];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                _deaDate=[formatter dateFromString:dateStr];
                
                NSDate *tempData = [NSDate date];
                
                if ([[tempData earlierDate:_deaDate] isEqualToDate:tempData]) {
                    [_timer invalidate];
                    _timeLabel.hidden = NO;
                    _timeImageView.hidden = NO;
                    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calculate) userInfo:nil repeats:YES];
                    _timeImageView.hidden = NO;
                }
                else{
                    _timeLabel.text = @"";
                    _timeLabel.hidden = YES;
                    _timeImageView.hidden = YES;
                    [_timer invalidate];
                }
                
                

            }
            else{
                _timeLabel.text = @"";
                _timeLabel.hidden = YES;
                _timeImageView.hidden = YES;
                [_timer invalidate];
            }
            
            
            
            _typeLabel.text = [item objectForKey:@"rdi_bigcategory_name"];
            _categoryLabel.text = [item objectForKey:@"rdi_category_name"];
            _industryLabel.text = [item objectForKey:@"rdi_industry_name"];
            _areaLabel.text = [item objectForKey:@"rdi_regions_name"];
            _deadlineLabel.text = [item objectForKey:@"rdi_deadline"];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[item objectForKey:@"rdi_business_desc"]];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            
            [paragraphStyle setLineSpacing:8];//调整行间距
            
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [[item objectForKey:@"rdi_business_desc"] length])];

            
            _describeLabel.attributedText = attributedString;
            
            _moneyLabel.text = [NSString stringWithFormat:@"%@%@",[item objectForKey:@"rdi_currency_type"],[item objectForKey:@"rdi_money"]];
            _businessLabel.text = [item objectForKey:@"rdi_desc"];
            [_businessLabel sizeToFit];
            
            _publicLabel.text = [item objectForKey:@"rdi_creator_name"];
            _parterLabel.text = [item objectForKey:@"rdi_business_desc"];
            _companyLabel.text = [item objectForKey:@"rdi_creator_office"];
            
            NSString *path = [item objectForKey:@"rdi_creator_photo"];
            if ([path length] > 0) {
                NSURL *url = [NSURL URLWithString:path];

                [_avatorButton setBackgroundImageForState:UIControlStateNormal withURL:url];
                _avatorButton.layer.borderColor = [UIColor clearColor].CGColor;
                
            }

            int i = 0;
            NSInteger num= [[item objectForKey:@"file_list"] count];
            
            if (num == 0) {
                _careY.constant = -20;
            }
            else{
                _careY.constant = 10;
            }
            
            UIFont *font = [UIFont systemFontOfSize:16];
            CGSize size = CGSizeMake(_describeLabel.frame.size.width, 20000);
            
            NSDictionary *textAttributes = @{NSFontAttributeName: font,
                                             NSParagraphStyleAttributeName: paragraphStyle};
            
            
            CGRect labelsize = [[item objectForKey:@"rdi_desc"] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
            
            CGSize size1 = CGSizeMake(_businessLabel.frame.size.width, 20000);
            CGRect busize = [[item objectForKey:@"rdi_business_desc"] boundingRectWithSize:size1 options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
            
            
            
            if (num > 0) {
                for (NSLayoutConstraint *layout in _attachView.constraints) {
                    if (layout.firstAttribute == NSLayoutAttributeHeight) {
                        layout.constant = num*60;
                    }
                }
                
                
                for (NSDictionary *dic in [item objectForKey:@"file_list"]) {
                    
                    FileView *fileView = [[FileView alloc] initWithFrame:CGRectMake(0, i*60, self.view.frame.size.width, 60)];
                    fileView.delegate = self;
                    
                    fileView.tag = i;
                    ++i;
                    fileView.translatesAutoresizingMaskIntoConstraints = YES;
                    fileView.titleLabel.text = [dic objectForKey:@"ido_title"];
                    fileView.nameLabel.text = [self getDate:[dic objectForKey:@"ido_create_date"] formatter:@"yyyy-MM-dd"];
                    
                    NSString *type = [dic objectForKey:@"ido_file_type"];
                    [fileView.logoImageView setImage:[self.view checkResourceType:type]];
                    [_attachView addSubview:fileView];

                    
                    
                    if (i == num) {
                        fileView.lineView.hidden = YES;
                    }

                }

                
                
            }
            else{
                for (NSLayoutConstraint *layout in _attachView.constraints) {
                    if (layout.firstAttribute == NSLayoutAttributeHeight) {
                        layout.constant = 0;
                    }
                }
                _lineView.hidden = YES;
                _attachLabel.hidden = YES;
            }
            
            if ([[item objectForKey:@"care_list"] count] > 0 ) {
                
                [_avatorView setAvators:[item objectForKey:@"care_list"]];
                _avatorView.managerLogo.hidden = YES;
            }
            else{
                _careLabel.hidden = YES;
                [_avatorView setAvators:nil];
            }
            
            for (NSLayoutConstraint *layout in _contentView.constraints) {
                if (layout.firstAttribute == NSLayoutAttributeHeight) {
                    CGFloat hei = 700+(num+1)*60+labelsize.size.height*1.5+busize.size.height;
                    layout.constant = hei;
                }
                
 
            }
            
         
            
            if ([[item objectForKey:@"rdi_is_zan"] isEqualToString:@"0"]) {
                _topButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 15, -18);
                _topButton.selected = NO;
            }
            else{
                _topButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 15, -25);
                _topButton.selected = YES;
            }
            
            if ([[item objectForKey:@"rdi_is_care"] isEqualToString:@"0"]) {
                _guanzhuButton.selected = NO;
            }
            else{
                _guanzhuButton.selected = YES;
            }
            
            if ([[item objectForKey:@"rdi_is_collect"] isEqualToString:@"0"]) {
                _favoriteButton.selected = NO;
            }
            else{
                _favoriteButton.selected = YES;
            }
            
        }
    }
    else if (request == _topHttpClient){
         if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
            //[self showHUDWithTextOnly:@"操作成功"];
             [_httpClient startRequest:[self requestParam]];
            
             [self.view bringSubviewToFront:_careLabel];
             _careLabel.hidden = NO;
            if (_curButton.selected) {
                _curButton.selected = NO;
            }
            else{
                _curButton.selected = YES;
            }
            
        }
        else{
            [self showHUDWithTextOnly:@"操作失败"];
        }

    }
    else if (request == _sendHttpClient){
                if ([[result objectForKey:@"mgid"] isEqualToString:@"true"]) {
                    [self showHUDWithTextOnly:@"发表成功"];
                    [self keyBoardHide];
                    _commentViewController.cooperationID = [_record objectForKey:@"rdi_id"];
                    [self.navigationController pushViewController:_commentViewController animated:YES];
                }
                else{
                    [self showHUDWithTextOnly:@"发表失败"];
                }
        
    }
}

- (void)receivesProfile:(NSNotification*)notification{
    NSDictionary *dic = (NSDictionary*)[notification object];

    PersonInfoViewController *personInfoViewController = [[PersonInfoViewController alloc] init];
    personInfoViewController.rdi_creator = [dic objectForKey:@"rda_care_id"];
    
    [self.navigationController pushViewController:personInfoViewController animated:YES];
}

- (void)fileView:(FileView *)fileView tag:(NSInteger)tag{
    NSArray *item = [_record objectForKey:@"file_list"];
    NSDictionary *dic = [item objectAtIndex:tag];
    
    documentViewController = [[DocumentViewController alloc] init];
    
    documentViewController.pathString = [dic objectForKey:@"ido_file_url"];
    documentViewController.type = [dic objectForKey:@"ido_file_type"];
    documentViewController.name = [dic objectForKey:@"ido_title"];
    [self.navigationController pushViewController:documentViewController animated:YES];

}




- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}

-(void)keyboarShow:(NSNotification *) notif
{
    _notification = notif;
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    _keyHeight = keyboardSize.height;
    
    
    
    _commentBottom.constant = _keyHeight;
    
    
    [_textView becomeFirstResponder];
}

-(void)keyBoardHide
{
    
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _commentView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = 0;
        }
        
    }
    [_closeView removeFromSuperview];
    _textView.text = @"";
    _commentView.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    for (NSLayoutConstraint *layout in self.view.constraints) {
        if (layout.secondItem == _commentView && layout.secondAttribute == NSLayoutAttributeBottom) {
            layout.constant = _keyHeight-50;
        }
        
    }
    return YES;
}

- (IBAction)touchCloseButton:(id)sender {
    [_textView resignFirstResponder];
    [self keyBoardHide];
}

- (IBAction)touchSureEvent:(id)sender {
    if (![_textView hasText]) {
        [self showHUDWithTextOnly:@"请输入评论"];
        return;
    }
    
    
    
    [_sendHttpClient startRequest:[self commentParam:@"" content:_textView.text public:_public]];
    [_textView resignFirstResponder];
    [self keyBoardHide];
    
}

- (NSDictionary*)commentParam:(NSString*)rdr_id content:(NSString*)content public:(NSString*)public{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_cooperationId,@"rdi_id",rdr_id,@"rdr_id",content,@"rdr_content",public,@"rdr_is_public", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"cooperationreplyedit",@"requestKey",fields,@"fields", nil];
    return param;
}

- (IBAction)touchSwitchEvent:(UISwitch*)sender {
    if (sender.on) {
        _public = @"0";
    }
    else{
        _public = @"1";
    }
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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self keyBoardHide];
        return NO;
    }
    return YES;
}


@end
