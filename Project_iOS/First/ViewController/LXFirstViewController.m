//
//  FirstViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/14.
//  Copyright (c) 2015年 刘旭. All rights reserved.
//

//2016 加油.

#import "LXFirstViewController.h"
#import "FirstViewCell.h"
#import "LXDTouchViewController.h"
#import "GuideView.h"
#import "LXCellAutoLayoutViewController.h"
#import "LXMultiThreadViewController.h"
#import "LXRunloopViewController.h"
#import "LXHTMLViewController.h"

@interface LXFirstViewController ()<UITableViewDataSource, UITableViewDelegate, NSUserActivityDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *dataArray;
@property (nonatomic, strong) GuideView   *guideView;
@property (nonatomic, strong) NSUserActivity *activity;

@end

@implementation LXFirstViewController

- (id)init {
    if (self = [super init]) {
        self.dataArray = @[@"3d touch", @"cell自适应", @"多线程", @"runloop", @"HTML片段"];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.tableView];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"firstOpen"]) {
        [self.tabBarController.view addSubview:self.guideView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DTouchAction) name:@"DTouch" object:nil];

    //测试bool值输出.
    NSLog(@"%@", self.view.userInteractionEnabled ? @"YES" : @"NO");
    _activity = [[NSUserActivity alloc]initWithActivityType:@"name"];
//    _activity = [[NSUserActivity alloc]init];
    _activity.keywords = [NSSet setWithArray:@[@"xugege"]];
    _activity.title = @"touch";
    _activity.eligibleForHandoff = YES;
    _activity.eligibleForSearch = YES;
    [_activity becomeCurrent];
    [_activity invalidate];
}

- (void)userActivityWasContinued:(NSUserActivity *)userActivity {
    
}

- (void)restoreUserActivityState:(NSUserActivity *)activity {
    if ([activity.title isEqualToString:@"touch"]) {
        LXDTouchViewController *vc = [[LXDTouchViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)DTouchAction {
    LXDTouchViewController *vc = [[LXDTouchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (GuideView *)guideView {
    if (!_guideView) {
        _guideView = [[GuideView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _guideView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView            = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataArray.count) {
        return _dataArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataArray.count) {
        return 50;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[FirstViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.detailTextLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc]init];
    switch (indexPath.row) {
        case 0:
            vc = [[LXDTouchViewController alloc]init];
            break;
        case 1:
            vc = [[LXCellAutoLayoutViewController alloc]init];
            break;
        case 2:
            vc = [[LXMultiThreadViewController alloc]init];
            break;
        case 3:
            vc = [[LXRunloopViewController alloc]init];
            break;
        case 4:
            vc = [[LXHTMLViewController alloc]init];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
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
