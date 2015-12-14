// ----------------------------------------------------------------------
// Part of the SQLite Persistent Objects for Cocoa and Cocoa Touch
//
// Original Version: (c) 2008 Jeff LaMarche (jeff_Lamarche@mac.com)
// ----------------------------------------------------------------------
// This code may be used without restriction in any software, commercial,
// free, or otherwise. There are no attribution requirements, and no
// requirement that you distribute your changes, although bugfixes and 
// enhancements are welcome.
// 
// If you do choose to re-distribute the source code, you must retain the
// copyright notice and this license information. I also request that you
// place comments in to identify your changes.
//
// For information on how to use these classes, take a look at the 
// included Readme.txt file
// ----------------------------------------------------------------------

#if (TARGET_OS_IPHONE)
#import <Foundation/Foundation.h>

/*!
 On the iPhone NSObject does not provide the className method.
 */
@interface NSObject(ClassName)
- (NSString *)className;
+ (NSString *)className;
/*
 NSDictionary
 NSArray
 NSSet
 is nil OR zero element
 */
+ (BOOL)isEmptyContainer:(NSObject *)o;


@end
#endif
#ifdef DEBUG
@interface NSObject (RHCBlockTimer)
/*
 block       ：需要时间测试的语句块
 prefixString：日志前缀字符串，用于区分
 */
- (void)logTimeConsumptionOfBlock:(void (^)(void)) block withPrefix:(NSString*) prefixString;

+(void)sendMemoryWarning;
@end
#endif
