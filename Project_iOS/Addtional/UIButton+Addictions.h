//
//  UIButton+Addictions.h
//  RenrenOfficial-iOS-Concept
//
//  Created by Guichao Huang on 13-12-12.
//  Copyright (c) 2013年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIButton(SubviewsPosition)

- (void)centerImageAndTitleWithSpacing:(CGFloat)spacing;

@end

@interface UIButton(SetImage)

- (void)setImageWithNameForStateNormal:(NSString *)normal;
- (void)setImageWithNameForStateNormal:(NSString *)normal highlightedAndSelected:(NSString *)highlightedAndSelected disabled:(NSString *)disabled;
- (void)setImageWithNameForStateNormal:(NSString *)normal highlighted:(NSString *)highlighted selected:(NSString *)selected disabled:(NSString *)disabled;

@end
