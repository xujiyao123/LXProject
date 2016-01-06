//
//  AppConfig.m
//  Project_iOS
//
//  Created by 刘旭 on 16/1/7.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig
- (id)init {
    self = [super init];
    if (self != nil) {
        [self initEnv];
    }
    return self;
}


-(void)initEnv
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    // 客户端信息
    self.clientCode = @"1.0.0";
    self.clientName = @"Project";
    
    //应用在appStore的ID
    self.appStoreId = @"939971278";
    // 应用版本
    self.version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // Path for cache database file
    self.databasePath = [docDir stringByAppendingPathComponent:@"cachedb.sql"];
    
    self.httpTimeout = 45;
    
    // 设备型号
    self.deviceModel = [UIDevice machineModelName];
    
    // 线上环境参数
    self.mApiUrl = @"xx";
    
    self.mTestUrl = @"xx";
    
    self.mApiUrl = self.mTestUrl;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    NSString *DeviceScreenBounds = [NSString stringWithFormat:@"%dx%d", (int)screenBounds.size.width, (int)screenBounds.size.height];
    self.deviceScreenBoundsRecord = DeviceScreenBounds;
    
}

@end
