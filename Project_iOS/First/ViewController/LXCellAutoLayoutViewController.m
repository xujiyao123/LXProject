//
//  CellAutoLayoutViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/30.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "LXCellAutoLayoutViewController.h"
#import "CellAutoLayoutCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "AutoLayoutModel.h"

@interface LXCellAutoLayoutViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LXCellAutoLayoutViewController

- (id)init {
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView {
    [super loadView];
    
    NSArray *textArray = @[@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试",
                           @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试",
                           @"测试测试测试",
                           @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试",
                           @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试"
                           ];
    
    NSArray *namesArray = @[@"1",
                            @"31231231231",
                            @"当31312321312312312",
                            @"31231313213131231",
                            @"312312312312312313123121231231"];
    for (int i = 0; i < namesArray.count; i++) {
        int iconRandomIndex    = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);

        AutoLayoutModel *model = [[AutoLayoutModel alloc]init];
        model.title            = namesArray[iconRandomIndex];
        model.content          = textArray[contentRandomIndex];
        [self.dataArray addObject:model];
    }
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - PHONE_NAVIGATIONBAR_IOS7_HEIGHT)];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.tableView startAutoCellHeightWithCellClass:[CellAutoLayoutCell class] contentViewWidth:SCREEN_WIDTH];
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableView cellHeightForIndexPath:indexPath model:self.dataArray[indexPath.row] keyPath:@"model"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CellAutoLayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellAutoLayoutCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
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
