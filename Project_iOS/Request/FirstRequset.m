//
//  FirstRequset.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/28.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "FirstRequset.h"

@implementation FirstRequset

- (void)testWithWithUrl:(NSString *)url
             WithMethod:(NSString *)method
           WithComplete:(RSRequstComplete)complete {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self sendRequestWithMethod:method WithUrl:url WithRequestParam:dic WithComplete:complete];
}


- (void)registeWithNearShops:(NSString *)longti
                        lati:(NSString *)lati
                        page:(NSInteger)page
                   pageCount:(NSInteger)pageCount
                        days:(NSInteger)days
                    mealType:(NSInteger)mealType
                     success:(RSRequstComplete)success {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"long"] = longti;
    params[@"lat"] = lati;
    params[@"p"] = @(page);
    params[@"c"] = @(pageCount);
    params[@"days"] = @(days);
    params[@"meal_type"] = @(mealType);
    [self sendRequestWithMethod:@"GET" WithUrl:@"biz/nearby_shops_v2_0" WithRequestParam:params WithComplete:success];
}
@end
