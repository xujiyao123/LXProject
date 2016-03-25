//
//  SecondDetailViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 16/3/21.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "SecondDetailViewController.h"
#import "AppTabBarManager.h"

@interface SecondDetailViewController ()

@end

@implementation SecondDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.tabBarController.tabBar.subviews);
//    self.tabBarController.selectedIndex = 0;
//    for (AppTabbarItem *item in self.tabBarController.tabBar.subviews) {
//        if (item.tag) {
//            item.image = [UIImage imageForKey:@"tab_home"];
//        }
//    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
