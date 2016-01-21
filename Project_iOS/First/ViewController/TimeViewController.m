//
//  TimeViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 16/1/21.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "TimeViewController.h"
#import "TRSDialScrollView.h"

@interface TimeViewController ()<UIScrollViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    CGFloat _year;
    NSInteger _month;
    NSInteger _day;
}
@property (nonatomic, strong) TRSDialScrollView *dialView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) NSArray *monthArray;
@property (nonatomic, strong) UIPickerView *datePicker;

@end

@implementation TimeViewController

- (id)init {
    if (self = [super init]) {
     
        self.monthArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12"];
        self.dayArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31"];
        _year = 2000;
        _month = 1;
        _day = 1;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dialView = [[TRSDialScrollView alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width - 40, 60)];
    _dialView.delegate = self;
    //每几个
    _dialView.minorTicksPerMajorTick = 5;
    //间距
    _dialView.minorTickDistance = 13;
    [_dialView setDialRangeFrom:1900 to:2016];
    _dialView.currentValue = 2000;
    _dialView.layer.cornerRadius = 30;
    _dialView.layer.masksToBounds = YES;
    [self.view addSubview:_dialView];

    
    [[TRSDialScrollView appearance] setBackgroundColor:[UIColor whiteColor]];
    [[TRSDialScrollView appearance] setOverlayColor:[UIColor clearColor]];
    
    //文字颜色
    [[TRSDialScrollView appearance] setLabelStrokeColor:[UIColor redColor]];
    //文字宽度
    [[TRSDialScrollView appearance] setLabelStrokeWidth:0.1f];
    //文字颜色
    [[TRSDialScrollView appearance] setLabelFillColor:[UIColor greenColor]];
    //文字尺寸
    [[TRSDialScrollView appearance] setLabelFont:[UIFont systemFontOfSize:12]];
    
    //短竖颜色
    [[TRSDialScrollView appearance] setMinorTickColor:[UIColor cyanColor]];
    //短竖长度
    [[TRSDialScrollView appearance] setMinorTickLength:5];
    //短竖宽度
    [[TRSDialScrollView appearance] setMinorTickWidth:1.0];
    
    //长竖颜色
    [[TRSDialScrollView appearance] setMajorTickColor:[UIColor purpleColor]];
    //长竖长度
    [[TRSDialScrollView appearance] setMajorTickLength:15];
    //长竖宽度
    [[TRSDialScrollView appearance] setMajorTickWidth:1];
    //长竖阴影
    [[TRSDialScrollView appearance] setShadowColor:[UIColor clearColor]];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2, 10)];
    lineView.centerX = self.view.centerX;
    lineView.backgroundColor = [UIColor blackColor];
    lineView.top = _dialView.bottom + 20;
    [self.view addSubview:lineView];
  
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView.bottom + 10, SCREEN_WIDTH, 15)];
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont lantingFontOfSize:15];
    self.label.text = @"1994";
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    NSLog(@"Current Value = %li", _dialView.currentValue);
    
    _datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.label.bottom + 10, 300, 200)];
    _datePicker.centerX = self.view.centerX;
    _datePicker.dataSource = self;
    _datePicker.delegate = self;
    _datePicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_datePicker];
}

#pragma mark pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}

#pragma mark pickerView 每列行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 12;
    }
    else if (component == 1 || component == 3) {
        return 1;
    }
    else {
        return _dayArray.count;
    }
}

#pragma mark pickerView 行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

#pragma mark pickerView 每行内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return _monthArray[row];
    }
    else if (component == 1) {
        return @"月";
    }
    else if (component == 2) {
        return _dayArray[row];
    }
    return @"日";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSLog(@"%ld", row);
        _month = [_monthArray[row]integerValue];
        if (_month == 4 || _month == 6 || _month == 9 || _month == 11) {
            self.dayArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30"];
        }
        else if (_month == 2) {
            if ((int)_year % 4) {
                self.dayArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28"];
            }
            else {
                self.dayArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29"];
            }
        }
        else {
            self.dayArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31"];
        }
        [_datePicker reloadComponent:2];
    }
    else if (component == 2) {
        
    }
}

#pragma mark change PikerView Label.text Size
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = [UIFont lantingFontOfSize:14];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}



- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    self.label.text = [NSString stringWithFormat:@"%.0f", 1900 + targetContentOffset->x / 13];

    _year = 1900 + targetContentOffset->x / 13;
    NSLog(@"%d", (int)_year);
    if ((int)_year % 4) {
        if (_month == 2) {
            self.dayArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28"];
        }
        else if (_month == 4 || _month == 6 || _month == 9 || _month == 11) {
            self.dayArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30"];
        }
        else {
            self.dayArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31"];
        }
    }
    else {
        if (_month == 2) {
            self.dayArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29"];
        }
        else if (_month == 4 || _month == 6 || _month == 9 || _month == 11) {
            self.dayArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30"];
        }
        else {
            self.dayArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31"];
        }
    }
//    [_datePicker reloadAllComponents];
    [_datePicker reloadComponent:2];
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (scrollView == _dialView.scrollView) {
//        NSLog(@"🐒%.2f", scrollView.contentOffset.x / 13);
//        self.label.text = [NSString stringWithFormat:@"%.0f", 1900 + scrollView.contentOffset.x / 13];
//    }
//}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == _dialView.scrollView) {
//        NSLog(@"🐒%.2f", scrollView.contentOffset.x / 13);
//        self.label.text = [NSString stringWithFormat:@"%.0f", 1900 + scrollView.contentOffset.x / 13];
//    }
//}

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
