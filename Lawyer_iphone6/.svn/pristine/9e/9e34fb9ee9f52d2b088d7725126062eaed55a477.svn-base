//
//  FileDownload.h
//  Law_Iphone
//
//  Created by 邬 明 on 15-1-3.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FileDownload;

@protocol FileDownloadDelegate  <NSObject>

- (void)fileDownload:(FileDownload*)fileDownload path:(NSString*)path;
- (void)fileDownloadError:(FileDownload*)fileDownload;
- (void)fileStartDownload;

@end

@interface FileDownload : NSOperation

@property (nonatomic, strong) NSObject<FileDownloadDelegate> *delegate;

- (id)initWithPath:(NSString*)path type:(NSString*)type name:(NSString*)name;

- (void)startDownload;

- (void)saveData:(NSData*)data type:(NSString*)type name:(NSString*)name;

@end
