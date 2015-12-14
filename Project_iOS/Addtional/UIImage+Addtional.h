//
//  UIImage+Addtional.h
//  RenrenOfficial-iOS-Concept
//
//  Created by sunyuping on 13-6-21.
//  Copyright (c) 2013年 renren. All rights reserved.
//

#import <UIKit/UIKit.h>
// 定义了在缩放图片时，以哪条边作为参考边
typedef enum{
    EINUIImageZommLineDefault,  // 默认值
    EINUIImageZommLineWidth, // 宽作为参考边
    EINUIImageZommLineHeight, // 高作为参考边
    EINUIImageZommLineLonger, // 长边作为参考边
    EINUIImageZommLineShorter, // 短边作为参考边
    EINUIImageZommLineNone,     // 不区分边
} INUIImageZommLine;


@interface UIImage (RNAdditions)
// 缩放图片
+ (UIImage *)scaleImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (UIImage*)clipImage:(UIImage *)originalImage rect:(CGRect)rect;

//中间拉伸自动宽高
+ (UIImage*)middleStretchableImageWithKey:(NSString*)key ;
//中间拉伸图片,不支持换肤
+ (UIImage *)middleStretchableImageWithOutSupportSkin:(NSString *)key;

+ (UIImage *) createRoundedRectImage:(UIImage*)image size:(CGSize)size cornerRadius:(CGFloat)radius;

// 缩放图片并且剧中截取
+ (UIImage *)middleScaleImage:(UIImage *)image scaleToSize:(CGSize)size;
//宽高取小缩放，取大居中截取
+ (UIImage *)suitableScaleImage:(UIImage *)image scaleToSize:(CGSize)size;
//等比缩放到多少倍
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
//等比例缩放
+(UIImage*)scaleToSize:(UIImage*)image size:(CGSize)size;
// zhengzheng
//等比缩放
+ (UIImage *) scaleImageForImage:(UIImage *)image toScale:(float)scaleSize;
- (UIImage *)fixOrientation;

//截取部分图像(区分高分屏或者低分屏)
/* ++++++++++++++++++++++++++++++++++++++
 *
 * zhengzheng
 
 @param img 需要被截取的图片
 @param scale  倍率（低分屏1.0 高分屏2.0）
 @param rect 截取的范围
 @return 返回截取后的图片
 */
+ (UIImage*)getSubImage:(UIImage *)img scale:(CGFloat)scale rect:(CGRect)rect;
/* ------------------------------------- */

// 判断是否超长超宽图（宽高比大于4）
+ (BOOL)isLongwidePhoto:(UIImage*)image;

// 将宽高比大于4的图，截取顶部的宽高 1：2 的部分
+ (UIImage*)longwidePhotoToNormal:(UIImage*)image;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageForRHCButton:(UIColor *)backColor border:(UIColor *)borderColor shadow:(UIColor *)shadowColor radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth withFrame:(CGRect)frame;


#pragma mark - 图片效果
///=============================================================================
/// @name 图片效果
///=============================================================================

/// 给图片染色(Tint Color) (将Alpha通道染色)
- (UIImage *)imageByTintColor:(UIColor *)color;

/// 灰毛玻璃效果 (适合在里面显示任何内容)
- (UIImage *)imageByBlurSoft;

/// 白色毛玻璃效果 (苹果内置)(适合在里面显示任何内容，除了纯白色文本) 和上拉控制中心、桌面文件夹效果一样
- (UIImage *)imageByBlurLight;

/// 亮白色毛玻璃效果 (苹果内置)(适合在里面显示深色文字)
- (UIImage *)imageByBlurExtraLight;

/// 黑色色毛玻璃效果 (苹果内置)(适合在里面显示浅色文字) 和下拉通知中心的效果一样
- (UIImage *)imageByBlurDark;

/// 模糊一张图片，并添加tintColor
- (UIImage *)imageByBlurWithTint:(UIColor *)tintColor;

/**
 * 模糊一张图片 (只模糊，不调整颜色)
 *
 * @param radius           模糊半径(力度) iOS7模糊大约是40
 */
- (UIImage *)blurredImageWithRadius:(CGFloat)radius;

/**
 * 模糊一张图片
 *
 * @param radius           模糊半径(力度) iOS7模糊大约是40
 * @param iterations       模糊迭代次数 (次数越多、计算量越大、模糊越平滑，通常3就足够了)
 * @param tintColor        模糊后着色 (如果该值为nil,则不会进行着色)
 * @param tintColorPercent 着色的百分比 (0.0~1.0)
 * @param blendMode        着色的混合模式
 */
- (UIImage *)blurredImageWithRadius:(CGFloat)radius
                         iterations:(NSUInteger)iterations
                          tintColor:(UIColor *)tintColor
                   tintColorPercent:(CGFloat)tintColorPercent
                          blendMode:(CGBlendMode)blendMode;

/**
 这是苹果官方提供的一个方法，用于调整图片的模糊、饱和度、蒙板等方法。
 
 Applies a blur, tint color, and saturation adjustment to this image,
 optionally within the area specified by @a maskImage.
 
 @param blurRadius     The radius of the blur in points, 0 means no blur effect.
 
 @param tintColor      An optional UIColor object that is uniformly blended with
 the result of the blur and saturation operations. The
 alpha channel of this color determines how strong the
 tint is. nil means no tint.
 
 @param tintBlendMode  The @a tintColor blend mode. Default is kCGBlendModeNormal (0).
 
 @param saturation     A value of 1.0 produces no change in the resulting image.
 Values less than 1.0 will desaturation the resulting image
 while values greater than 1.0 will have the opposite effect.
 0 means gray scale.
 
 @param maskImage      If specified, @a inputImage is only modified in the area(s)
 defined by this mask.  This must be an image mask or it
 must meet the requirements of the mask parameter of
 CGContextClipToMask.
 
 @return               image with effect, or nil if an error occurs (e.g. no
 enough memory).
 */
- (UIImage *)imageByBlurRadius:(CGFloat)blurRadius
                     tintColor:(UIColor *)tintColor
                      tintMode:(CGBlendMode)tintBlendMode
                    saturation:(CGFloat)saturation
                     maskImage:(UIImage *)maskImage;



+(UIImage*)imageFromView:(UIView*)view;

- (UIImage *)fixOrientation:(UIImageOrientation) orient;

+ (UIImage *)zoomUploadImageWith:(UIImage *)image rate:(CGFloat)rate maxLength:(CGFloat)length;

@end
