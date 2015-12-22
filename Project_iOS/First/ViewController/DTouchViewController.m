//
//  DTouchViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/22.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "DTouchViewController.h"
#import "DTouchDetailViewController.h"

@interface DTouchViewController ()<UIViewControllerPreviewingDelegate>

@end

@implementation DTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    centerView.backgroundColor = [UIColor greenColor];
    centerView.center = self.view.center;
    [self.view addSubview:centerView];
    
    [self registerForPreviewingWithDelegate:self sourceView:centerView];
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    if ([self.presentedViewController isKindOfClass:[DTouchDetailViewController class]]) {
        return nil;
    }
    else {
        DTouchDetailViewController *vc = [[DTouchDetailViewController alloc] init];
        return vc;
    }
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
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
