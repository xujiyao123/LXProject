//
//  AppUser.m
//  Project_iOS
//
//  Created by 刘旭 on 16/1/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "AppUser.h"
#define kAppUserInfoPath        @"user.archiver"
#define kCommonDir              @"common"
#define kEmotionDir             @"emotion"

@implementation AppUser
+ (AppUser *)makeAppUser:(NSDictionary *)dict
{
    AppUser *user = [[AppUser alloc]init];
    user.weiboId = [dict objectForKey:@"weibo_id"];
    user.userId = [dict objectForKey:@"user_id"];
    user.secretKey = [dict objectForKey:@"secret_key"];
    user.sessionKey = [dict objectForKey:@"session_key"];
    user.username = [dict objectForKey:@"user_name"];
    user.headUrl = [dict objectForKey:@"user_head_img"];
    user.imName = [dict objectForKey:@"im_name"];
    user.imSecret = [dict objectForKey:@"im_secret"];
    BOOL save = [user persistence];
    DDLogCInfo(@"save userInfo:%d",save);
    return user;
}

+ (AppUser *)wakeUpUser
{
    AppUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:[self userArchiverPath]];
    return user;
}

// App Document 路径
+ (NSString *)documentPath
{
    NSArray  *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [searchPath objectAtIndex:0];
    
    return path;
}

+ (NSString *)userArchiverPath
{
    NSString *path = [[self documentPath] stringByAppendingPathComponent:kAppUserInfoPath];
    return path;
}

// 公共文件夹路径
+ (NSString *)commonPath
{
    NSString *path = [[AppUser documentPath] stringByAppendingPathComponent:kCommonDir];
    [self createFilePath:path];
    return path;
}

// 表情文件夹路径
+ (NSString *)emotionPath
{
    NSString *path = [[AppUser commonPath] stringByAppendingPathComponent:kEmotionDir];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if (![fileMgr fileExistsAtPath:path]) {
        NSError *error = nil;
        [fileMgr  createDirectoryAtPath:path
            withIntermediateDirectories:YES
                             attributes:nil
                                  error:&error];
        
        if (error) {
            DDLogCInfo(@"创建 commonPath 失败 %@", error);
        }
    }
    
    return path;
}

- (BOOL)persistence
{
    return [NSKeyedArchiver archiveRootObject:self toFile:[AppUser userArchiverPath]];
}

- (NSString *)userVideoPath
{
    NSString *path = [[self userDocumentPath] stringByAppendingPathComponent:@"shortVideo"];
    [AppUser createFilePath:path];
    return path;
}

// 用户路径
- (NSString *)userDocumentPath
{
    NSNumber *uid = (NSNumber *)self.userId;
    NSString *path = [[AppUser documentPath] stringByAppendingPathComponent:[uid stringValue]];
    [AppUser createFilePath:path];
    return path;
}

+ (BOOL)createFilePath:(NSString *)path
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if (![fileMgr fileExistsAtPath:path]) {
        NSError *error = nil;
        [fileMgr  createDirectoryAtPath:path
            withIntermediateDirectories:YES
                             attributes:nil
                                  error:&error];
        
        if (error) {
            return NO;
        }
    }
    return YES;
}

// 是否登录
- (BOOL)isLogin{
    if (self.sessionKey.length && self.secretKey.length > 0) {
        return YES;
    }
    return NO;
}

- (void)registerCookie
{
    //    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //    NSArray *keys = [NSArray arrayWithObjects:NSHTTPCookieDomain, NSHTTPCookieName, NSHTTPCookieValue, NSHTTPCookiePath, nil];
    //    NSArray *objects = [NSArray arrayWithObjects:@".renren.com", @"mt", [NSString stringWithFormat:@"%@", APPCONTEXT.currentUser.ticket], @"/", nil];
    //    NSDictionary *dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    //
    //    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:dict];
    //    [storage setCookie:cookie];
    //
    //    objects = [NSArray arrayWithObjects:@".renren.com", @"t", [NSString stringWithFormat:@"%@", APPCONTEXT.currentUser.web_ticket], @"/", nil];
    //    dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    //    cookie = [NSHTTPCookie cookieWithProperties:dict];
    //    [storage setCookie:cookie];
    DDLogInfo(@"Cookies :%@", [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
}

// 主用户注销 Cookie
- (void)clearCookie{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        [cookieJar deleteCookie:cookie];
    }
}

- (void)logout
{
    self.weiboId = @"";
    self.userId = @"";
    self.secretKey = @"";
    self.sessionKey = @"";
    [self persistence];
}

@end
