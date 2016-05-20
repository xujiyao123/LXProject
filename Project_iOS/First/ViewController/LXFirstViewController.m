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
#import "LXTimerViewController.h"
#import "LXCircleImageView.h"

@interface LXFirstViewController ()<UITableViewDataSource, UITableViewDelegate, NSUserActivityDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *dataArray;
@property (nonatomic, strong) GuideView   *guideView;
@property (nonatomic, strong) NSUserActivity *activity;
@property (nonatomic, strong) LXCircleImageView *imageView;

@end

@implementation LXFirstViewController

- (id)init {
    if (self = [super init]) {
        self.dataArray = @[@"3d touch", @"cell自适应", @"多线程", @"runloop", @"HTML片段", @"NSTimer保留环"];
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
    
    _imageView = [[LXCircleImageView alloc]initWithImage:[UIImage imageForKey:@"guideImg2"]];
    _imageView.frame = CGRectMake(0, 0, 50, 50);
    _imageView.backgroundColor = [UIColor redColor];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, _imageView.image.size.width , _imageView.image.size.height)];
    _imageView.image = [self imageCutter:_imageView.image bezierPath:path];
    
    [self.view addSubview:_imageView];
    [UIView animateWithDuration:5 animations:^{
        _imageView.frame = CGRectMake(SCREEN_WIDTH - 100, 0, 150, 150);
        [_imageView drawImage];
//        _imageView.layer.cornerRadius = _imageView.height / 2;
    }];
}

- (UIImage *)imageCutter:(UIImage *)sourceImage
              bezierPath:(UIBezierPath *)path
{
    
    //1.开启上下文
    
    UIGraphicsBeginImageContextWithOptions(sourceImage.size, NO, 0);
    //2.获取裁剪区域
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height)];
    
    //将路径设置为裁剪区域
    [path addClip];
    
    //3.绘制图片
    [sourceImage drawAtPoint:CGPointZero];
    
    //4.生成图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
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
        case 5:
            vc = [[LXTimerViewController alloc]init];
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
