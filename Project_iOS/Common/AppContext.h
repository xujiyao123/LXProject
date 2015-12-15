//
//  AppContext.h
//  Project_iOS
//
//  Created by 刘旭 on 15/12/15.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#define APPCONTEXT [AppContext shareInstance]

#import <Foundation/Foundation.h>

@interface AppContext : NSObject

+ (AppContext *)shareInstance;

- (void)userLogout;
- (void)userLogin;

@end
