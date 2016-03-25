//
//  SecondViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/14.
//  Copyright (c) 2015年 刘旭. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondDetailViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.backgroundColor = kAppCommonColor;
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(p_buttonAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

- (void)p_buttonAction {
    self.tabBarController.selectedIndex = 0;
    SecondDetailViewController *vc = [[SecondDetailViewController alloc]init];
    AppNavigationController *nav = self.tabBarController.viewControllers[0];
    UIViewController *vc1 = nav.viewControllers[0];
    [vc1.navigationController pushViewController:vc animated:YES];
    [self.navigationController pushViewController:vc animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self removeFromParentViewController];
    });
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
