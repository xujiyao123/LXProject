//
//  AppUser.h
//  Project_iOS
//
//  Created by 刘旭 on 16/1/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUser : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *sessionKey;
@property (nonatomic, copy) NSString *secretKey;
@property (nonatomic, copy) NSString *weiboId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *imName;
@property (nonatomic, copy) NSString *imSecret;
@property (nonatomic, copy) NSString *password;

+ (NSString *)documentPath;
+ (NSString *)commonPath;
+ (NSString *)emotionPath;

- (BOOL)persistence;
- (BOOL)isLogin;

- (NSString *)userDocumentPath;
- (void)registerCookie;
- (void)clearCookie;
- (void)logout;

+ (AppUser *)wakeUpUser;
+ (AppUser *)makeAppUser:(NSDictionary *)dict;
@end
