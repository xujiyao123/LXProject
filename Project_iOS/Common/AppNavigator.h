//
//  AppNavigator.h
//  finder
//
//  Created by jianjie Wu on 4/1/13.
//  Copyright (c) 2013 jianjie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSChatMucDialogueViewController;

@interface AppNavigator : NSObject
@property (nonatomic, strong) UINavigationController *mainNav;

+ (instancetype)navigator;

+ (void)showModalViewController:(UIViewController *)viewController animated:(BOOL)animated;
+ (void)showModalNavigationController:(UIViewController *)viewController animated:(BOOL)animated;

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
//+ (void)pushNavigationViewController:(UIViewController *)viewController animated:(BOOL)animated;


+ (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
+ (void)popViewControllerAnimated:(BOOL)animated;
+ (void)popToRootViewControllerAnimated:(BOOL)animated;

+ (void)openTestViewController;
+ (void)openMainViewController;
+ (void)openLoginViewController;

+ (UIWindow *)getFirstFullScreenWindow;
+ (void)popFromViewController:(UIViewController *)destinationViewController backToViewController:(UIViewController *)sourceViewController animated:(BOOL)animated;

@end