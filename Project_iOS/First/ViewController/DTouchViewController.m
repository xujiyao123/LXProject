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

@interface DTouchViewController ()<UIViewControllerPreviewingDelegate, UITableViewDataSource, UITableViewDelegate, DTouchDetailViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DTouchViewController

- (id)init {
    if (self = [super init]) {
        _dataArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    }
    return self;
}

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
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTouchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DTouchViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    cell.label.text = _dataArray[indexPath.row];
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
        vc.delegate = self;
        vc.preferredContentSize = CGSizeMake(0, 500);
//        previewingContext.sourceRect = previewingContext.sourceView.frame;
        DTouchViewCell *cell = (DTouchViewCell *)[previewingContext sourceView];
        vc.labelText = cell.label.text;
        vc.count = cell.count;
        return vc;
    }
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}

- (void)returnResult:(NSInteger)count {
    [self.dataArray insertObject:_dataArray[count] atIndex:0];
    [self.dataArray removeObjectAtIndex:count + 1];
    [self.tableView reloadData];
    
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
