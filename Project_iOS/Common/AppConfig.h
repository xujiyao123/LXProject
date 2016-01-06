//
//  AppConfig.h
//  Project_iOS
//
//  Created by 刘旭 on 16/1/7.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject
//获取设备操作系统版本号
@property (nonatomic, copy) NSString *deviceScreenBoundsRecord;
// 本应用在appStore的ID
@property (nonatomic, copy) NSString *appStoreId;
// 3G API URL
@property (nonatomic, copy) NSString *mApiUrl;

@property (nonatomic, copy) NSString *mTestUrl;
// 客户端代码，用在UA中
@property (nonatomic, copy) NSString *clientCode;
// 客户端名称，用在关于中体现
@property (nonatomic, copy) NSString *clientName;
// 客户端版本号
@property (nonatomic, copy) NSString *version;
// 设备型号
@property (nonatomic, copy) NSString *deviceModel;
// 数据库路径
@property (nonatomic, copy) NSString *databasePath;

@property (nonatomic, assign) NSUInteger httpTimeout;

@end
