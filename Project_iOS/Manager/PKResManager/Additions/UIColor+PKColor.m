//
//  UIColor+PKColor.m
//  PKResManager
//
//  Created by zhongsheng on 12-11-27.
//
//

#import "UIColor+PKColor.h"
#import "PKResManagerKit.h"

@implementation UIColor (PKColor)

+ (UIColor *)colorForKey:(id)key
{
    return [UIColor colorForKey:key style:PKColorTypeNormal];
}

+ (UIColor *)shadowColorForKey:(id)key
{
    return [UIColor colorForKey:key style:PKColorTypeShadow];
}

+ (UIColor *)colorForKey:(id)key style:(PKColorType)type
{
    NSArray *keyArray = [key componentsSeparatedByString:@"-"];
    NSAssert1(keyArray.count == 2, @"module key name error!!! [color] ==> %@", key);
    
    NSString *moduleKey = keyArray[0];
    NSString *memberKey = keyArray[1];
    
    NSDictionary *moduleDict = ([PKResManager getInstance].resOtherCache)[moduleKey];
    // 容错处理读取默认配置
    if (moduleDict.count <= 0)
    {
        moduleDict = ([PKResManager getInstance].defaultResOtherCache)[moduleKey];
    }
    NSAssert1(moduleDict.count > 0, @"module not exist !!! [color] ==> %@", key);
    NSDictionary *memberDict = moduleDict[memberKey];
    // 容错处理读取默认配置
    if (memberDict.count <= 0) {
        moduleDict = ([PKResManager getInstance].defaultResOtherCache)[moduleKey];
        memberDict = moduleDict[memberKey];
    }
//    NSAssert1(memberDict.count > 0, @"color not exist !!! [color] ==> %@", key);

    NSString *colorStr = memberDict[kColor];
    
    BOOL shadow = NO;
    if (type & PKColorTypeShadow) {
        shadow = YES;
        colorStr = memberDict[kShadowColor];
    }
    if (type & PKColorTypeHightLight) {
        colorStr = memberDict[kColorHL];
        if (shadow) {
            colorStr = memberDict[kShadowColorHL];
        }
    }
    if (type & PKColorTypeDisable) {
        colorStr = memberDict[kColorDisable];
        if (shadow) {
            colorStr = memberDict[kColorDisable];
        }
    }

    if ([colorStr hasPrefix:@"#"]) {
        colorStr = [colorStr substringFromIndex:1];
        
        if (colorStr.length > 6) {
            //a,r,g,b
            
            NSRange range;
            range.location = 0;
            range.length = 2;

            //a
             NSString *aString = [colorStr substringWithRange:range];
            
            //r
            range.location = 2;
            NSString *rString = [colorStr substringWithRange:range];

            //g
            range.location = 4;
            NSString *gString = [colorStr substringWithRange:range];

            //b
            range.location = 6;
            NSString *bString = [colorStr substringWithRange:range];

            // Scan values
            unsigned int a, r, g, b;
            [[NSScanner scannerWithString:aString] scanHexInt:&a];
            [[NSScanner scannerWithString:rString] scanHexInt:&r];
            [[NSScanner scannerWithString:gString] scanHexInt:&g];
            [[NSScanner scannerWithString:bString] scanHexInt:&b];
            
            return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:a/100.0f];
        }
        else
        {
            NSRange range;
            range.location = 0;
            range.length = 2;

            //r
            NSString *rString = [colorStr substringWithRange:range];

            //g
            range.location = 2;
            NSString *gString = [colorStr substringWithRange:range];

            //b
            range.location = 4;
            NSString *bString = [colorStr substringWithRange:range];

            // Scan values
            unsigned int r, g, b;
            [[NSScanner scannerWithString:rString] scanHexInt:&r];
            [[NSScanner scannerWithString:gString] scanHexInt:&g];
            [[NSScanner scannerWithString:bString] scanHexInt:&b];

            return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
        }
    }
    
    NSNumber *redValue;
    NSNumber *greenValue;
    NSNumber *blueValue;
    NSNumber *alphaValue;
    NSArray *colorArray = [colorStr componentsSeparatedByString:@","];
    if (colorArray != nil && colorArray.count == 3) {
        redValue = @([colorArray[0] floatValue]);
        greenValue = @([colorArray[1] floatValue]);
        blueValue = @([colorArray[2] floatValue]);
        alphaValue = @1.0f;
    } else if (colorArray != nil && colorArray.count == 4) {
        redValue = @([colorArray[0] floatValue]);
        greenValue = @([colorArray[1] floatValue]);
        blueValue = @([colorArray[2] floatValue]);
        alphaValue = @([colorArray[3] floatValue]);
    } else {
        return nil;
    }
    
    if ([alphaValue floatValue]<=0.0f) {
        return [UIColor clearColor];
    }
    return [UIColor colorWithRed:(CGFloat)([redValue floatValue]/255.0f)
                           green:(CGFloat)([greenValue floatValue]/255.0f)
                            blue:(CGFloat)([blueValue floatValue]/255.0f)
                           alpha:(CGFloat)([alphaValue floatValue])];

    
}

+(UIColor *)colorWithRegHexString:(NSString*)key
{
    return [UIColor colorWithRegHexString:key style:PKColorTypeNormal];
}

+(UIColor *)colorWithRegHexString:(NSString*)key style:(PKColorType)type{
    NSArray *keyArray = [key componentsSeparatedByString:@"-"];
    NSAssert1(keyArray.count == 2, @"module key name error!!! [color] ==> %@", key);

    NSString *moduleKey = keyArray[0];
    NSString *memberKey = keyArray[1];

    NSDictionary *moduleDict = ([PKResManager getInstance].resOtherCache)[moduleKey];
    // 容错处理读取默认配置
    if (moduleDict.count <= 0)
    {
        moduleDict = ([PKResManager getInstance].defaultResOtherCache)[moduleKey];
    }
    NSAssert1(moduleDict.count > 0, @"module not exist !!! [color] ==> %@", key);
    NSDictionary *memberDict = moduleDict[memberKey];
    // 容错处理读取默认配置
    if (memberDict.count <= 0) {
        moduleDict = ([PKResManager getInstance].defaultResOtherCache)[moduleKey];
        memberDict = moduleDict[memberKey];
    }
    NSAssert1(memberDict.count > 0, @"color not exist !!! [color] ==> %@", key);

    NSString *colorStr = memberDict[kColor];

    BOOL shadow = NO;
    if (type & PKColorTypeShadow) {
        shadow = YES;
        colorStr = memberDict[kShadowColor];
    }
    if (type & PKColorTypeHightLight) {
        colorStr = memberDict[kColorHL];
        if (shadow) {
            colorStr = memberDict[kShadowColorHL];
        }
    }
    if (type & PKColorTypeDisable) {
        colorStr = memberDict[kColorDisable];
    }

    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;

    //r
    NSString *rString = [cString substringWithRange:range];

    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
