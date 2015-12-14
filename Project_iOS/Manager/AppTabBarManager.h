//
//  AppTabBarManager.h
//  Project_iOS
//
//  Created by 刘旭 on 15/12/14.
//  Copyright (c) 2015年 刘旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppTabBarViewController.h"

@interface AppTabBarManager : NSObject

@property (nonatomic, strong) AppTabBarViewController *tabbarViewController;
+ (AppTabBarManager *)shareManager;

@end
