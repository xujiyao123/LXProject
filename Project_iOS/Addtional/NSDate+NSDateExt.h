//
//  NSDate+NSDateExt.h
//  xiaonei
//
//  Created by ipod on 09-6-18.
//  Copyright 2009 opi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(NSDateExt)
- (NSInteger) compareWithToday;
- (BOOL) compareWithToday2;
- (BOOL)compareWithThisYear;
- (NSString *) stringForSectionTitle;
- (NSString *) stringForSectionTitle2; //用于RenReniPad最近来访时间格式
- (NSString *) stringForSectionTitle3; //iphone
- (NSString *) stringForSectionTitle4;//目前sixin和ipad的时间分割策略，今天只显示HH:mm,不显示“今天”
- (NSString *) stringForSectionTitle5;//人人聊天的时间分割策略，前天以前的只显示日期
- (NSString *) stringForSectionTitle6;//人人聊天对话页的时间分割策略
- (NSString *) stringForSectionTitle7;//人人聊天搜索结果的时间显示策略
- (NSString *) stringForDateline; //将时间变为 yyyy－mm－dd的格式
- (NSString *) stringForTimeline; //将时间变为 mm-dd HH:mm  
- (NSString *) stringForTimeline2;//将时间变为 HH:mm
- (NSString *) stringForTimeRelative;//计算原时间与现在时间的相对差，以字符串形式返回
/* +++++++++++++++++++++++++++++++++++++++++++++++++++++ */
/* 
 * zhengzheng 新鲜事，评论列表时间显示策略
 */
- (NSString*) stringForTimeRelativeForFeed;
/* ----------------------------------------------------- */
- (NSString *) stringForYyyymmddhhmmss;
- (NSString *) stringForIntervalSince1970; // 计算自1970年以来的秒数并返回字符串
- (NSString *) stringForVisitorTitle; //人人最近来访时间格式

- (NSString *)stringForYMD;
- (NSString*) stringForDatelineCN;
@end
