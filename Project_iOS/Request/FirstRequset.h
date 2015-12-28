//
//  FirstRequset.h
//  Project_iOS
//
//  Created by 刘旭 on 15/12/28.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "BaseRequset.h"

@interface FirstRequset : BaseRequset

- (void)testWithWithUrl:(NSString *)url
             WithMethod:(NSString *)method
           WithComplete:(RSRequstComplete)complete;

- (void)registeWithNearShops:(NSString *)longti
                        lati:(NSString *)lati
                        page:(NSInteger)page
                   pageCount:(NSInteger)pageCount
                        days:(NSInteger)days
                    mealType:(NSInteger)mealType
                     success:(RSRequstComplete)success;

@end
