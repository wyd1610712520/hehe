//
//  UploadClient.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-3.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "UploadClient.h"

#import "CommomClient.h"

#import "AFNetworking.h"

#import "CommomClient.h"

@interface UploadClient (){
    
    NSString *_baseUrl;
    
    NSMutableData *_responseData;
    
    NSString *_userKey;
    NSString *_userOffice;
}

@end

@implementation UploadClient

@synthesize delegate = _delegate;

- (id)init{
    self = [super init];
    if (self) {
        _userKey = (NSString*)[[CommomClient sharedInstance] getValueFromUserInfo:@"userKey"];
        _userOffice = (NSString*)[[CommomClient sharedInstance] getValueFromUserInfo:@"userOffice"];
        _responseData = [[NSMutableData alloc] init];

    }
    return self;
}

- (NSString*)getCurrentDate{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:date];
}

- (void)startAvatorUploadFile:(NSData*)fileData{
    NSString *time = [self getCurrentDate];
    CGFloat size = fileData.length/1024.0/1024.0;
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:DocUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"userphotomodify" forHTTPHeaderField:@"requestKey"];
    [request setValue:_userKey forHTTPHeaderField:@"us_user_key"];
    [request setValue:time forHTTPHeaderField:@"us_file_name"];
    [request setValue:@"png" forHTTPHeaderField:@"us_file_type"];
    [request setValue:[NSString stringWithFormat:@"%f",size] forHTTPHeaderField:@"us_file_length"];
    [request setValue:_userOffice forHTTPHeaderField:@"us_office_id"];
     [request setHTTPBody:fileData];
     NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
     [con start];
    if ([_delegate respondsToSelector:@selector(startUpload)]) {
        [_delegate startUpload];
    }

}

- (void)startUploadFile:(NSData*)fileData
              doc_class:(NSString*)doc_class
            relate_case:(NSString*)relate_case
               location:(NSString*)location
               type:(NSString*)type
                title:(NSString*)title{
   // NSString *time = [self getCurrentDate];
    CGFloat size = fileData.length/1024.0/1024.0;
    
    _baseUrl = [[CommomClient sharedInstance] getValueFromUserInfo:@"userUrl"];
    
    NSString *c = [NSString stringWithFormat:@"%c",[_baseUrl characterAtIndex:_baseUrl.length-1]];
    if (![c isEqualToString:@"/"]) {
        _baseUrl = [_baseUrl stringByAppendingFormat:@"/"];
    }
    
    NSString *baseUrl = @"";
    if (_baseUrl.length > 0) {
        baseUrl = [NSString stringWithFormat:@"%@/mobile/mobileuploadfile_new.ashx",_baseUrl];
    }
    else{
        baseUrl = DocUrl;
    }
    
    
    NSURL *url = [NSURL URLWithString:baseUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:1800];
    
    
     NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)title, NULL, NULL,  kCFStringEncodingUTF8 ));

    
     NSString * locationString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)location, NULL, NULL,  kCFStringEncodingUTF8 ));
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"docfileupload" forHTTPHeaderField:@"requestKey"];
    [request setValue:_userKey forHTTPHeaderField:@"do_user_key"];
    [request setValue:encodedString forHTTPHeaderField:@"do_title"];
    [request setValue:type forHTTPHeaderField:@"do_file_type"];
    [request setValue:[NSString stringWithFormat:@"%f",size] forHTTPHeaderField:@"do_file_length"];
    [request setValue:doc_class forHTTPHeaderField:@"do_doc_class"];
    [request setValue:relate_case forHTTPHeaderField:@"do_relate_case"];
    [request setValue:locationString forHTTPHeaderField:@"do_location"];
    [request setValue:_userOffice forHTTPHeaderField:@"do_office_id"];
    [request setHTTPBody:fileData ];
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [con start];
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    NSProgress *progress = nil;
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromData:fileData progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (!error) {
//            NSLog(@"%f",progress.fractionCompleted);
//        }
//    }];
//    [uploadTask resume];
    
    if ([_delegate respondsToSelector:@selector(startUpload)]) {
        [_delegate startUpload];
    }

}

- (void)startCooUploadFile:(NSData*)fileData
                      type:(NSString*)type
                     title:(NSString*)title
                    rdi_id:(NSString*)rdi_id
                rdi_doc_id:(NSString*)rdi_doc_id{
    CGFloat size = fileData.length/1024.0/1024.0;
    
    _baseUrl = [[CommomClient sharedInstance] getValueFromUserInfo:@"userUrl"];
    
    NSString *c = [NSString stringWithFormat:@"%c",[_baseUrl characterAtIndex:_baseUrl.length-1]];
    if (![c isEqualToString:@"/"]) {
        _baseUrl = [_baseUrl stringByAppendingFormat:@"/"];
    }
    
    NSString *baseUrl = @"";
    if (_baseUrl.length > 0) {
        baseUrl = [NSString stringWithFormat:@"%@/mobile/mobileuploadfile_new.ashx",_baseUrl];
    }
    else{
        baseUrl = DocUrl;
    }
    
    NSURL *url = [NSURL URLWithString:baseUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:1800];
    
    
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)title, NULL, NULL,  kCFStringEncodingUTF8 ));
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"cooperationfile" forHTTPHeaderField:@"requestKey"];
    [request setValue:encodedString forHTTPHeaderField:@"rdi_file_name"];
    [request setValue:type forHTTPHeaderField:@"rdi_file_type"];
    [request setValue:[NSString stringWithFormat:@"%f",size] forHTTPHeaderField:@"rdi_file_length"];
    [request setValue:rdi_id forHTTPHeaderField:@"rdi_id"];
    [request setValue:rdi_doc_id forHTTPHeaderField:@"rdi_doc_id"];
    [request setHTTPBody:fileData];
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [con start];
    if ([_delegate respondsToSelector:@selector(startUpload)]) {
        [_delegate startUpload];
    }

}

- (void)startProcessFile:(NSData*)fileData
                   title:(NSString*)title
                  caseID:(NSString*)caseID
                    type:(NSString*)type
                  ywcpID:(NSString*)ywcpID
                category:(NSString*)category{
    CGFloat size = fileData.length/1024.0/1024.0;
    
    _baseUrl = [[CommomClient sharedInstance] getValueFromUserInfo:@"userUrl"];
    
    NSString *c = [NSString stringWithFormat:@"%c",[_baseUrl characterAtIndex:_baseUrl.length-1]];
    if (![c isEqualToString:@"/"]) {
        _baseUrl = [_baseUrl stringByAppendingFormat:@"/"];
    }
    
    NSString *baseUrl = @"";
    if (_baseUrl.length > 0) {
        baseUrl = [NSString stringWithFormat:@"%@/mobile/mobileuploadfile_new.ashx",_baseUrl];
    }
    else{
        baseUrl = DocUrl;
    }
    
    NSURL *url = [NSURL URLWithString:baseUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:1800];
    
    
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)title, NULL, NULL,  kCFStringEncodingUTF8 ));
    
   // NSString * encodedid = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)ywcpID, NULL, NULL,  kCFStringEncodingUTF8 ));
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"processattachment" forHTTPHeaderField:@"requestKey"];
    [request setValue:caseID forHTTPHeaderField:@"caseID"];
    [request setValue:encodedString forHTTPHeaderField:@"filename"];
    [request setValue:ywcpID forHTTPHeaderField:@"ywcpID"];
    [request setValue:[NSString stringWithFormat:@"%f",size] forHTTPHeaderField:@"filelength"];
    [request setValue:type forHTTPHeaderField:@"filetype"];
    [request setValue:category forHTTPHeaderField:@"filecategory"];
    [request setHTTPBody:fileData];
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [con start];
    
    if ([_delegate respondsToSelector:@selector(startUpload)]) {
        [_delegate startUpload];
    }

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_responseData appendData:data];
 }

- (void)connection:(NSURLConnection *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    if ([_delegate respondsToSelector:@selector(startUploadProcess:)]) {
        float start = (float)totalBytesWritten;

        float all = (float)totalBytesExpectedToWrite;
        
        
        float progress = (start/all)*100;
        [_delegate startUploadProcess:progress];
    }

}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSDictionary *testDict = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:nil];
    
    NSString *hint = [testDict objectForKey:@"docFolder"];
    if ([[testDict objectForKey:@"mgid"] isEqualToString:@"True"] || [[testDict objectForKey:@"mgid"] isEqualToString:@"true"]) {
        if ([_delegate respondsToSelector:@selector(uploadClientdidSccuess:hint:)]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AvatorUpdate" object:nil];
            
            if ([[testDict objectForKey:@"fileID"] length] > 0) {
                NSString *fileID = [testDict objectForKey:@"fileID"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"filelist" object:fileID];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"file_list_process" object:fileID];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"file_list_coo" object:fileID];
            }
            
            
            [_delegate uploadClientdidSccuess:self hint:hint];
            
        }
    }
    else{
        if ([_delegate respondsToSelector:@selector(uploadClientdidError:)]) {
            [_delegate uploadClientdidError:self];
        }
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if ([_delegate respondsToSelector:@selector(uploadClientdidError:)]) {
        [_delegate uploadClientdidError:self];
    }
}


@end
