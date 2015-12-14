//
//  UINavigationBar+Image.h
//  RenrenSixin
//
//  Created by 黎 伟 on 11/14/11.
//  Copyright (c) 2011 renren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Image)

// 设置导航条背景图片
- (void)setNavigationBarWithImageKey:(NSString *)imageKey;

- (void)setNavigationBarWithImage:(UIImage *)image;

// 清空导航条的背景图片，使恢复到系统默认状态
- (void)clearNavigationBarImage;
@end

@interface UIToolbar(UIToolbar_Image)

// 设置底边条背景图片
- (void)setToolBarWithImageKey:(NSString *)imageKey;

- (void)setToolBarWithImage:(UIImage *)image;
// 清空底边条的背景图片，使恢复到系统默认状态
- (void)clearToolBarImage;


@end
