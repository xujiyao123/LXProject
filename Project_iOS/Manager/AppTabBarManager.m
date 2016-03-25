//
//  AppTabBarManager.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/14.
//  Copyright (c) 2015年 刘旭. All rights reserved.
//

#import "AppTabBarManager.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@implementation AppTabBarManager

+ (AppTabBarManager *)shareManager{
    static AppTabBarManager *shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[AppTabBarManager alloc]init];
    });
    return shareManager;
}

- (AppTabBarViewController *)tabbarViewController{
    if (!_tabbarViewController) {
        _tabbarViewController = [[AppTabBarViewController alloc]init];
        _tabbarViewController.tabBar.selectedImageTintColor = RGBCOLOR(45, 215, 177);
        [_tabbarViewController.tabBar setShadowImage:[UIImage imageWithColor:kAppCommonColor size:CGSizeMake(SCREEN_WIDTH, 0.5)]];
        [_tabbarViewController.tabBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf5f5f5)]];
        _tabbarViewController.tabBar.selectionIndicatorImage = [UIImage imageWithColor:UIColorFromRGB(0xffffff) size:CGSizeMake(SCREEN_WIDTH / 3, PHONE_CUSTOM_TABBAR_HEIGHT)];
        
        NSMutableArray *items = @[].mutableCopy;
        AppTabbarItem *item = nil;
        
        NSMutableArray *viewControllers = [NSMutableArray array];
        FirstViewController *first = [[FirstViewController alloc]init];
        item = [AppTabbarItem new];
        [items addObject:item];
        item.image = [[UIImage imageForKey:@"tab_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [UIImage imageForKey:@"tab_home"];
        item.tag = 1;
        first.title = item.title = @"one";
        AppNavigationController *homeNavi = [[AppNavigationController alloc]initWithRootViewController:first];
        homeNavi.tabBarItem = item;
        [homeNavi.view setBackgroundColor:[UIColor whiteColor]];
        [viewControllers addObject:homeNavi];
        
        SecondViewController *second = [[SecondViewController alloc]init];
        item = [AppTabbarItem new];
        [items addObject:item];
        item.image = [[UIImage imageForKey:@"tab_order_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [UIImage imageForKey:@"tab_order"];
        second.title = item.title = @"two";
        AppNavigationController *orderNavi = [[AppNavigationController alloc]initWithRootViewController:second];
        orderNavi.tabBarItem = item;
        [viewControllers addObject:orderNavi];
        
        ThirdViewController *third = [[ThirdViewController alloc]init];
        item = [AppTabbarItem new];
        [items addObject:item];
        item.image = [[UIImage imageForKey:@"tab_user_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [UIImage imageForKey:@"tab_user"];
        third.title = item.title = @"three";
        AppNavigationController *meNavi = [[AppNavigationController alloc]initWithRootViewController:third];
        meNavi.tabBarItem = item;
        [viewControllers addObject:meNavi];
        
        
        _tabbarViewController.viewControllers = viewControllers;
        [_tabbarViewController initCustomItems];
    }
    return _tabbarViewController;
}

@end
