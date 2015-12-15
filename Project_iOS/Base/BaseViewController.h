//
//  BaseViewController.h
//  MeiDu_iOS
//
//  Created by 刘旭 on 15/12/1.
//  Copyright © 2015年 YTX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIColor *navigationBarColor;

- (void)goBack;

- (void)addNavigationBackButtonItem:(UIImage *)normalImage hightlightImage:(UIImage *)hightlightImage;


@end
