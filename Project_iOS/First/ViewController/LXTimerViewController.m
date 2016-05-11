//
//  LXTimerViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 16/5/11.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "LXTimerViewController.h"
#import "NSTimer+LXTimer.h"

@interface LXTimerViewController ()

{
    NSTimer *_timer;
}

@end

@implementation LXTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startPolling];
}

- (void)startPolling {
    __weak LXTimerViewController *weakSelf = self;
    _timer = [NSTimer lx_scheduleTimerWithTimeInterval:1 block:^{
        LXTimerViewController *strongSelf = weakSelf;
        NSLog(@"%@", weakSelf);
        [strongSelf p_doSomething];
    } repeats:YES];
}

- (void)stopPolling {
    [_timer invalidate];
    _timer = nil;
}

- (void)p_doSomething {
    NSLog(@"1");
}

- (void)dealloc {
    NSLog(@"dealloc");
    //这句就算忘记写 也不会调用p_doSomething
    [self stopPolling];
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
