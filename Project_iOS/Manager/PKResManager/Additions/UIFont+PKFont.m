//
//  UIFont+PKFont.m
//  PKResManager
//
//  Created by zhongsheng on 12-11-27.
//
//

#import "UIFont+PKFont.h"
#import "PKResManagerKit.h"

@implementation UIFont (PKFont)

+ (UIFont *)fontForKey:(id)key
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
    
    NSString *fontName = memberDict[@"font"];
    NSNumber *fontSize = memberDict[@"size"];

    UIFont *font = nil;
    if (fontName)
    {
        font = [UIFont fontWithName:fontName size:[fontSize floatValue]];
    }
    else
    {
        font = [UIFont lantingFontOfSize:[fontSize floatValue]];
    }

    return font;
}

@end
