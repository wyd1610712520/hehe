//
//  FileDownload.m
//  Law_Iphone
//
//  Created by 邬 明 on 15-1-3.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "FileDownload.h"



@interface FileDownload (){
    NSURL *_path;
    NSString *_localPath;
}

@end

@implementation FileDownload

@synthesize delegate = _delegate;

- (id)initWithPath:(NSString*)path type:(NSString*)type name:(NSString*)name{
    self = [super init];
    if (self) {
        [self createRootDir];
        
        _path = [NSURL URLWithString:path];
        
        NSString *fileName = [NSString stringWithFormat:@"%@.%@",name,type];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _localPath = [[paths lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"Files/%@",fileName]];
    }
    return self;
}

- (void)createRootDir{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [[paths lastObject] stringByAppendingPathComponent:@"Files"];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:docPath isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
}

- (BOOL)isDownload{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    if ([fileManager fileExistsAtPath:_localPath isDirectory:&isDir]) {
        NSData *fileData = [NSData dataWithContentsOfFile:_localPath];
        if (fileData.length > 0) {
            if ([_delegate respondsToSelector:@selector(fileDownload:path:)]) {
                [_delegate fileDownload:self path:_localPath];
            }
            return NO;
        }
    }
    return YES;
}

- (void)saveData:(NSData*)data type:(NSString*)type name:(NSString*)name{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileName = [NSString stringWithFormat:@"%@.%@",name,type];
    
    [self createRootDir];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _localPath = [[paths lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"Files/%@",fileName]];
    
    
//    BOOL isSuccess = [fileManager createFileAtPath:_localPath contents:data attributes:nil];
    
   // NSLog(@"data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
 BOOL isSuccess =  [data writeToFile:_localPath atomically:YES];
    
    if (isSuccess) {
        if ([_delegate respondsToSelector:@selector(fileDownload:path:)]) {
            [_delegate fileDownload:self path:_localPath];
        }
    }
    else{
        if ([_delegate respondsToSelector:@selector(fileDownloadError:)]) {
            [_delegate fileDownloadError:self];
        }
    }

}

- (void)startDownload{
    if ([self isDownload]) {
         NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:_path];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if ([data length] > 0 && connectionError == nil) {
                BOOL isSuccess = [fileManager createFileAtPath:_localPath contents:data attributes:nil];
                if (isSuccess) {
                    if ([_delegate respondsToSelector:@selector(fileDownload:path:)]) {
                        [_delegate fileDownload:self path:_localPath];
                    }
                }
                else{
                    if ([_delegate respondsToSelector:@selector(fileDownloadError:)]) {
                        [_delegate fileDownloadError:self];
                    }
                }
            }
            else{
                if ([_delegate respondsToSelector:@selector(fileDownloadError:)]) {
                    [_delegate fileDownloadError:self];
                }
            }
        }];
        if ([_delegate respondsToSelector:@selector(fileStartDownload)]) {
            [_delegate fileStartDownload];
        }
    }

    
    
}



@end
