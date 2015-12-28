//
//  BaseRequset.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/15.
//  Copyright © 2015年 刘旭. All rights reserved.
//

int ddLogLevel = LOG_LEVEL_INFO;

#define kRSBaseRequestServerReturnError (-2)
#define kRSBaseRequestConnectError      (-1)
#define kRSBaseRequestSuccess           (0)

#import "BaseRequset.h"

@implementation BaseRequset

- (void)sendRequestWithMethod:(NSString *)method
                      WithUrl:(NSString *)url
             WithRequestParam:(NSDictionary *)requestParam
                 WithComplete:(RSRequstComplete)complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html", nil];
    manager.requestSerializer.timeoutInterval = 20;
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@", BaseUrl, url];
    DDLogInfo(@"\n请求接口：%@\n请求的参数：%@\n", fullUrl, requestParam);
    if ([method isEqualToString:@"POST"]) {
        [manager POST:fullUrl parameters:requestParam progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                complete(kRSBaseRequestSuccess, responseObject, nil);
            }
            else {
                return ;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DDLogInfo(@"\n网络错误，请求的错误提示：%@\n", error);
            if (complete != nil) {
                extError *e = [extError errorWithNSError:error];
                complete(kRSBaseRequestConnectError, nil, e);
            }
        }];
    }
    else {
        [manager GET:fullUrl parameters:requestParam progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                complete(kRSBaseRequestSuccess, responseObject, nil);
            }
            else {
                return ;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DDLogInfo(@"\n网络错误，请求的错误提示：%@\n", error);
            if (complete != nil) {
                extError *e = [extError errorWithNSError:error];
                complete(kRSBaseRequestConnectError, nil, e);
            }
        }];
    }
}

@end
