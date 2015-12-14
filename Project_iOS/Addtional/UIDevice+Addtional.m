//
//  UIDevice+Addtional.m
//  RenrenSixin
//
//  Created by TLB on 12-2-22.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "UIDevice+Addtional.h"
// for macaddress
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <net/if.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mount.h>
#import <mach/mach.h>
#import <AVFoundation/AVFoundation.h>


@implementation UIDevice (Addtional)

// 是否是iPhone
+ (BOOL)isiPhone
{
    UIDevice* device = [UIDevice currentDevice];
    
    if ([device.model isEqualToString:@"iPhone"]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 是否是iPad
+ (BOOL)isiPad
{
    UIDevice* device = [UIDevice currentDevice];
    
    if ([device.model isEqualToString:@"iPad"]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 是否是iTouch
+ (BOOL)isiPodTouch
{
    UIDevice* device = [UIDevice currentDevice];
    
    if ([device.model isEqualToString:@"iPod touch"]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 支持拔打电话
+ (BOOL)supportTelephone
{
    // 目前逻辑：iPhone支持电话，其余设备不支持 
    if ([UIDevice isiPhone]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 支持发送短信
+ (BOOL)supportSendSMS
{
    // 目前逻辑：iPhone支待短信，其余设备不支待
    if ([UIDevice isiPhone]) {
        return YES;
    }
    else {
        return NO;
    }
}

//// 支持发送邮件
//+ (BOOL)supportSendMail
//{
//    if ([MFMailComposeViewController canSendMail]) {
//        return YES;
//    }
//    else {
//        return NO;
//    }
//}

// 支持摄像头取景
+ (BOOL)supportCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 以全小写的形式返回设备名称
- (NSString*)modelNameLowerCase
{
    return [self.model lowercaseString];
}

// 系统版本，以float形式返回
- (CGFloat)systemVersionByFloat
{
    return [self.systemVersion floatValue];
}

// 是否高于IOS5.0版本
+ (BOOL)isHigherIOS5
{
    NSString *requestSysVer = @"5.0";
    NSString *currentSysVer = [[UIDevice currentDevice] systemVersion];

    if ([currentSysVer compare:requestSysVer options:NSNumericSearch] == NSOrderedAscending) {
        return NO;
    }

    return YES;
}

+ (BOOL)isHigherIOS6
{
    NSString *requestSysVer = @"6.0";
    NSString *currentSysVer = [[UIDevice currentDevice] systemVersion];

    if ([currentSysVer compare:requestSysVer options:NSNumericSearch] == NSOrderedAscending) {
        return NO;
    }

    return YES;
}

+ (BOOL)isHigherIOS7
{
    NSString *requestSysVer = @"7.0";
    NSString *currentSysVer = [[UIDevice currentDevice] systemVersion];

    if ([currentSysVer compare:requestSysVer options:NSNumericSearch] == NSOrderedAscending) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)isHigherIOS8
{
    NSString *requestSysVer = @"8.0";
    NSString *currentSysVer = [[UIDevice currentDevice] systemVersion];

    if ([currentSysVer compare:requestSysVer options:NSNumericSearch] == NSOrderedAscending) {
        return NO;
    }

    return YES;
}


+ (void)cameraAuthorzied:(cameraAuthorziedBlock)authorizedBlock notAuthorized:(cameraAuthorziedBlock)notAuthorizedlock
{
    if([UIDevice isHigherIOS7]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    if (authorizedBlock) {
                        authorizedBlock();
                    }
                }else{
                    if (notAuthorizedlock) {
                        notAuthorizedlock();
                    }
                }
            }];
        }else if (authStatus == AVAuthorizationStatusAuthorized){
            if (authorizedBlock) {
                authorizedBlock();
            }
        }else{
            if (notAuthorizedlock) {
                notAuthorizedlock();
            }
        }
    }else{
        if (authorizedBlock) {
            authorizedBlock();
        }
    }
}


// Return the local MAC addy
// Courtesy of FreeBSD hackers email list

- (NSString *) macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", 
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

// 内存信息
+ (unsigned int)freeMemory{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return vm_stat.free_count * pagesize;
}

+ (unsigned int)usedMemory{
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kerr == KERN_SUCCESS) ? info.resident_size : 0;
}

@end
