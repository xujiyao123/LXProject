//
//  PKResManager.h
//  TestResManager
//
//  Created by zhong sheng on 12-7-13.
//  Copyright (c) 2012年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

typedef enum {
	PKErrorCodeSuccess						= 0, // 自定义,表示成功.
	PKErrorCodeUnknow                       = 1, // 未知错误
	PKErrorCodeUnavailable	        		= 2, // 不可用，需要下载
    PKErrorCodeBundleName                   = 3, // bundleName问题
} PKErrorCode;


typedef void (^ResStyleProgressBlock) (double progress);
typedef void (^ResStyleCompleteBlock) (BOOL finished, NSError *error);

typedef enum {
    ResStyleType_System,
    ResStyleType_Custom,
    ResStyleType_Unknow
}ResStyleType;


@protocol PKResChangeStyleDelegate <NSObject>
@optional
- (void)changeSkinStyle:(id)sender;
@end

@interface PKResManager : NSObject
/*!
 * 通用Bundle
 */
@property (nonatomic, readonly) NSBundle *commonStyleBundle;

/*!
 * 当前主题 style bundle
 */
@property (nonatomic, readonly) NSBundle *styleBundle;
/*!
 * 默认主题下 plist 资源
 */
@property (nonatomic, readonly) NSMutableDictionary *defaultResOtherCache;
/*!
 * 图片缓存
 */
@property (nonatomic, strong) NSMutableDictionary *resImageCache;
/*!
 * plist 资源缓存
 */
@property (nonatomic, strong) NSMutableDictionary *resOtherCache;


/*!
 * All style Dict Array
 */
@property (nonatomic, readonly) NSMutableArray *allStyleArray;
/*!
 * Current style id
 */
@property (nonatomic, readonly) NSString *styleId;
/*!
 * Current style type
 */
@property (nonatomic, readonly) ResStyleType styleType;
/*!
 * is loading?
 */
@property (nonatomic, readonly) BOOL isLoading;

// Add style Object
- (void)addChangeStyleObject:(id)object;
// Object dealloc invoke this method!!!
- (void)removeChangeStyleObject:(id)object;

- (BOOL)containsStyleById:(NSString *)sid;
/*!
 * Switch to style by name
 * @discuss You should not swith to a new style until completed
 */
- (void)swithToStyle:(NSString *)sid; // not safety
- (void)swithToStyle:(NSString *)sid onComplete:(ResStyleCompleteBlock)block;
/*!
 * containsStyle
 */
- (BOOL)containsStyle:(NSString *)sid;
/*!
 * get change progress
 */
- (void)changeStyleOnProgress:(ResStyleProgressBlock)progressBlock;

/*!
 * save in custom file path
 */
- (BOOL)saveStyle:(NSString *)styleId name:(NSString *)name title:(NSString *)title version:(NSNumber *)version withBundle:(NSBundle *)bundle;
/*!
 * delete style
 */
- (BOOL)deleteStyle:(NSString *)sid;
/*!
 * clear image cache
 */
- (void)clearImageCache;
/*!
 * reset
 */
- (void)resetStyle;
/*!
 * 通过名字获取资源bundle
 */
- (NSBundle *)bundleByStyleId:(NSString *)sid;
/*!
 * 预览图
 */
- (UIImage *)previewImage;
- (UIImage *)previewImageByStyleId:(NSString *)sid;
/*!
 * 单例
 */
+ (PKResManager*)getInstance;

- (void)setButton:(UIButton *)button forKey:(NSString *)key andHightlighted:(BOOL)hightlighted;

- (void)setLabel:(UILabel *)label forKey:(NSString *)key;

@end
