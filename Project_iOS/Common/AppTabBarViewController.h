//
//  AppTabBarViewController.h
//  Project_iOS
//
//  Created by 刘旭 on 15/12/14.
//  Copyright (c) 2015年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppTabBarViewController : UITabBarController

- (void)initCustomItems; ///< 用覆盖默认Tabbar视图，带有动画
@property (nonatomic, strong) UILabel *serviceLabelInner;

@end

/// 自定义TabbarItem
@interface AppTabbarItem : UITabBarItem
@end

