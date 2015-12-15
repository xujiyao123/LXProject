//
//  AppContext.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/15.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "AppContext.h"

static AppContext *_center = nil;

@implementation AppContext

+ (AppContext *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _center = [[AppContext alloc]init];
    });
    return _center;
}



@end
