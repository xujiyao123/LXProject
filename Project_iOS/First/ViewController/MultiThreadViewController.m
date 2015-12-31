//
//  MultiThreadViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/31.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "MultiThreadViewController.h"

@interface MultiThreadViewController ()

@property(nonatomic, strong) NSArray *array;

@end

@implementation MultiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *tmp = self.array;
    self.array = nil;
    dispatch_queue_t queue;
    dispatch_async(queue, ^{
        [tmp class];
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
