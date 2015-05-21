//
//  HttpClient.m
//  Lawyer_ipad
//
//  Created by 邬 明 on 14-12-12.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "HttpClient.h"

#import "CommomClient.h"

@interface HttpClient (){
    
    NSString *_baseUrl;
    
    NSMutableURLRequest *_request;
    AFHTTPRequestOperationManager *_manager;
}

@end

@implementation HttpClient

@synthesize delegate = _delegate;

@synthesize operation = _operation;

- (id)init{
    self = [super init];
    if (self)  {
       
       
    }
    return self;
}

- (void)startRequestAtCommom:(NSDictionary*)parameters{
    _manager = [AFHTTPRequestOperationManager manager];
    
    _baseUrl = [[CommomClient sharedInstance] getValueFromUserInfo:@"userUrl"];
    NSString *c = [NSString stringWithFormat:@"%c",[_baseUrl characterAtIndex:_baseUrl.length-1]];
    if (![c isEqualToString:@"/"]) {
        _baseUrl = [_baseUrl stringByAppendingFormat:@"/"];
    }
    
    NSString *baseUrl = _baseUrl;
    if (_baseUrl.length > 0) {
        baseUrl = [NSString stringWithFormat:@"%@/Common/generalcode.ashx",baseUrl];
    }
    else{
        baseUrl = HOSTCOMMOMURL;
    }
    
    if (_isChange) {
        baseUrl = HOSTCOMMOMURL;
    }
    
    NSError *requestError;
    _request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:baseUrl parameters:parameters error:&requestError];
    
    if (!requestError) {
        AFHTTPRequestOperation *operation = [_manager HTTPRequestOperationWithRequest:_request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([_delegate respondsToSelector:@selector(request:didCompleted:)]) {
                [_delegate request:self didCompleted:responseObject];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
                [_delegate requestFailed:self];
            }
        }];
        
        [operation start];
        if ([_delegate respondsToSelector:@selector(requestStarted:)]) {
            [_delegate requestStarted:self];
        }
    }
    else{
        if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
            [_delegate requestFailed:self];
        }
    }

}

- (void)startRequest:(NSDictionary*)parameters{
    _manager = [AFHTTPRequestOperationManager manager];
    
    
    _baseUrl = [[CommomClient sharedInstance] getValueFromUserInfo:@"userUrl"];
    NSString *c = [NSString stringWithFormat:@"%c",[_baseUrl characterAtIndex:_baseUrl.length-1]];
    if (![c isEqualToString:@"/"]) {
        _baseUrl = [_baseUrl stringByAppendingFormat:@"/"];
    }
    
    NSString *baseUrl = _baseUrl;
    if (_baseUrl.length > 0) {
        baseUrl = [NSString stringWithFormat:@"%@mobile/Mobileinterface_new.ashx",baseUrl];
    }
    else{
        baseUrl = HOSTURL;
    }
    
    _isChange = NO;
    if (_isChange) {
        baseUrl = HOSTURL;
    }
    
    NSError *requestError;
    _request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:baseUrl parameters:parameters error:&requestError];
    if (!requestError) {
        _operation = [_manager HTTPRequestOperationWithRequest:_request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([_delegate respondsToSelector:@selector(request:didCompleted:)]) {
                [_delegate request:self didCompleted:responseObject];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
                [_delegate requestFailed:self];
            }
        }];
        
        [_operation start];
        if ([_delegate respondsToSelector:@selector(requestStarted:)]) {
            [_delegate requestStarted:self];
        }
    }
    else{
        if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
            [_delegate requestFailed:self];
        }
    }
}

- (void)startRequestAtPath:(NSDictionary*)parameters path:(NSString*)path{
    _manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",LawURL,path];
    
    NSError *requestError;
    _request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:parameters error:&requestError];
    if (!requestError) {
        AFHTTPRequestOperation *operation = [_manager HTTPRequestOperationWithRequest:_request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([_delegate respondsToSelector:@selector(request:didCompleted:)]) {
                [_delegate request:self didCompleted:responseObject];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
                [_delegate requestFailed:self];
            }
        }];
        
        [operation start];
        if ([_delegate respondsToSelector:@selector(requestStarted:)]) {
            [_delegate requestStarted:self];
        }
    }
    else{
        if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
            [_delegate requestFailed:self];
        }
    }

}

- (void)startBeidaRequest:(NSDictionary*)parameters path:(NSString*)path{
    _manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",Beida,path];
    NSError *requestError;
    _request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:parameters error:&requestError];
    
    if (!requestError) {
        AFHTTPRequestOperation *operation = [_manager HTTPRequestOperationWithRequest:_request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([_delegate respondsToSelector:@selector(request:didCompleted:)]) {
                [_delegate request:self didCompleted:responseObject];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
                [_delegate requestFailed:self];
            }
        }];
        
        [operation start];
        if ([_delegate respondsToSelector:@selector(requestStarted:)]) {
            [_delegate requestStarted:self];
        }
    }
    else{
        if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
            [_delegate requestFailed:self];
        }
    }

}



- (void)cancelRequest{
    [_manager.operationQueue cancelAllOperations];
}

@end
