//
//  UIDevice+UIDeviceExt.m
//  RenrenCore
//
//  Created by SunYu  on 11-11-1.
//  Copyright (c) 2011年 www.renren.com. All rights reserved.
//

#import "UIDevice+UIDeviceExt.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mount.h>
#import <mach/mach.h>
#import <arpa/inet.h>
#import "NSDictionary_JSONExtensions.h"

@implementation UIDevice (IdentifierAddition)

// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
+ (NSString *)macAddress{
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

+ (BOOL)isDeviceiPad{
    BOOL iPadDevice = NO;
    
    // Is userInterfaceIdiom available?
    if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)])
    {
        // Is device an iPad?
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            iPadDevice = YES;
    }
    
    return iPadDevice;
}

+ (NSString *) machineModel{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *machineModel = [NSString stringWithUTF8String:machine];
    free(machine);
    return machineModel;
}

+ (NSString *) machineModelName{
    NSString *machineModel = [UIDevice machineModel];
    
    // iPhone
    if ([machineModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([machineModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([machineModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([machineModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([machineModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([machineModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    
    // iPod
    if ([machineModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([machineModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([machineModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([machineModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    
    // iPad
    if ([machineModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([machineModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([machineModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([machineModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    
    if ([machineModel isEqualToString:@"iPad3,1"])      return @"iPad-3G (WiFi)";
    if ([machineModel isEqualToString:@"iPad3,2"])      return @"iPad-3G (4G)";
    if ([machineModel isEqualToString:@"iPad3,3"])      return @"iPad-3G (4G)";
    
    // Simulator
    if ([machineModel isEqualToString:@"i386"])         return @"Simulator";
    if ([machineModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    return machineModel;
}

+ (NSString *)prettyMachineModelName{
    NSString *machineModel = [UIDevice machineModel];

    // iPhone
    if ([machineModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([machineModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([machineModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([machineModel isEqualToString:@"iPhone3,1"]
        || [machineModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([machineModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([machineModel isEqualToString:@"iPhone5,1"]
        || [machineModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    
    if ([machineModel hasPrefix:@"iPhone"]) {
        return @"iPhone";
    }
    
    // iPod
    if ([machineModel isEqualToString:@"iPod1,1"])      return @"iPod 1";
    if ([machineModel isEqualToString:@"iPod2,1"])      return @"iPod 2";
    if ([machineModel isEqualToString:@"iPod3,1"])      return @"iPod 3";
    if ([machineModel isEqualToString:@"iPod4,1"])      return @"iPod 4";
    if ([machineModel isEqualToString:@"iPod5,1"])      return @"iPod 5";
    
    if ([machineModel hasPrefix:@"iPod"]) {
        return @"iPod";
    }
    
    // iPad
    if ([machineModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([machineModel isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([machineModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([machineModel isEqualToString:@"iPad2,3"])      return @"iPad 2";
    
    if ([machineModel isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([machineModel isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([machineModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([machineModel isEqualToString:@"iPad3,4"])      return @"iPad 4";
    
    return machineModel;
}

// 是否显示雾面效果
+ (BOOL)canShowBlurEffect{
    NSString *device = [[UIDevice machineModel] lowercaseString];
    // 4s
    //    if ([device rangeOfString:@"iphone4,1"].length > 0) {
    //        return YES;
    //    }
    if ([device rangeOfString:@"iphone5"].length > 0) {
        return YES;
    }
    if ([device rangeOfString:@"iphone6"].length > 0) {
        return YES;
    }
    if ([device rangeOfString:@"iphone5,2"].length > 0) {
        return YES;
    }
    //    if ([device rangeOfString:@"ipod4"].length > 0) {
    //        return 1;
    //    }
    if ([device rangeOfString:@"ipod5"].length > 0) {
        return YES;
    }
    return NO;
}

// 是否能发短信 不准确 清产品确认该问题
+ (BOOL) canDeviceSendMessage{
    NSString *machineModelName = [UIDevice machineModelName];
    if ([machineModelName hasPrefix:@"iPhone"]) {
        return YES;
    }
    if ([machineModelName hasPrefix:@"iPod"] || [machineModelName hasPrefix:@"Simulator"]) {
        return NO;
    }
    if ([machineModelName hasPrefix:@"iPad"]) {
        if ([machineModelName rangeOfString:@"CDMA"].location != NSNotFound ||
            [machineModelName rangeOfString:@"GSM"].location != NSNotFound ||
            [machineModelName rangeOfString:@"3G"].location != NSNotFound ||
            [machineModelName rangeOfString:@"4G"].location != NSNotFound) {
            return YES;
        }else {
            return NO;
        }
    }
    return YES;
}
// 对低端机型的判断
+ (BOOL)isLowLevelMachine{
    NSString *machineModel = [UIDevice machineModelName];
    
    NSArray *lowLevel = [NSArray arrayWithObjects:@"iPhone 1G", @"iPhone 3G", @"iPhone 3GS",
                         @"iPod Touch 1G", @"iPod Touch 2G", @"iPod Touch 3G",
                         @"iPad",
                         nil];
    
    for (NSString *lower in lowLevel) {
        if ([machineModel isEqualToString:lower]) {
            return YES;
        }
    }
    
    return NO;
}

+(NSNumber *)freeSpace{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/private/var", &buf) >= 0){
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }

    return [NSNumber numberWithLongLong:freespace];
}

+(NSNumber *)totalSpace{
	struct statfs buf;	
	long long totalspace = -1;
	if(statfs("/private/var", &buf) >= 0){
		totalspace = (long long)buf.f_bsize * buf.f_blocks;
	} 
	return [NSNumber numberWithLongLong:totalspace];
}

// 获取运营商信息
+ (NSString *)carrierName{
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netInfo subscriberCellularProvider];

    if (carrier == nil) {
        return nil;
    }
    NSString *carrierName = [carrier carrierName];
//    NSString *mcc = [carrier mobileCountryCode];
//    NSString *mnc = [carrier mobileNetworkCode];
//    DDLogInfo(@"Carrier Name: %@ mcc: %@ mnc: %@", carrierName, mcc, mnc);
    return carrierName;
}

+ (NSString *)carrierCode{
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netInfo subscriberCellularProvider];

    if (carrier == nil) {
        return nil;
    }
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
    NSString *carrierCode = [NSString stringWithFormat:@"%@%@", mcc, mnc];
    return carrierCode;
}
+ (CGFloat) getBatteryValue{
    UIDevice* device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    return device.batteryLevel;
}
+ (NSInteger) getBatteryState{
    UIDevice* device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    return device.batteryState;
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
+ (CGSize)screenSize{
    CGRect rect = [UIScreen mainScreen].bounds;
    return CGSizeMake(rect.size.width, rect.size.height - PHONE_STATUSBAR_HEIGHT);
}
+ (CGFloat)screenWidth{
    return [UIDevice screenSize].width;
}
+ (CGFloat)screenHeight{
    return [UIDevice screenSize].height;
}
+ (CGFloat)mainScreenHeight
{
    CGRect rect = [UIScreen mainScreen].bounds;
    return rect.size.height;
}

+ (BOOL)isRetina4inch{
    return (SCREEN_HEIGHT == 480);
}

+ (NSDictionary *)externalIPInfo:(NSString *)url{
    if (!url) {
        return nil;
    }
    // 1. 获取外网IP
    NSString *externUrl = [NSString stringWithFormat:@"http://%@/ip_json.php",url];
    NSURLRequest *IPRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:externUrl]];
    NSHTTPURLResponse *IPResponse = nil;
    NSError *IPError = nil;
    NSData *IPData = [NSURLConnection sendSynchronousRequest:IPRequest
                                           returningResponse:&IPResponse
                                                       error:&IPError];
    NSString *IPStr = [[NSString alloc] initWithData:IPData encoding:NSUTF8StringEncoding];
    NSLog(@"External IP Addr: %@", IPStr);
    
    // 解析 Sessid
    NSString *sessionID = nil;
    NSString *cookieValue = [IPResponse.allHeaderFields objectForKey:@"Set-Cookie"];
    //PHPSESSID=hepesbvoulnjqlsftjlvm2gv8q0odf07; path=/
    NSRange sessionIDRange = [cookieValue rangeOfString:@"(?<=PHPSESSID=)\\w+" options:NSRegularExpressionSearch];
    if (sessionIDRange.location > cookieValue.length ||
        sessionIDRange.location + sessionIDRange.length > cookieValue.length ||
        sessionIDRange.length > cookieValue.length) {
        return nil;
    }
    sessionID = [cookieValue substringWithRange:sessionIDRange];
    if (sessionID == nil || sessionID.length <= 0) {
        return nil;
    }
    
    // 2. 构造发起DNS查询接口
    NSString *DNSQueryHostname = [NSString stringWithFormat:@"%ld.%@-%@-%@.%@",
                                  (long)[[NSDate date] timeIntervalSince1970],
                                  @"111111",
                                  IPStr,
                                  sessionID
                                  ,url];
    NSArray *DNSArray = [UIDevice getDNSByHostname:DNSQueryHostname];
    if (DNSArray == nil || ![DNSArray containsObject:@"127.0.0.1"]) {
        // DNS 解析出错
        return nil;
    }
    
    // 3. 获取DNS地址及DNS是否用错等信息
    NSString *DNSQueryURL = [NSString stringWithFormat:@"http://%@/client_check_dns_json.php",url];
    NSURLRequest *DNSRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:DNSQueryURL]];
    NSHTTPURLResponse *DNSQueryResponse = nil;
    NSError *DNSQueryError = nil;
    NSData *DNSQueryData = [NSURLConnection sendSynchronousRequest:DNSRequest
                                                 returningResponse:&DNSQueryResponse
                                                             error:&DNSQueryError];
    NSString *DNSQueryStr = [[NSString alloc] initWithData:DNSQueryData encoding:NSUTF8StringEncoding];
    NSDictionary *DNSQueryResult = [NSDictionary dictionaryWithJSONString:DNSQueryStr error:NULL];
    return DNSQueryResult;
}

+ (NSArray *)getDNSByHostname:(NSString *)hostname{
    if (hostname == nil || hostname.length <= 0) {
        hostname = @"apple.com";
    }
    
    Boolean result = FALSE;
    CFHostRef hostRef = NULL;
    CFArrayRef addresses = NULL;
    hostRef = CFHostCreateWithName(kCFAllocatorDefault, (__bridge CFStringRef)hostname);
    if (hostRef) {
        result = CFHostStartInfoResolution(hostRef, kCFHostAddresses, NULL);
        if (result == TRUE) {
            addresses = CFHostGetAddressing(hostRef, &result);
        }
    }
    
    NSMutableArray *DNSArray = [NSMutableArray arrayWithCapacity:3];
    if (result == TRUE) {
        for(int i = 0; i < CFArrayGetCount(addresses); i++){
            struct sockaddr_in* remoteAddr;
            CFDataRef saData = (CFDataRef)CFArrayGetValueAtIndex(addresses, i);
            remoteAddr = (struct sockaddr_in*)CFDataGetBytePtr(saData);
            
            if(remoteAddr != NULL){
                NSString *strDNS =[NSString stringWithCString:inet_ntoa(remoteAddr->sin_addr) encoding:NSASCIIStringEncoding];
              //  NSLog(@"RESOLVED %d:<%@>", i, strDNS);
                [DNSArray addObject:strDNS];
            }
        }
        
    } else {
        return nil;
    }
    
    return DNSArray;
}

+ (BOOL)isJailBroken
{
    struct stat s;
    
    int result = stat("/private/var/lib/apt/", &s);
    if (result == 0) {
        return YES;
    }
    
    result = stat("/Library/MobileSubstrate/MobileSubstrate.dylib", &s);
    if (result == 0) {
        return YES;
    }
    
    result = stat("/var/cache/apt", &s);
    if (result == 0) {
        return YES;
    }
    
    result = stat("/etc/apt", &s);
    if (result == 0) {
        return YES;
    }
    
    return NO;
}


@end
