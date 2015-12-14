//
//  UIDevice+Addtional.h
//  RenrenSixin
//
//  Created by TLB on 12-2-22.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ cameraAuthorziedBlock) (void);

@interface UIDevice (Addtional)

// 是否是iPhone
+ (BOOL)isiPhone;

// 是否是iPad
+ (BOOL)isiPad;

// 是否是iTouch
+ (BOOL)isiPodTouch;

// 支持拔打电话
+ (BOOL)supportTelephone;

// 支持发送短信
+ (BOOL)supportSendSMS;

// 支持发送邮件
//+ (BOOL)supportSendMail;

// 支持摄像头取景
+ (BOOL)supportCamera;

+ (void)cameraAuthorzied:(cameraAuthorziedBlock)authorizedBlock notAuthorized:(cameraAuthorziedBlock)notAuthorizedlock;
// 以全小写的形式返回设备名称
- (NSString*)modelNameLowerCase;

// 系统版本，以float形式返回
- (CGFloat)systemVersionByFloat;

// 系统版本比较
+ (BOOL)isHigherIOS5;
+ (BOOL)isHigherIOS6;
+ (BOOL)isHigherIOS7;
+ (BOOL)isHigherIOS8;

- (NSString *) macaddress;

// 内存信息
+ (unsigned int)freeMemory;
+ (unsigned int)usedMemory;

@end
