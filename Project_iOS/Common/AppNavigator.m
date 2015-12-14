//
//  AppNavigator.m
//  finder
//
//  Created by jianjie Wu on 4/1/13.
//  Copyright (c) 2013 jianjie Wu. All rights reserved.
//

#import "AppNavigator.h"

#import "AppDelegate.h"
#import "AppNavigationController.h"
#import "AppTabBarManager.h"

@implementation AppNavigator

@synthesize mainNav = _mainNav;

#pragma mark - instance method

+ (instancetype)navigator
{
    static AppNavigator    *navigator = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
            navigator = [[AppNavigator alloc] init];
        });

    return navigator;
}

+ (void)showModalViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UINavigationController *currentNavi = [AppNavigator currentNavigationController];
    [currentNavi presentViewController:viewController animated:animated completion:nil];
}

+ (void)showModalNavigationController:(UIViewController *)viewController animated:(BOOL)animated
{
    AppNavigationController *nav = [[AppNavigationController alloc] initWithRootViewController:viewController];
    [AppNavigator showModalViewController:nav animated:animated];
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UINavigationController *currentNavi = [AppNavigator currentNavigationController];
    if (currentNavi) {
        [currentNavi pushViewController:viewController animated:animated];
    }
}

+ (UINavigationController *)currentNavigationController{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *rootViewController = appDelegate.window.rootViewController;
    UINavigationController *currentNavi = nil;

    UIViewController *tempVC = rootViewController;
    while ([tempVC isKindOfClass:[UINavigationController class]]
           || [tempVC isKindOfClass:[UITabBarController class]]) {
        if ([tempVC isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabVC = (UITabBarController *)tempVC;
            tempVC = tabVC.selectedViewController;
        }

        if ([tempVC isKindOfClass:[UINavigationController class]]) {
            currentNavi = (UINavigationController *)tempVC;
            if (currentNavi.presentedViewController) {
                tempVC = currentNavi.presentedViewController;
            }else{
                tempVC = [currentNavi.viewControllers firstObject];
            }
        }
    }
    return currentNavi;
}

+ (void)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *presentCon = [[AppNavigator navigator].mainNav presentedViewController];

    if (presentCon && [presentCon isKindOfClass:[AppNavigationController class]]) {
        [(AppNavigationController *)presentCon popViewControllerAnimated : animated];
    } else {
        [[AppNavigator navigator].mainNav popViewControllerAnimated:animated];
    }
}

+ (void)popToRootViewControllerAnimated:(BOOL)animated
{
    [[AppNavigator navigator].mainNav dismissViewControllerAnimated:animated completion:nil];
    [[AppNavigator navigator].mainNav popToRootViewControllerAnimated:animated];
    [[AppNavigator navigator].mainNav setNavigationBarHidden:YES animated:animated];
}

+ (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[AppNavigator navigator].mainNav popToViewController:viewController animated:animated];
}

//+ (void)openTestViewController
//{
//    UIViewController *testVC = [[SelectionViewController alloc]init];
//    [AppNavigator openMainNavControllerWithRoot:testVC];
//}

+ (void)openMainViewController
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *tabbar = [[AppTabBarManager shareManager] tabbarViewController];
    AppNavigationController *rootNavi = [[AppNavigationController alloc]initWithRootViewController:tabbar];
    rootNavi.navigationBarHidden = YES;
    appDelegate.window.rootViewController = rootNavi;
    [AppNavigator navigator].mainNav = rootNavi;
}

//+ (void)openLoginViewController
//{
//    INCLoginViewController *viewController = [[INCLoginViewController alloc] init];
//    [AppNavigator openMainNavControllerWithRoot:viewController];
//}

+ (void)openMainNavControllerWithRoot:(UIViewController *)rootViewController
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppNavigationController *nav = [[AppNavigationController alloc] initWithRootViewController:rootViewController];
    appDelegate.window.rootViewController = nav;
    [AppNavigator navigator].mainNav = nav;
}

+ (UIWindow *)getFirstFullScreenWindow
{
    UIWindow *onWindow = nil;
    NSArray  *windows = [UIApplication sharedApplication].windows;

    for (int i = 0; i < windows.count; i++) {
        UIWindow *window = windows[i];

        if (window.size.height == SCREEN_HEIGHT) {
            onWindow = window;
            break;
        }
    }

    return onWindow;
}

+ (void)popFromViewController:(UIViewController *)destinationViewController backToViewController:(UIViewController *)sourceViewController animated:(BOOL)animated
{
    if ([destinationViewController.navigationController.viewControllers containsObject:sourceViewController]) {
        [destinationViewController.navigationController popToViewController:sourceViewController animated:animated];
    } else {
        [destinationViewController.navigationController popToViewController:destinationViewController animated:NO];
        [destinationViewController.navigationController popViewControllerAnimated:animated];
    }
}
@end