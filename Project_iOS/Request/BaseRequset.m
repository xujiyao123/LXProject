//
//  BaseRequset.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/15.
//  Copyright © 2015年 刘旭. All rights reserved.
//


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
    DebugLog(@"\n请求接口：%@\n请求的参数：%@\n", fullUrl, requestParam);
    if ([method isEqualToString:@"POST"]) {
        [manager POST:fullUrl parameters:requestParam progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]] && responseObject && ([responseObject allKeys].count > 0)) {
                //看是否出错
                NSString *errorNum = [responseObject objectForKey:@"code"];
                //这里只是用当前接口的情况做例子 实际情况需要换成实际的数字
                if ([errorNum isEqualToString:@"R00000"]) {
                    DebugLog(@"\n请求接口：%@\n请求的结果：%@\n", fullUrl, responseObject);
                    complete(kRSBaseRequestSuccess, responseObject, nil);
                }
                else {
                    NSString *errorMsg = [responseObject objectForKey:@"content"];
                    extError *exError = [extError errorWithCode:errorNum.integerValue errorMessage:errorMsg];
                    complete(errorNum.integerValue, nil, exError);
                }
            }
            else {
                // 接口数据为空
                DebugLog(@"\n请求接口：%@\n接口数据为空", fullUrl);
                complete(kRSBaseRequestSuccess, @{}, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DebugLog(@"\n网络错误，请求的错误提示：%@\n", error);
            if (complete != nil) {
                extError *e = [extError errorWithNSError:error];
                complete(kRSBaseRequestConnectError, nil, e);
            }
        }];
    }
    else {
        [manager GET:fullUrl parameters:requestParam progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]] && responseObject && ([responseObject allKeys].count > 0)) {
                //看是否出错
                NSString *errorNum = [responseObject objectForKey:@"code"];
                //这里只是用当前接口的情况做例子 实际情况需要换成实际的数字
                if ([errorNum isEqualToString:@"R00000"]) {
                    DebugLog(@"\n请求接口：%@\n请求的结果：%@\n", fullUrl, responseObject);
                    complete(kRSBaseRequestSuccess, responseObject, nil);
                }
                else {
                    NSString *errorMsg = [responseObject objectForKey:@"content"];
                    extError *exError = [extError errorWithCode:errorNum.integerValue errorMessage:errorMsg];
                    complete(errorNum.integerValue, nil, exError);
                }
            }
            else {
                // 接口数据为空
                DebugLog(@"\n请求接口：%@\n接口数据为空", fullUrl);
                complete(kRSBaseRequestSuccess, @{}, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DebugLog(@"\n网络错误，请求的错误提示：%@\n", error);
            if (complete != nil) {
                extError *exError = [extError errorWithNSError:error];
                complete(kRSBaseRequestConnectError, nil, exError);
            }
        }];
    }
}

@end
