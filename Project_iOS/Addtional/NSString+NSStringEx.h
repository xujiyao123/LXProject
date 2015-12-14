//
//  NSString+NSStringEx.h
//  xiaonei
//
//  Created by citydeer on 09-4-15.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

NSInteger strCompare(id str1, id str2, void *context);

@interface NSString(NSStringEx)

/**
 *SSO　SecretKey　AES加密
 *
 *＠param　key　密钥
 */
//- (NSString *)AES128EncryptWithKey:(NSString *)key;

/**
 *SSO　SecretKey　AES解密
 *
 *＠param　key　密钥
 */
//- (NSString *)AES128DecryptWithKey:(NSString *)key;

- (NSNumber*) stringToNumber;

//长整型用stringToNumber转换会出问题

- (NSNumber *)stringToLongLongNumber;
/**
 * 将字符串以URL编码.但'=', '&'字符除外.
 *
 * @param stringEncoding 编码类型
 * @return 编码后的字符串
 */
- (NSString*) urlEncode:(NSStringEncoding)stringEncoding;
/*
 * 解码
 */
- (NSString*) urlDecode:(NSStringEncoding)stringEncoding;
/**
 * 将字符串以URL编码.
 *
 * @param stringEncoding 编码类型
 * @return 编码后的字符串
 */
- (NSString*) urlEncode2:(NSStringEncoding)stringEncoding;

- (NSString *)stringByReplaceString:(NSString *)rs withCharacter:(char)c;

/**
 * 将字符串MD5加密.
 *
 * @return 加密后的字符串.
 */
- (NSString*) md5;

/**
 * 给查询字符串添加Signature.
 *
 * 暂时给map模块用的,TODO
 * @return 添加Signature后的字符串.
 */
- (NSString*) queryAppendSignatureForMap;

+ (NSString*)componentsJoinedByDictionary:(NSDictionary *)dic
								seperator:(NSString *)seperator;

/**
 * 给查询字符串添加Signature.
 *
 * @return 添加Signature后的字符串.
 */
- (NSString*) queryAppendSignature:(NSString *)opSecretKey;

/**
 * 通过查询信息字典生成查询字符串,并附带Signature.字符串经过URL Encode.
 *
 * @param query 查询参数字典。
 * @param opSecretKey SecretKey。
 *
 * @return 添加Signature并URL Encode后的字符串.
 */
+ (NSString*) queryStringWithSignature:(NSDictionary*)query
                           opSecretKey:(NSString *)opSecretKey;
/**
 * 通过查询信息字典生成查询字符串,并附带Signature.字符串经过URL Encode。
 * 本方法主要正对3G手机开放平台，因为该平台计算sig时值只取前50个字符。
 *
 * @param query 查询参数字典。
 * @param opSecretKey SecretKey。
 * @param valueLenLimit 计算Signature是时参数值的长度限制。
 *
 * @return 添加Signature并URL Encode后的字符串.
 */
+ (NSString*) queryStringWithSignature:(NSDictionary*)query
                           opSecretKey:(NSString *)opSecretKey
						 valueLenLimit:(NSInteger)valueLenLimit;

+ (NSString*)signature:(NSDictionary*)query opSecretKey:(NSString *)opSecretKey valueLenLimit:(NSInteger)valueLenLimit;

/**
 * 通过查询信息字典生成查询字符串, 可配置字符串经过URL Encode.
 *
 * @return URL Encode后的字符串.
 */
+ (NSString *)queryStringFromQueryDictionary:(NSDictionary *)query withURLEncode:(BOOL)doURLEncode;

/**
 * 生成查询标识符,目前用于唯一标识一个缓存地址.
 *
 * @return 查询标识符字符串.
 */
- (NSString*) queryIdentifier;


// AzDG加密
//- (NSString*) AzDGCrypt:(NSString*)key;

// 根据人人网新鲜事日期的格式将字符串解析为NSDate
// 格式形如: 06-17 15:07
- (NSDate*) dateFromFeedFormat;

// 根据人人网状态日期的格式将字符串解析为NSDate
// 格式形如: 2009-06-17 15:07:49
- (NSDate*) dateFromStatusFormat;

// 根据人人网相册日期的格式将字符串解析为NSDate
// 格式形如: 2009-06-17
- (NSDate*) dateFromAlbumFormat;

/**
 * 将格式为:yyyyMMddHHmmss
 */
- (NSDate*)dateFromStringyyyyMMddHHmmss;

- (NSDate*)dateFromStringyyyyMMdd;

// Trim whitespace
- (NSString *)trim;
- (NSString *) stringTrimAsNewsfeed;
- (NSString *) getParameter:(NSString *)parameterName;

/**
 * 对发送的一些字符做转义处理.
 */
//- (NSString*)escapeForPost;

//- (NSString*) des3:(NSString*)key encrypt:(BOOL)isEncrypt;

//格式化赞和评论数目
//1~9999，直接显示数字；
//1万~9.9万，显示单位为万，小数位不为0则保留一位小数点，如1.2万、9.9万，如果小数位为0，则不保留小数点，如3万；
//10万到99万，显示单位为万，不保留小数位，如13万，99万；
//1百万~9百万，显示单位为百万，如3百万、9百万；1千万到9千万，显示单位为千万，如3千万；
//1亿及以上显示单位为亿，如3亿，99亿；
//最大支持单位为亿，比99亿大的，显示为99亿+
+ (NSString *)formatStringWithCountNum:(long long int)countNum;

/**
 * 预处理为实体应用,例如把 & 替换成 &amp;
 */
+ (NSString *) preParseER:(NSString*)string;

/**
 * 预处理为实体应用,例如把 其中 & 替换成 空;
 */
+ (NSString *) preParseERNotAt:(NSString*)string;

/**
 * 将预处理的文字转化回来为,例如把 &amp;替换成 &
 */
+ (NSString *) afterParseER:(NSString*)string;

/**
 * 对来自rest接口的状态进行过滤
 */
- (NSString*)stringByFilterForStatusFromRest;

/**
 * 去掉字符中间的空格,只保留一个.
 */
- (NSString*)stringByTrimmingWhitespace;

/**
 * 给解码Aes编码
 *
 */
//- (NSString*) stringByDecodeAes;
/**
 * 字符串中包含的字数，
 * 汉子占一个字，英文或标点占用半个字
 */
-(NSInteger)CountWord;

// 判断字符串是否为空
+ (BOOL)stringIsNull:(NSString *)string;


/// 遍历所有正则匹配
/// @param match 匹配的 subString
/// @param index 第几个匹配 (从0开始)
/// @param matchRange 匹配的 subString 的范围
/// @param stop 设置为NO则停止遍历
- (void)enumerateRegexMatches:(NSString *)regex usingBlock:(void (^)(NSString *match, NSInteger index, NSRange matchRange, BOOL *stop))block;


/**
 为文件名添加 @2x, @3x 的后缀: @"name" -> @"name@2x"
 这里假设没有扩展名
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon.top" </td><td>"icon.top@2x" </td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale Resource scale.
 @return String by add scale modifier, or just return if it's not end with file name.
 */
- (NSString *)stringByAppendingNameScale:(CGFloat)scale;

/**
 为完整文件名添加 @2x, @3x 后缀: @"name.png" -> @"name@2x.png"
 这里假设有扩展名
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon.png" </td><td>"icon@2x.png" </td></tr>
 <tr><td>"icon..png"</td><td>"icon.@2x.png"</td></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon."    </td><td>"icon.@2x"    </td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale Resource scale.
 @return String by add scale modifier, or just return if it's not end with file name.
 */
- (NSString *)stringByAppendingPathScale:(CGFloat)scale;

/**
 解析字符串的scale.
 例如 icon@2x.png 返回 2.
 
 e.g.
 <table>
 <tr><th>Path            </th><th>Scale </th></tr>
 <tr><td>"icon.png"      </td><td>1     </td></tr>
 <tr><td>"icon@2x.png"   </td><td>2     </td></tr>
 <tr><td>"icon@2.5x.png" </td><td>2.5   </td></tr>
 <tr><td>"icon@2x"       </td><td>1     </td></tr>
 <tr><td>"icon@2x..png"  </td><td>1     </td></tr>
 <tr><td>"icon@2x.png/"  </td><td>1     </td></tr>
 </table>
 */
- (CGFloat)pathScale;

@end
@interface NSMutableAttributedString (OHCommodityStyleModifiers)
-(void)setFont:(UIFont*)font;
-(void)setFont:(UIFont*)font range:(NSRange)range;
-(void)setFontName:(NSString*)fontName size:(CGFloat)size;
-(void)setFontName:(NSString*)fontName size:(CGFloat)size range:(NSRange)range;
-(void)setFontFamily:(NSString*)fontFamily size:(CGFloat)size bold:(BOOL)isBold italic:(BOOL)isItalic range:(NSRange)range;

-(void)setTextColor:(UIColor*)color;
-(void)setTextColor:(UIColor*)color range:(NSRange)range;
-(void)setTextIsUnderlined:(BOOL)underlined;
-(void)setTextIsUnderlined:(BOOL)underlined range:(NSRange)range;
-(void)setTextUnderlineStyle:(int32_t)style range:(NSRange)range; //!< style is a combination of CTUnderlineStyle & CTUnderlineStyleModifiers
-(void)setTextBold:(BOOL)isBold range:(NSRange)range;

-(void)setTextAlignment:(CTTextAlignment)alignment lineBreakMode:(CTLineBreakMode)lineBreakMode;
-(void)setTextAlignment:(CTTextAlignment)alignment lineBreakMode:(CTLineBreakMode)lineBreakMode range:(NSRange)range;
@end

@interface NSAttributedString (OHCommodityConstructors)
+(id)attributedStringWithString:(NSString*)string;
+(id)attributedStringWithAttributedString:(NSAttributedString*)attrStr;

//! Commodity method that call the following sizeConstrainedToSize:fitRange: method with NULL for the fitRange parameter
-(CGSize)sizeConstrainedToSize:(CGSize)maxSize;
//! if fitRange is not NULL, on return it will contain the used range that actually fits the constrained size.
//! Note: Use CGFLOAT_MAX for the CGSize's height if you don't want a constraint for the height.
-(CGSize)sizeConstrainedToSize:(CGSize)maxSize fitRange:(NSRange*)fitRange;
@end


