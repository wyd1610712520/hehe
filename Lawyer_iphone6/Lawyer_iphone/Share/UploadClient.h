//
//  UploadClient.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-3.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ImageUrl @"http://test.elinklaw.com/mobile/mobileuploadfile.ashx"
#define DocUrl @"http://www.elinklaw.com/mobile/mobileuploadfile.ashx"

@class UploadClient;

@protocol UploadClientDelegate <NSObject>


- (void)startUpload;
- (void)uploadClientdidSccuess:(UploadClient*)uploadClient hint:(NSString*)hint;
- (void)uploadClientdidError:(UploadClient*)uploadClient;

- (void)startUploadProcess:(CGFloat)progress;

@end


@interface UploadClient : NSObject

@property (nonatomic, strong) NSObject<UploadClientDelegate> *delegate;

- (void)startAvatorUploadFile:(NSData*)fileData;

- (void)startCooUploadFile:(NSData*)fileData
                      type:(NSString*)type
                     title:(NSString*)title
                    rdi_id:(NSString*)rdi_id
                rdi_doc_id:(NSString*)rdi_doc_id;


- (void)startUploadFile:(NSData*)fileData
              doc_class:(NSString*)doc_class
            relate_case:(NSString*)relate_case
               location:(NSString*)location
                   type:(NSString*)type
                  title:(NSString*)title;

- (void)startProcessFile:(NSData*)fileData
                   title:(NSString*)title
                  caseID:(NSString*)caseID
                    type:(NSString*)type
                  ywcpID:(NSString*)ywcpID
                category:(NSString*)category;

@end
