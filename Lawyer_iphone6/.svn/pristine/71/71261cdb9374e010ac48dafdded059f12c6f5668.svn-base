//
//  UploadCell.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UploadButton.h"

//#F95C1E uploading

typedef enum {
    Uploading = 1,
    UploadDone = 2,
    UploadPause = 3,
    UploadError = 4,
}UploadStatus;

typedef enum {
    UploadtypeNormal = 0,
    UploadtypeCooperation = 1,
    UploadtypeResearch = 2,
    UploadtypeProcess = 3,
}Uploadtype;

@class UploadCell;

@protocol UploadCellDelegate  <NSObject>
@optional
- (void)uploadSuccess:(NSInteger)tag;
- (void)uploadFail;
- (void)uploadTint;
- (void)startUpload:(NSInteger)tag;

@end



@interface UploadCell : UITableViewCell

@property (nonatomic, strong) NSObject<UploadCellDelegate> *delegate;

@property (nonatomic, assign) UploadStatus uploadStatus;
@property (nonatomic, assign) Uploadtype uploadtype;

@property (nonatomic, strong) IBOutlet UITextField *titleField;
@property (nonatomic, strong) IBOutlet UILabel *titelLabel;
@property (nonatomic, strong) IBOutlet UILabel *sizeLabel;
@property (nonatomic, strong) IBOutlet UIButton *button;
@property (nonatomic, strong) IBOutlet UIImageView *logoImageView;

- (IBAction)touchDownEvent:(UIButton*)sender;

- (void)setUploadFile:(NSData*)fileData
            doc_class:(NSString*)doc_class
          relate_case:(NSString*)relate_case
             location:(NSString*)location
                 type:(NSString*)type
                title:(NSString*)title;

- (void)setCooUploadFile:(NSData*)fileData
                    type:(NSString*)type
                   title:(NSString*)title
                  rdi_id:(NSString*)rdi_id
              rdi_doc_id:(NSString*)rdi_doc_id;

- (void)setProcessUploadFile:(NSData*)fileData
                        type:(NSString*)type
                      caseID:(NSString*)caseID
                   title:(NSString*)title
                  ywcpID:(NSString*)ywcpID
              category:(NSString*)category;

@end
