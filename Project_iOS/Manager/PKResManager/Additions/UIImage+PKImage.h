//
//  UIImage+PKImage.h
//  PKResManager
//
//  Created by zhongsheng on 12-11-27.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (PKImage)

/*!
 *   @method
 *   @abstract get image by key
 *   @param needCache , will cached
 *   @param name, will not cached
 */
+ (UIImage *)imageForKey:(NSString *)key style:(NSString *)sid;
+ (UIImage *)imageForKey:(NSString *)key cache:(BOOL)needCache;
+ (UIImage *)imageForKey:(NSString *)key; // default cached
+ (NSString *)imagePathForKey:(NSString *)key; // default cached
+ (NSArray *)imageTypes;
@end
