//
//  AppContext.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/15.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "AppContext.h"
int ddLogLevel = LOG_LEVEL_INFO;

static AppContext *_center = nil;

@implementation AppContext

+ (AppContext *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _center = [[AppContext alloc]init];
    });
    return _center;
}

- (FirstRequset *)firstRequset {
    if (!_firstRequset) {
        _firstRequset = [[FirstRequset alloc]init];
    }
    return _firstRequset;
}

- (AppUser *)currentUser {
    if (!_currentUser) {
        _currentUser = [[AppUser alloc]init];
    }
    return _currentUser;
}

- (AppConfig *)config {
    if (!_config) {
        _config = [[AppConfig alloc]init];
    }
    return _config;
}

- (void)userLogout {
    
}

- (void)userLogin {
    
}

@end
