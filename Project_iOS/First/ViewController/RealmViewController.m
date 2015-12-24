//
//  RealmViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/24.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "RealmViewController.h"
#import "Person.h"
#import "Dog.h"

@interface RealmViewController ()

@end

@implementation RealmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Person *tom = [[Person alloc]init];
    Dog *jack   = [[Dog alloc]init];
    jack.owner  = tom;
    
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
