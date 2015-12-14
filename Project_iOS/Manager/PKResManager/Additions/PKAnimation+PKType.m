//
//  PKAnimation+PKType.m
//  RenrenOfficial-iOS-Concept
//
//  Created by wangtao on 13-7-24.
//  Copyright (c) 2013年 renren. All rights reserved.
//

#import "PKAnimation+PKType.h"
#import "PKResManagerKit.h"

@implementation PKAnimation_PKType

+ (id)animationForKey:(id)key
{
    NSArray *keyArray = [key componentsSeparatedByString:@"-"];
    NSAssert1(keyArray.count == 2, @"module key name error!!! [font]==> %@", key);

    NSString *moduleKey = keyArray[0];
    NSString *memberKey = keyArray[1];

    NSDictionary *moduleDict = ([PKResManager getInstance].resOtherCache)[moduleKey];
    NSDictionary *memberDict = moduleDict[memberKey];

    if (memberDict.count <= 0) {

        moduleDict = ([PKResManager getInstance].defaultResOtherCache)[moduleKey];
        memberDict = moduleDict[memberKey];
    }
    if (memberDict.count <= 0) {
        return nil;
    }
    NSDictionary *animalDict = memberDict;
    int count = [[animalDict objectForKey:kAnimationCount] intValue];
    NSString *namePrefix = [animalDict objectForKey:kAnimationImagePrefix];
    CGFloat duration = [[animalDict objectForKey:kAnimationDuration]floatValue];
    CGFloat width = [[animalDict objectForKey:kAnimationWidth] floatValue];
    CGFloat height = [[animalDict objectForKey:kAnimationHeight] floatValue];
    NSInteger repateCount = [[animalDict objectForKey:kAnimationRepeat] integerValue];
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 1; i <= count; i++) {
        UIImage *picImage = [UIImage imageForKey:[NSString stringWithFormat:@"%@%d",namePrefix,i]];
        if (!picImage) {
            picImage = [UIImage imageForKey:[NSString stringWithFormat:@"%@0%d",namePrefix,i]];
        }
        if (picImage) {
            [imageArray addObject:picImage];
        }
    }
    UIImageView *_arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _arrowImageView.animationImages = imageArray;
    if ([imageArray count] > 0) {
        _arrowImageView.image = [imageArray objectAtIndex:0];
    }
    _arrowImageView.animationDuration = duration;

    if (repateCount > 0) {
        _arrowImageView.animationRepeatCount = repateCount;
    }
    
    return _arrowImageView;
}

+ (id)typeValueForKey:(id)key
{
    //example
    //[PKAnimation_PKType typeValueForKey:@"FeedModule-head_view_shape"];
    NSArray *keyArray = [key componentsSeparatedByString:@"-"];
    NSAssert1(keyArray.count == 2, @"module key name error!!! [type]==> %@", key);

    NSString *moduleKey = keyArray[0];
    NSString *memberKey = keyArray[1];

    NSDictionary *moduleDict = ([PKResManager getInstance].resOtherCache)[moduleKey];
    NSDictionary *memberDict = moduleDict[memberKey];

    if (memberDict.count <= 0) {

        moduleDict = ([PKResManager getInstance].defaultResOtherCache)[moduleKey];
        memberDict = moduleDict[memberKey];
    }

    id type = [memberDict objectForKey:@"value"];
    return type;
}

@end
