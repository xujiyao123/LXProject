//
//  UIImage+PKImage.m
//  PKResManager
//
//  Created by zhongsheng on 12-11-27.
//
//

#import "UIImage+PKImage.h"
#import "NSBundle+Scale.h"
#import "PKResManagerKit.h"

@implementation UIImage (PKImage)

+ (UIImage *)imageForKey:(NSString *)key
{
    return [UIImage imageForKey:key cache:YES];
}

+ (UIImage *)imageForKey:(NSString *)key cache:(BOOL)needCache
{
    if (key == nil) {
        return nil;
    }

    key = [UIImage keyWhithoutExtension:key];
    
    UIImage *image = ([PKResManager getInstance].resImageCache)[key];
    if (image) {
        return image;
    }

    image = [UIImage imageForKey:key style:[PKResManager getInstance].styleId];
    
    if (image == nil) {
        image = [UIImage imageForKey:key inBundle:[PKResManager getInstance].commonStyleBundle];
    }
    
    if (image != nil && needCache){
        ([PKResManager getInstance].resImageCache)[key] = image;
    }
    
    return image;
}

+ (UIImage *)imageForKey:(NSString *)key style:(NSString *)sid
{
    if (key == nil) {
        return nil;
    }

    key = [UIImage keyWhithoutExtension:key];
    
    UIImage *image = nil;
    NSBundle *styleBundle = nil;
    // 不是当前style情况
    if (![sid isEqualToString:[PKResManager getInstance].styleId]){
        styleBundle = [[PKResManager getInstance] bundleByStyleId:sid];
    }else{
        styleBundle = [PKResManager getInstance].styleBundle;
    }
    
    image = [UIImage imageForKey:key inBundle:styleBundle];
    
    // mainBundle情况
    if (image == nil){
        styleBundle = [NSBundle mainBundle];
        image = [UIImage imageForKey:key inBundle:styleBundle];
    }

    return image;
}

// 支持png和jpg，可扩展
+ (UIImage *)imageForKey:(id)key inBundle:(NSBundle *)bundle
{
    NSArray *imageTypes = [UIImage imageTypes];
    NSString *imagePath = nil;
    for (int i = 0; i < imageTypes.count; i++) {
        NSString *type = [imageTypes objectAtIndex:i];
        imagePath = [bundle pathForResource:key ofType:type];
        if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
            break;
        }
    }
    if ( [key isKindOfClass:[NSString class]] ) {
        NSString *key2x = [key stringByAppendingString:@"@2x"];
        for (int i = 0; i < imageTypes.count; i++) {
            NSString *type = [imageTypes objectAtIndex:i];
            imagePath = [bundle pathForResource:key2x ofType:type];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
                break;
            }
        }
    }
    return [UIImage imageWithContentsOfFile:imagePath];
}

// 返回图片路径
+ (NSString *)imagePathForKey:(NSString *)key
{
    if (!key) {
        return nil;
    }

    key = [UIImage keyWhithoutExtension:key];
    
    NSString *imagePath = [UIImage imagePathForKey:key inBundle:[PKResManager getInstance].styleBundle];
    if (!imagePath) {
        imagePath = [UIImage imagePathForKey:key inBundle:[PKResManager getInstance].commonStyleBundle];

        NSAssert1(imagePath, @"imagePath not exist !!! [image] ==> %@", key);
    }

    return imagePath;
}

+ (NSString *)imagePathForKey:(id)key inBundle:(NSBundle *)bundle
{
    NSString *imagePath = nil;
    for (NSString *suffix in [UIImage imageTypes]) {
        imagePath = [bundle pathForScaledResource:key ofType:[suffix substringFromIndex:1]];
        if (imagePath) {
            break;
        }
    }
    return imagePath;
}

+ (NSString *)keyWhithoutExtension:(NSString *)key
{
    for (NSString *suffix in [UIImage imageTypes]) {
        if ([key hasSuffix:suffix]) {
            key = [key substringToIndex:key.length - suffix.length];
            break;
        }
    }
    return key;
}

+ (NSArray *)imageTypes
{
    static NSMutableArray *typesArray = nil;

    if (!typesArray) {
        typesArray = [[NSMutableArray alloc]init];
        [typesArray addObject:@".png"];
        [typesArray addObject:@".jpg"];
        [typesArray addObject:@".gif"];
    }
    return typesArray;
}
@end
