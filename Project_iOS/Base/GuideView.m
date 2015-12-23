//
//  GuideView.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/23.
//  Copyright (c) 2015年 刘旭. All rights reserved.
//

#import "GuideView.h"

@interface GuideView ()

@property(nonatomic, strong) UIImageView *animateImageView;
@property(nonatomic, strong) UIScrollView * scrollView;

@end

@implementation GuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [_scrollView setContentSize:CGSizeMake(kScreenWidth * 3, 0)];
        [_scrollView setPagingEnabled:YES];  //视图整页显示
        [_scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
        
        UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        imageview1.contentMode = UIViewContentModeScaleAspectFill;
        imageview1.layer.masksToBounds = YES;
        [imageview1 setImage:[UIImage imageForKey:@"guideImg1"]];
        [_scrollView addSubview:imageview1];
        
        UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageview2.contentMode = UIViewContentModeScaleAspectFill;
        imageview2.layer.masksToBounds = YES;
        [imageview2 setImage:[UIImage imageForKey:@"guideImg2"]];
        [_scrollView addSubview:imageview2];
        
        self.animateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight)];
        [self.animateImageView setImage:[UIImage imageForKey:@"guideImg3"]];
        self.animateImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.animateImageView.layer.masksToBounds = YES;
        self.animateImageView.userInteractionEnabled = YES;    //打开imageview2的用户交互;否则下面的button无法响应
        [_scrollView addSubview:self.animateImageView];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
        [button setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
        [self.animateImageView addSubview:button];
        
        [self addSubview:_scrollView];
    }
    return self;
}
- (void)firstpressed {
    [[NSUserDefaults standardUserDefaults]setObject:@"true" forKey:@"firstOpen"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //点击button跳转到根视图
    [UIView animateWithDuration:2 animations:^{
        self.animateImageView.frame = CGRectMake(0.75 * self.animateImageView.left, -0.25 * self.animateImageView.height, 2 * self.animateImageView.width, 2 * self.animateImageView.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
