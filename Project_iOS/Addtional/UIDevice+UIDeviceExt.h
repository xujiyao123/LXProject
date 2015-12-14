//
//  UIDevice+UIDeviceExt.h
//  RenrenCore
//
//  Created by SunYu on 11-11-1.
//  Copyright (c) 2011年 www.renren.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKitDefines.h>

@interface UIDevice (IdentifierAddition)

// 获取MAC地址
+ (NSString *)macAddress;
// 设备是否是iPad
+ (BOOL)isDeviceiPad;
// 获取机器型号，原始型号
+ (NSString *)machineModel;
// 获取机器型号名称，不识别的设备返回 machineModel，如 iPhone 8,8 返回 iPhone 8,8
+ (NSString *)machineModelName;
// 对机器型号做了结果过滤，不识别的设备返回设备类型，如 iPhone 8,8 返回 iPhone
+ (NSString *)prettyMachineModelName;
// 对低端机型的判断
+ (BOOL)isLowLevelMachine;
// 设备可用空间
// freespace/1024/1024/1024 = B/KB/MB/14.02GB
+(NSNumber *)freeSpace;
// 设备总空间
+(NSNumber *)totalSpace;
// 获取运营商信息
+ (NSString *)carrierName;
// 获取运营商代码
+ (NSString *)carrierCode;
//获取电池电量
+ (CGFloat) getBatteryValue;
//获取电池状态
+ (NSInteger) getBatteryState;
// 是否能发短信 不准确
+ (BOOL) canDeviceSendMessage;
// 是否显示雾面效果
+ (BOOL)canShowBlurEffect;
// 去除导航条的全平尺寸
+ (CGSize)screenSize;
// 屏幕宽(去掉statusbar)
+ (CGFloat)screenWidth;
// 屏幕高(去掉statusbar)
+ (CGFloat)screenHeight;

// 屏幕高度（包含statusbar）
+ (CGFloat)mainScreenHeight;

// 内存信息
+ (unsigned int)freeMemory;
+ (unsigned int)usedMemory;
// 判断是否是1136的retina4寸屏幕
+ (BOOL)isRetina4inch;
//判断手机是否越狱
+ (BOOL)isJailBroken;
+ (NSArray *)getDNSByHostname:(NSString *)hostname;
+ (NSDictionary *)externalIPInfo:(NSString *)url;

@end
