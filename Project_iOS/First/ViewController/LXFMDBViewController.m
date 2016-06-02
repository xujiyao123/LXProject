//
//  LXFMDBViewController.m
//  Project_iOS
//
//  Created by 美时美刻－01 on 16/6/1.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "LXFMDBViewController.h"
#import <FMDB/FMDB.h>
#import "FMDBModel.h"

@interface LXFMDBViewController ()

@property (nonatomic, strong) FMDatabase *database;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *sexTextField;
@property (nonatomic, strong) UITextField *ageTextField;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation LXFMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *buttonArray = @[@"增", @"删", @"改", @"查"];
    [buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / buttonArray.count * idx, 0, SCREEN_WIDTH / buttonArray.count, 50)];
        [button setTitle:buttonArray[idx] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
    }];
    
    
    _nameTextField = [self createTextFieldWithPlaceholder:@"姓名"];
    [self.view addSubview:_nameTextField];
    _sexTextField = [self createTextFieldWithPlaceholder:@"性别"];
    _sexTextField.top = _nameTextField.bottom + 10;
    [self.view addSubview:_sexTextField];
    _ageTextField = [self createTextFieldWithPlaceholder:@"年龄"];
    _ageTextField.top = _sexTextField.bottom + 10;
    [self.view addSubview:_ageTextField];
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [path stringByAppendingPathComponent:@"testDB.db"];
    _database = [FMDatabase databaseWithPath:dbPath];
    if (![_database open]) {
        NSLog(@"数据库打开失败");
    } else {
        NSLog(@"数据库打开成功");
        FMResultSet *result = [_database executeQuery:[NSString stringWithFormat:@"select * from people"]];
        NSLog(@"%@", result);
        _dataArray = [NSMutableArray array];
        //将表里所有列全都取出来放到数组里
        while (result.next) {
            FMDBModel *model = [[FMDBModel alloc]init];
            model.name = [result stringForColumn:@"name"];
            model.sex = [result stringForColumn:@"sex"];
            model.age = [result stringForColumn:@"age"];
            [_dataArray addObject:model];
        }
        NSLog(@"%@", _dataArray);
    }
    if ([_database executeQuery:@"select * from people"]) {
        NSLog(@"people表已存在");
    } else {
        if (![_database executeUpdate:@"create table if not exists people (id integer primary key autoincrement, name text, sex text, age text);"]) {
            NSLog(@"创建表失败");
        } else {
            NSLog(@"创建表成功");
        }
    }
    
}

- (void)buttonAction:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"增"]) {
        [self insertDatabase];
    } else if ([button.titleLabel.text isEqualToString:@"删"]) {
        [self deleteDatabase];
    } else if ([button.titleLabel.text isEqualToString:@"改"]) {
        [self updateDatabase];
    } else {
        [self selectDatabase];
    }
}

- (void)insertDatabase {
    if ([_database executeUpdate:[NSString stringWithFormat:@"insert into people (name, sex, age) values (\"%@\", \"%@\", \"%@\")", _nameTextField.text, _sexTextField.text, _ageTextField.text]]) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
    
}

- (void)deleteDatabase {
    if ([_database executeUpdate:[NSString stringWithFormat:@"delete from people where name = \"%@\"", _nameTextField.text]]) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}

- (void)updateDatabase {
    if ([_database executeUpdate:[NSString stringWithFormat:@"update people set name = \"%@\", sex = \"%@\", age = \"%@\" where name = \"%@\"", _nameTextField.text, _sexTextField.text, _ageTextField.text, _nameTextField.text]]) {
        NSLog(@"更新成功");
    } else {
        NSLog(@"更新失败");
    }
}

- (void)selectDatabase {
    FMResultSet *result = [_database executeQuery:[NSString stringWithFormat:@"select * from people where name = \"%@\"", _nameTextField.text]];
    while (result.next) {
        _nameTextField.text = [result stringForColumn:@"name"];
        _sexTextField.text = [result stringForColumn:@"sex"];
        _ageTextField.text = [result stringForColumn:@"age"];
    }
}

- (UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 200, 30)];
    textField.placeholder = placeholder;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor blackColor];
    return textField;
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
