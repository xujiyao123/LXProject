//
//  DTouchViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/22.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "DTouchViewController.h"
#import "DTouchDetailViewController.h"
#import "DTouchViewCell.h"

@interface DTouchViewController ()<UIViewControllerPreviewingDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - PHONE_CUSTOM_TABBAR_HEIGHT - PHONE_NAVIGATIONBAR_IOS7_HEIGHT)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
    }
    return _tableView;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTouchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DTouchViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    cell.count = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DTouchDetailViewController *vc = [[DTouchDetailViewController alloc]init];
    vc.labelText = [NSString stringWithFormat:@"%ld", indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 3d touch
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    if ([self.presentedViewController isKindOfClass:[DTouchDetailViewController class]]) {
        return nil;
    }
    else {
        DTouchDetailViewController *vc = [[DTouchDetailViewController alloc] init];
        DTouchViewCell *cell = (DTouchViewCell *)[previewingContext sourceView];
        vc.labelText = [NSString stringWithFormat:@"%ld", cell.count];
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
