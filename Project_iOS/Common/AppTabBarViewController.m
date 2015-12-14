//
//  AppTabBarViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/14.
//  Copyright (c) 2015年 刘旭. All rights reserved.
//

#define kSelectColor RGBCOLOR(45, 215, 177)
#define kDeselectColor [UIColor colorWithWhite:0.5 alpha:1.000]

#import "AppTabBarViewController.h"

@interface AppTabbarItem()
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIImage *customImage;
@property (nonatomic, strong) UIImage *customSelectedImage;
@end

@implementation AppTabbarItem

- (void)setImage:(UIImage *)image {
    [super setImage:[UIImage imageWithColor:[UIColor clearColor] size:image.size]];
    self.customImage = image;
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    [super setSelectedImage:[UIImage imageWithColor:[UIColor clearColor] size:selectedImage.size]];
    self.customSelectedImage = selectedImage;
}

@end

@interface AppTabBarViewController ()

@property (nonatomic, strong) NSMutableArray *iconsView; ///ImageViews
@property (nonatomic, strong) UILabel * unreadLabel;
@property (nonatomic, strong) UILabel * serviceLabel;

@end

@implementation AppTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, -2, 18, 18)];
    _unreadLabel.backgroundColor = [UIColor redColor];
    _unreadLabel.textColor = [UIColor whiteColor];
    
    _unreadLabel.textAlignment = NSTextAlignmentCenter;
    _unreadLabel.font = [UIFont lantingFontOfSize:11];
    _unreadLabel.layer.cornerRadius = 9;
    _unreadLabel.clipsToBounds = YES;
    _unreadLabel.hidden = YES;
    
    _serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, -2, 18, 18)];
    _serviceLabel.backgroundColor = [UIColor redColor];
    _serviceLabel.textColor = [UIColor whiteColor];
    
    _serviceLabel.textAlignment = NSTextAlignmentCenter;
    _serviceLabel.font = [UIFont lantingFontOfSize:11];
    _serviceLabel.layer.cornerRadius = 9;
    _serviceLabel.clipsToBounds = YES;
    _serviceLabel.hidden = YES;
    
    _serviceLabelInner = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 15, 18, 18)];
    _serviceLabelInner.backgroundColor = [UIColor redColor];
    _serviceLabelInner.textColor = [UIColor whiteColor];
    
    _serviceLabelInner.textAlignment = NSTextAlignmentCenter;
    _serviceLabelInner.font = [UIFont lantingFontOfSize:11];
    _serviceLabelInner.layer.cornerRadius = 9;
    _serviceLabelInner.clipsToBounds = YES;
    _serviceLabelInner.hidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Custom Items

/*
 需要Tabbar上的动画效果。。
 这里重新创建了Item视图盖在了Tabbar上，并将原有Tabbar图片设为透明
 实现得比较hack..
 */

- (void)initCustomItems {
    if (!self.iconsView) {
        self.iconsView = @[].mutableCopy;
        NSUInteger count = self.tabBar.items.count;
        for (NSUInteger i = 0; i < count; i++) {
            AppTabbarItem *item = (id)self.tabBar.items[i];
            
            UIView *container = [UIView new];
            container.userInteractionEnabled = NO;
            container.tag = i;
            [self.tabBar addSubview:container];
            container.frame = CGRectMake(self.tabBar.width / count * i, 0, self.tabBar.width / count - 1, self.tabBar.height);
            
            UIImageView *icon = [[UIImageView alloc] initWithImage:item.customImage];
            icon.tintColor = [UIColor clearColor];
            icon.top = 7;
            icon.centerX = container.width / 2;
            [container addSubview:icon];
            
            if (i == 1) {
                [icon addSubview:_unreadLabel];
            }else if (i == 2){
                [icon addSubview:_serviceLabel];
            }
            
            [self.iconsView addObject:icon];
            
            if (i == 0) { // selected first element
                item.isSelected = YES;
                icon.image = item.customSelectedImage;
            }
            item.tag = i;
        }
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    UITabBarItem *item = self.tabBar.items[selectedIndex];
    [self tabBar:self.tabBar didSelectItem:item];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    AppTabbarItem *curItem = (id)item;
    AppTabbarItem *preItem = nil;
    for (NSUInteger i = 0; i < self.tabBar.items.count; i++) {
        AppTabbarItem *item = self.tabBar.items[i];
        if (item.isSelected) {
            preItem = item;
            break;
        }
    }
    if (curItem == preItem) return;
    UIImageView *icon = (id)self.iconsView[curItem.tag];
    {
        UIViewAnimationOptions op = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut;
        NSTimeInterval one = 0.18;
        [UIView animateWithDuration:one delay:0 options:op animations:^{
            icon.transform = CGAffineTransformMakeScale(1.3, 1.3);
            icon.image = curItem.customSelectedImage;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:one delay:0 options:op animations:^{
                icon.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:one delay:0 options:op animations:^{
                    icon.transform = CGAffineTransformMakeScale(1.13, 1.13);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:one delay:0 options:op animations:^{
                        icon.transform = CGAffineTransformMakeScale(1.1, 1.1);
                    } completion:NULL];
                }];
            }];
        }];
    }
    
    UIImageView *preIcon = (id)self.iconsView[preItem.tag];
    {
        UIViewAnimationOptions op = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut;
        NSTimeInterval one = 0.18;
        [UIView animateWithDuration:one * 2 delay:0 options:op animations:^{
            preIcon.transform = CGAffineTransformIdentity;
            preIcon.image = preItem.customImage;
        } completion:NULL];
    }
    
    curItem.isSelected = YES;
    preItem.isSelected = NO;
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
