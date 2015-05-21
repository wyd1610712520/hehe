//
//  UploadCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "UploadCell.h"

#import "UploadClient.h"

#import "KDGoalBar.h"

@interface UploadCell ()<UploadClientDelegate,UITextFieldDelegate>{
    NSData *_fileData;
    NSString *_doc_class;
    NSString *_relate_case;
    NSString *_location;
    NSString *_type;
    NSString *_title;
    
    NSString *_rdi_id;
    NSString *_rdi_doc_id;
    
    UploadClient *_uploadClient;
    
    NSString *_categoty;
    NSString *_ywcpID;
    NSString *_caseID;
    
    KDGoalBar *firstGoalBar;
}

@end

@implementation UploadCell

@synthesize uploadStatus = _uploadStatus;
@synthesize titelLabel;
@synthesize sizeLabel;
@synthesize button = _button;
@synthesize logoImageView;
@synthesize delegate = _delegate;

@synthesize titleField = _titleField;

UIImage *_uploadPauseImage = nil;
UIImage *_uploadDoneImage = nil;
UIImage *_uploadErrorImage = nil;
UIImage *_uploadProcessImage = nil;

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)initialize{
    _uploadPauseImage = [UIImage imageNamed:@"download_pause_logo.png"];
    _uploadDoneImage = [UIImage imageNamed:@"download_done_logo.png"];
    _uploadErrorImage = [UIImage imageNamed:@"download_error_logo.png"];
    _uploadProcessImage = [UIImage imageNamed:@"download_process_logo.png"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUploadFile:(NSData*)fileData
            doc_class:(NSString*)doc_class
          relate_case:(NSString*)relate_case
             location:(NSString*)location
             type:(NSString*)type
            title:(NSString*)title{
    _fileData = fileData;
    _doc_class = doc_class;
    _relate_case = relate_case;
    _location = location;
    _type = type;
    _title = title;
    
    _uploadClient = [[UploadClient alloc] init];
    _uploadClient.delegate = self;
}

- (void)setCooUploadFile:(NSData*)fileData
                    type:(NSString*)type
                   title:(NSString*)title
                  rdi_id:(NSString*)rdi_id
              rdi_doc_id:(NSString*)rdi_doc_id{
    _fileData = fileData;
    _type = type;
    _title = title;
    _rdi_id = rdi_id;
    _rdi_doc_id = rdi_doc_id;
    
    _uploadClient = [[UploadClient alloc] init];
    _uploadClient.delegate = self;
}

- (void)setProcessUploadFile:(NSData*)fileData
                        type:(NSString*)type
                      caseID:(NSString*)caseID
                       title:(NSString*)title
                      ywcpID:(NSString*)ywcpID
                    category:(NSString*)category{
    _fileData = fileData;
    _type = type;
    _title = title;
    _categoty = category;
    _ywcpID = ywcpID;
    _caseID = caseID;
    
    _uploadClient = [[UploadClient alloc] init];
    _uploadClient.delegate = self;
}

- (IBAction)touchDownEvent:(UIButton*)sender{
    
//    if (_uploadStatus == Uploading) {
//        
//    }
//    else if (_uploadStatus == UploadPause){
//        [sender setBackgroundImage:_uploadPauseImage forState:UIControlStateNormal];
//    }
//    else if (_uploadStatus == UploadDone){
//        [sender setBackgroundImage:_uploadDoneImage forState:UIControlStateNormal];
//    }
//    else if (_uploadStatus == UploadError){
//        [sender setBackgroundImage:_uploadErrorImage forState:UIControlStateNormal];
//    }
    if (_uploadtype == UploadtypeNormal) {
            [_uploadClient startUploadFile:_fileData doc_class:_doc_class relate_case:_relate_case location:_location type:_type title:_title];
    }
    else if (_uploadtype == UploadtypeResearch){
        
        if (_doc_class.length == 0 || _relate_case.length == 0) {
            if ([_delegate respondsToSelector:@selector(uploadTint)]) {
                [_delegate uploadTint];
            }
            return;
        }
        
        
        [_uploadClient startUploadFile:_fileData doc_class:_doc_class relate_case:_relate_case location:_location type:_type title:_title];
    }
    
    else if (_uploadtype == UploadtypeCooperation){
        [_uploadClient startCooUploadFile:_fileData type:_type title:_title rdi_id:_rdi_id rdi_doc_id:_rdi_doc_id];
    }
    else if (_uploadtype == UploadtypeProcess){
        [_uploadClient startProcessFile:_fileData title:_title caseID:_caseID type:_type ywcpID:_ywcpID category:_categoty];
    }
    

    
    
    _uploadStatus = Uploading;
    
    if ([_delegate respondsToSelector:@selector(startUpload:)]) {
        [_delegate startUpload:self.tag];
    }
}

- (void)startUpload{
    _uploadStatus = Uploading;
    _button.selected = YES;
    
    
    firstGoalBar = [[KDGoalBar alloc]initWithFrame:CGRectMake(0, 0, 28, 28)];
    firstGoalBar.center = _button.center;
    [firstGoalBar setPercent:0 animated:NO];
    [self addSubview:firstGoalBar];
    [self bringSubviewToFront:firstGoalBar];
    
    
    [_button setTitle:@"" forState:UIControlStateNormal];
    [_button setBackgroundImage:nil forState:UIControlStateNormal];
}

- (void)startUploadProcess:(CGFloat)progress{
    [firstGoalBar setPercent:progress animated:YES];
    _button.selected = YES;
    _button.enabled = NO;
}

- (void)uploadClientdidSccuess:(UploadClient*)uploadClient hint:(NSString *)hint{
    [firstGoalBar removeFromSuperview];
    _uploadStatus = UploadDone;
    //_button.selected = NO;
    [_button setBackgroundImage:_uploadDoneImage forState:UIControlStateNormal];
    _button.enabled = NO;
    if ([_delegate respondsToSelector:@selector(uploadSuccess:)]) {
        [_delegate uploadSuccess:self.tag];
    }
}

- (void)uploadClientdidError:(UploadClient*)uploadClient{
    [firstGoalBar removeFromSuperview];
    _button.enabled = YES;
    _uploadStatus = UploadError;
    _button.selected = NO;
    [_button setBackgroundImage:_uploadErrorImage forState:UIControlStateNormal];
    if ([_delegate respondsToSelector:@selector(uploadFail)]) {
        [_delegate uploadFail];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
