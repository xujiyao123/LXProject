//
//  UIButton+Addictions.m
//  RenrenOfficial-iOS-Concept
//
//  Created by Guichao Huang on 13-12-12.
//  Copyright (c) 2013年 renren. All rights reserved.
//

#import "UIButton+Addictions.h"

@implementation UIButton(SubviewsPosition)

- (void)centerImageAndTitleWithSpacing:(CGFloat)spacing
{
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
}

@end


@implementation UIButton(SetImage)

- (void)setImageWithNameForStateNormal:(NSString *)normal
{
    [self setImageWithNameForStateNormal:normal highlighted:nil selected:nil disabled:nil];
}

- (void)setImageWithNameForStateNormal:(NSString *)normal highlightedAndSelected:(NSString *)highlightedAndSelected disabled:(NSString *)disabled
{
    [self setImageWithNameForStateNormal:normal highlighted:highlightedAndSelected selected:highlightedAndSelected disabled:disabled];
}

- (void)setImageWithNameForStateNormal:(NSString *)normal highlighted:(NSString *)highlighted selected:(NSString *)selected disabled:(NSString *)disabled
{
    if(normal)
        [self setImage:[UIImage imageForKey:normal] forState:UIControlStateNormal];
    if(highlighted)
        [self setImage:[UIImage imageForKey:highlighted] forState:UIControlStateHighlighted];
    if(selected)
        [self setImage:[UIImage imageForKey:selected] forState:UIControlStateSelected];
    if(disabled)
        [self setImage:[UIImage imageForKey:disabled] forState:UIControlStateDisabled];
}

@end