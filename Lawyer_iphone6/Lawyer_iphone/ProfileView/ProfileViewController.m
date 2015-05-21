 //
//  ProfileViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-11.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "ProfileViewController.h"

#import "HttpClient.h"

#import "CommomClient.h"

#import "ProfessionViewController.h"

#import "UIImage+ColorAtPixel.h"
#import "LanguageViewController.h"
#import "UploadClient.h"

#import "ExperienceViewController.h"
#import "NSString+Utility.h"
#import "ProjectViewController.h"

#import "EducationViewController.h"

#import "UIButton+AFNetworking.h"

@interface ProfileViewController ()<RequestManagerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UploadClientDelegate>{
    HttpClient *_profileHttpClient;
    NSDictionary *_profileMapping;
    CommomClient *_commomClient;
    
    UIActionSheet *_actionSheet;
    
    ProfessionViewController *_professionViewController;
    
    UIImagePickerController *_imagePickerController;
    
    UIImage *_selectImage;
    
    UploadClient *_uploadClient;
    
    ExperienceViewController *_experienceViewController;
    ProjectViewController *_projectViewController;
    EducationViewController *_educationViewController;
    
    HttpClient *_editHttpClient;
    
    BOOL _isEdit;
    
    BOOL _editLange;
    
    NSArray *_lans;
}

@end

@implementation ProfileViewController

@synthesize profileType = _profileType;

@synthesize scrollView = _scrollView;

@synthesize avatorButton = _avatorButton;
@synthesize nameLabel = _nameLabel;
@synthesize categoryLabel = _categoryLabel;
@synthesize areaLabel = _areaLabel;

@synthesize roomLabel = _roomLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize mobileLabel = _mobileLabel;
@synthesize emailLabel = _emailLabel;
@synthesize languageLabel = _languageLabel;
@synthesize zyLabel = _zyLabel;

@synthesize headView = _headView;
@synthesize infoView = _infoView;
@synthesize infoButtonView = _infoButtonView;
@synthesize buttonView = _buttonView;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    self.navigationController.navigationBarHidden = NO;
    [self setTitle:[Utility localizedStringWithTitle:@"profile_nav_title"] color:nil];
    
    if (_profileType == ProfileTypeNormal) {
        _infoView.frame = CGRectMake(0, _headView.frame.size.height, self.view.frame.size.width, 275);
        [_scrollView addSubview:_infoView];
        
        _buttonView.frame = CGRectMake(0, _infoView.frame.size.height + _infoView.frame.origin.y, self.view.frame.size.width, 205);
        [_scrollView addSubview:_buttonView];
        
            }
    else if (_profileType == ProfileTypeEdit){
        _infoButtonView.frame = CGRectMake(0, _headView.frame.size.height, self.view.frame.size.width, 50);
        [_scrollView addSubview:_infoButtonView];
        
        _buttonView.frame = CGRectMake(0, _headView.frame.size.height + _headView.frame.origin.y, self.view.frame.size.width, 205);
        [_scrollView addSubview:_buttonView];
    }
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _buttonView.frame.size.height+_buttonView.frame.origin.y+10)];
    
    [_profileHttpClient startRequest:[self getProfileParam]];
}

- (NSDictionary*)getProfileParam{
    NSDictionary *fileds = [NSDictionary dictionaryWithObjectsAndKeys:[_commomClient getValueFromUserInfo:@"userKey"],@"userID",[_commomClient getValueFromUserInfo:@"userOffice"],@"userOffice", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"userbasicinfo",@"requestKey",fileds,@"fields", nil];
    return param;
}



- (void)touchEditEvent{
    _editLange = YES;
    _arrImageView.hidden = NO;
    _profileType = ProfileTypeEdit;
    _mobileLabel.hidden = YES;
    _emailLabel.hidden = YES;
    _arrImageView.hidden = NO;
    
    _phoneField.hidden = NO;
    _mailField.hidden = NO;
    
    _phoneField.text = _mobileLabel.text;
    _mailField.text = _emailLabel.text;
    
    _isEdit = YES;
    [self setRightButton:nil title:@"完成" target:self action:@selector(touchComplete)];
}

- (void)touchComplete{
    _editLange = NO;
    _isEdit = NO;
    
    _arrImageView.hidden = YES;
    _mobileLabel.hidden = NO;
    _emailLabel.hidden = NO;
    
    _mobileLabel.text = _phoneField.text;
    _emailLabel.text = _mailField.text;
    
    _phoneField.hidden = YES;
    _mailField.hidden = YES;
    [self setRightButton:[UIImage imageNamed:@"blut_edit_logo.png"] title:nil target:self action:@selector(touchEditEvent)];
    
    [_editHttpClient startRequest:[self param]];
}

- (NSDictionary*)param{
    NSMutableString *titles = [[NSMutableString alloc] initWithFormat:@""];
    

    if (_lans.count > 0) {
        for (NSDictionary *item in _lans) {
            NSString *name = [item objectForKey:@"gc_id"];
            [titles appendFormat:@"%@,",name];
        }
    }
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:_nameLabel.text,@"emp_name",
                            _phoneLabel.text,@"emp_phone1",
                            _mobileLabel.text,@"emp_phone",
                            _emailLabel.text,@"emp_email",
                            titles,@"emp_language",
                            @"",@"emp_zy",
                            [[CommomClient sharedInstance] getAccount],@"userID",
                            [[CommomClient sharedInstance] getValueFromUserInfo:@"userOffice"],@"user_officeID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"userbasicinfomodify",@"requestKey",fields,@"fields", nil];
    return param;
}

- (IBAction)touchButtonEvent:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if (tag == 0) {
        
    }
    else if (tag == 1){
        [self.navigationController pushViewController:_professionViewController animated:YES];
    }
    else if (tag == 2){
        [self.navigationController pushViewController:_experienceViewController animated:YES];
    }
    else if (tag == 3){
        [self.navigationController pushViewController:_projectViewController animated:YES];
    }
    else if (tag == 4){
        [self.navigationController pushViewController:_educationViewController animated:YES];
    }
    
}

- (IBAction)touchAvatorEvent:(id)sender{
    [_actionSheet showInView:self.view];
}

- (void)receivesLan:(NSNotification*)not{
    _profileType = ProfileTypeNormal;
    NSArray *lan = (NSArray*)[not object];
    _lans = lan;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDismissButton];
    [self setRightButton:[UIImage imageNamed:@"blut_edit_logo.png"] title:nil target:self action:@selector(touchEditEvent)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesLan:) name:@"lan" object:nil];
    
    
    [_contentView setBackgroundColor:[@"#F9F9F9" colorValue]];
    
    _actionSheet = [[UIActionSheet alloc] initWithTitle:@"选取头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    
    _avatorButton.layer.borderColor = [UIColor clearColor].CGColor;
    
    _professionViewController = [[ProfessionViewController alloc] init];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    
    _phoneField.leftIndsets = UIEdgeInsetsMake(0, 3, 0,0);
    _mailField.leftIndsets = UIEdgeInsetsMake(0, 3, 0,0);
//    _phoneField.layer.borderColor = [UIColor darkGrayColor].CGColor;
//    _phoneField.layer.borderWidth = 1;
//    _phoneField.layer.cornerRadius = 5;
//    
//    _mailField.layer.borderColor = [UIColor darkGrayColor].CGColor;
//    _mailField.layer.borderWidth = 1;
//    _mailField.layer.cornerRadius = 5;
    
    _uploadClient = [[UploadClient alloc] init];
    _uploadClient.delegate = self;
    
    _editHttpClient = [[HttpClient alloc] init];
    _editHttpClient.delegate = self;
    
    _commomClient = [CommomClient sharedInstance];
    
    _profileHttpClient = [[HttpClient alloc] init];
    _profileHttpClient.delegate = self;
    [_profileHttpClient startRequest:[self getProfileParam]];

    
    _experienceViewController = [[ExperienceViewController alloc] init];
    _projectViewController = [[ProjectViewController alloc] init];
    _educationViewController = [[EducationViewController alloc] init];
    
    self.isSet = YES;
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    _imagePickerController.allowsEditing = YES;
    if (buttonIndex == 0) {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePickerController.mediaTypes = @[(NSString*)kUTTypeImage];
        
        [self presentViewController:_imagePickerController animated:YES completion:nil];

    }
    else if (buttonIndex == 1) {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (!error) {
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        _selectImage = [theImage imageByScalingAndCroppingForSize:CGSizeMake(300, 300)];
        
      //  UIImageWriteToSavedPhotosAlbum(_selectImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        [_uploadClient startAvatorUploadFile:UIImageJPEGRepresentation(_selectImage, 0.7)];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([_imagePickerController.view window] == nil) {
        _imagePickerController.view = nil;
    }
}

- (void)uploadClientdidSccuess:(UploadClient*)uploadClient hint:(NSString *)hint
{
    NSString *path = [_profileMapping objectForKey:@"emp_photo_url"];
    //[_avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:path]];
    [_avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"avator.png"]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AvatorUpdate object:nil];
}

- (void)uploadClientdidError:(UploadClient *)uploadClient{
    
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *setupMapping = (NSDictionary*)responseObject;
    if (request == _profileHttpClient) {
        _profileMapping = (NSDictionary*)[setupMapping objectForKey:@"record"];
        [_avatorButton setDownloadImage:[_profileMapping objectForKey:@"emp_photo_url"]];
        _nameLabel.text = [_profileMapping objectForKey:@"emp_name"];
        _categoryLabel.text = [_profileMapping objectForKey:@"emp_category_name"];
        _areaLabel.text = [NSString stringWithFormat:@"%@-%@",[_profileMapping objectForKey:@"emp_area_name"],[_profileMapping objectForKey:@"emp_dept_name"]];
        _roomLabel.text = [_profileMapping objectForKey:@"emp_room_no"];
        _phoneLabel.text = [_profileMapping objectForKey:@"emp_phone1"];
        _mobileLabel.text = [_profileMapping objectForKey:@"emp_phone"];
        _emailLabel.text = [_profileMapping objectForKey:@"emp_email"];
        _languageLabel.text = [_profileMapping objectForKey:@"emp_language_name"];
        _zyLabel.text = [_profileMapping objectForKey:@"emp_zy_name"];
        
        
        if (_lans.count > 0) {
            NSMutableString *titles = [[NSMutableString alloc] init];
            for (NSDictionary *item in _lans) {
                NSString *name = [item objectForKey:@"gc_name"];
                [titles appendFormat:@"%@,",name];
            }
            _languageLabel.text = titles;
        }
    }
    else if (request == _editHttpClient){
        if ([[setupMapping objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"编辑成功"];
        }
        else{
            [self showHUDWithTextOnly:@"编辑失败"];
        }
    }
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}



- (IBAction)touchLanEvent:(id)sender {
    if (_editLange) {
        LanguageViewController *languageViewController = [[LanguageViewController alloc] init];
        
        NSArray *names = [[_profileMapping objectForKey:@"emp_language_name"] componentsSeparatedByString:@","];
        NSArray *ids = [[_profileMapping objectForKey:@"emp_language"] componentsSeparatedByString:@","];
        
        NSMutableArray *datas = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < names.count; i++) {
            NSString *name = [names objectAtIndex:i];
            NSString *nameid = [ids objectAtIndex:i];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:nameid,@"gc_id",name,@"gc_name", nil];
            [datas addObject:dic];
        }
        
        languageViewController.array = datas;
        [self.navigationController pushViewController:languageViewController animated:YES];
    }
    
}
@end
