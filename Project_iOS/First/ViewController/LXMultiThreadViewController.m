//
//  MultiThreadViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/31.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "LXMultiThreadViewController.h"

@interface LXMultiThreadViewController ()

@property(nonatomic, strong) NSArray *array;

@end

@implementation LXMultiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *tmp = self.array;
    self.array = nil;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    dispatch_async(queue, ^{
        [tmp class];
    });


    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //子线程中开始网络请求数据
        //更新数据模型
        dispatch_sync(dispatch_get_main_queue(), ^{
            //在主线程中更新UI代码
            
        });
        
    });
    
    //串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("dispatch.writedb", DISPATCH_QUEUE_SERIAL);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //延时操作
    });
    
}

- (void)writeToDB:(NSData *)data {
    dispatch_queue_t queue1 = dispatch_queue_create("dispatch.writedb", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue1, ^{
        
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
