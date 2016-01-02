//
//  DTouchDetailViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/22.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "DTouchDetailViewController.h"

@interface DTouchDetailViewController ()

@end

@implementation DTouchDetailViewController

- (id)init {
    if (self = [super init]) {
        NSLog(@"1");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"2");
    // Do any additional setup after loading the view.
    UILabel *label  = [UILabel new];
    label.text      = self.labelText;
    label.textColor = kAppTextColor;
    label.font      = [UIFont lantingFontOfSize:40];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    __weak DTouchDetailViewController *weakSelf = self;
    
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"赞" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"置顶" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if ([weakSelf.delegate respondsToSelector:@selector(returnResult:)]) {
            [weakSelf.delegate returnResult:weakSelf.count];
        }
    }];
    
//    UIPreviewActionGroup *group = [UIPreviewActionGroup actionGroupWithTitle:@"action Group" style:UIPreviewActionStyleDefault actions:@[action]];
//    NSArray *groupArray = @[group];
    return @[action, action1];
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
