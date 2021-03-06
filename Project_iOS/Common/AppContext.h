//
//  AppContext.h
//  Project_iOS
//
//  Created by 刘旭 on 15/12/15.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#define APPCONTEXT [AppContext shareInstance]

#import <Foundation/Foundation.h>
#import "AppUser.h"
#import "AppConfig.h"
#import "FirstRequset.h"

@interface AppContext : NSObject

@property (nonatomic, strong) AppUser *currentUser;
@property (nonatomic, strong) AppConfig *config;
@property (nonatomic, strong) FirstRequset *firstRequset;
+ (AppContext *)shareInstance;

- (void)userLogout;
- (void)userLogin;

@end
