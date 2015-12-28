//
//  BaseRequset.h
//  Project_iOS
//
//  Created by 刘旭 on 15/12/15.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "extError.h"

typedef void(^RSRequstComplete)(NSInteger errorNum, NSDictionary *info, extError *errorMsg);

@interface BaseRequset : NSObject

- (void)sendRequestWithMethod:(NSString *)method
                      WithUrl:(NSString *)url
             WithRequestParam:(NSDictionary *)requestParam
                 WithComplete:(RSRequstComplete)complete;


@end
