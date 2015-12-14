//
//  PKResManager.h
//  TestResManager
//
//  Created by zhong sheng on 12-7-16.
//  Copyright (c) 2012年 . All rights reserved.
//

#ifndef PKResManagerKit_PKResManagerKit_h
#define PKResManagerKit_PKResManagerKit_h

#ifndef __IPHONE_4_0
#error "PKResManager uses features only available in iOS SDK 4.0 and later."
#endif

#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

#import "PKResManager.h"
#import "UIImage+PKImage.h"
#import "UIColor+PKColor.h"
#import "UIFont+PKFont.h"
#import "PKAnimation+PKType.h"

#define BUNDLE_PREFIX    @"bundle://"
#define DOCUMENTS_PREFIX @"documents://"

#define kAllResStyle     @"kAllResStyle"
#define kNowResStyle     @"kNowResStyle"

#define SAVED_STYLE_DIR  @"skinDocument"
#define TEMP_STYLE_DIR   @"TempStyleDir"

#define kStyleID       @"kStyleID"
#define kStyleName     @"kStyleName"
#define kStyleTitle    @"kStyleTitle"
#define kStyleVersion  @"kStyleVersion"
#define kStyleURL      @"kStyleURL"
// color
#define kColor           @"rgb"
#define kColorHL         @"rgb_hl"
#define kShadowColor     @"shadow_rgb"
#define kShadowColorHL   @"shadow_rgb_hl"
#define kShadowOffset    @"shadow_offset"
#define kColorDisable     @"rgb_disable"

//animation
#define kAnimationDuration    @"duration"
#define kAnimationCount       @"image_count"
#define kAnimationImagePrefix @"image_name_prefix"
#define kAnimationHeight      @"image_height"
#define kAnimationWidth       @"image_width"
#define kAnimationRepeat      @"repeat_count"

#define SYSTEM_STYLE_COMMOM_BUNDLE_NAME @"common"
#define SYSTEM_STYLE_COMMON_BUNDLE @"bundle://resource_common.bundle"

#define SYSTEM_STYLE_ID         @"default"
#define SYSTEM_STYLE_NAME       @"default"
#define SYSTEM_STYLE_TITLE      @"海蓝主题"
#define SYSTEM_STYLE_URL        @"bundle://skin_default.bundle"
#define SYSTEM_STYLE_VERSION    @"999.0"

#define CONFIG_PLIST_PATH    @"/#config/styleConfig"
#define PREVIEW_PATH         @"/#config/preview"

// error
#define PK_ERROR_DOMAIN   @"PK_ERROR_DOMAIN"

#endif