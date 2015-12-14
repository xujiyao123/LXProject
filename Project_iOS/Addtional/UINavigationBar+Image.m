//
//  UINavigationBar+Image.m
//  RenrenSixin
//
//  Created by 黎 伟 on 11/14/11.
//  Copyright (c) 2011 renren. All rights reserved.
//

#import "UINavigationBar+Image.h"
#import "UIDevice+Addtional.h"

@implementation UINavigationBar (Image)


// 设置导航条背景图片 navigation_bar_bg.png
- (void)setNavigationBarWithImageKey:(NSString *)imageKey{
    UIImage *image = [UIImage imageForKey:imageKey];
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavigationBarWithImage:(UIImage *)image{
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}


- (void)clearNavigationBarImage{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}


@end


@implementation UIToolbar(UIToolbar_Image)

// 设置导航条背景图片 navigation_bar_bg.png
- (void)setToolBarWithImageKey:(NSString *)imageKey{
    UIImage *image = [UIImage imageForKey:imageKey];
    [self setBackgroundImage:image forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
}

- (void)setToolBarWithImage:(UIImage *)image
{
    [self setBackgroundImage:image forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
}

- (void)clearToolBarImage{
    [self setBackgroundImage:nil forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
}
@end
