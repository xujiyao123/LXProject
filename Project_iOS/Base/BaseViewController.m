//
//  BaseViewController.m
//  MeiDu_iOS
//
//  Created by 刘旭 on 15/12/1.
//  Copyright (c) 2015年 刘旭. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeTop;
    }
    [[PKResManager getInstance] addChangeStyleObject:self];
    [self.view setBackgroundColor:kAppBgCommonColor];
    [[UINavigationBar appearance]setShadowImage:[UIImage imageWithColor:kAppCommonColor size:CGSizeMake(SCREEN_WIDTH, 0.5)]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = self.view.backgroundColor;
    
    NSInteger x = [self.navigationController.viewControllers count];
    if (x > 1 && !self.navigationItem.leftBarButtonItem) {
        UIImage         *normalImage = [UIImage imageForKey:@"nav_back_normal"];
        UIImage         *hightlightImage = [UIImage imageForKey:@"nav_back_pressed"];
        [self addNavigationBackButtonItem:normalImage hightlightImage:hightlightImage];
    }
}

- (void)addNavigationBackButtonItem:(UIImage *)normalImage hightlightImage:(UIImage *)hightlightImage {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 50, 44)];
    [btn.titleLabel setFont:[UIFont lantingFontOfSize:15]];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:kAppTextColor forState:UIControlStateNormal];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:hightlightImage forState:UIControlStateHighlighted];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = buttonItem;
}

#pragma mark NavigationColor
- (void)setNavigationBarColor:(UIColor *)navigationBarColor {
    _navigationBarColor = navigationBarColor;
    UIImage *colorImage = [UIImage imageWithColor:_navigationBarColor];
    [self.navigationController.navigationBar setNavigationBarWithImage:colorImage];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[PKResManager getInstance] removeChangeStyleObject:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
