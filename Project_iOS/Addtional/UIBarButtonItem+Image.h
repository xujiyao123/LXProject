//
//  UIBarButtonItem+Image.h
//  RenrenSixin
//
//  Created by 钟 声 on 11-12-28.
//  Copyright (c) 2011年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIBarButtonItem (CustomImage)
// 私信1.0用
+ (UIBarButtonItem *)rsBarButtonItemWithTitle:(NSString *)title
                                       target:(id)target
                                       action:(SEL)selector;
// 可扩展
+ (UIBarButtonItem *)rsBarButtonItemWithTitle:(NSString *)title 
                                        image:(UIImage *)image
                             heightLightImage:(UIImage *)hlImage
                                 disableImage:(UIImage *)disImage
                                       target:(id)target
                                       action:(SEL)selector;

+ (UIBarButtonItem *)rsBarButtonItemWithBellButton:(UIButton *)bellButton
                                        image:(UIImage *)image
                             heightLightImage:(UIImage *)hlImage
                                 disableImage:(UIImage *)disImage
                                       target:(id)target
                                       action:(SEL)selector;

+ (UIButton*)rsCustomBarButtonWithTitle:(NSString*)title
                                  image:(UIImage *)image
                       heightLightImage:(UIImage *)hlImage
                           disableImage:(UIImage *)disImage
                                 target:(id)target
                                 action:(SEL)selector;

- (void)setButtonAttribute:(NSDictionary*)dic;

@end
