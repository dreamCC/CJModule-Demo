//
//  CJDeviceTool.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/21.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJDeviceTool.h"
#import <mach/mach.h>
#import <sys/sysctl.h>
#import <sys/types.h>
#import <UIKit/UIKit.h>
#import <arpa/inet.h>
#import <ifaddrs.h>


@implementation CJDeviceTool

+(NSString *)getDeviceType {
    // 执行一次就可以
    static NSString * deviceType;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = (char*)malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        NSString *internalName = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
        free(machine);
        deviceType = [self realTypeFromInternalName:internalName];
    });

    return deviceType;
}



+(BOOL)isPad {
    static BOOL isPad = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return isPad;
}

+(BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}


+(NSString *)IPAddressWithWifi {
    return [self ipAddressWithIfaName:@"en0"];
}

+(NSString *)IPAddressWithCell {
    return [self ipAddressWithIfaName:@"pdp_ip0"];
}

+(CGFloat)screenScale {
    return [UIScreen mainScreen].scale;
    
}

+(NSString *)systemVersion {
    return [UIDevice currentDevice].systemVersion;
}

+(void)rotationToDeviceOrientation:(UIDeviceOrientation)deviceOrientation {
    UIDevice *device = [UIDevice currentDevice];
    
    if (device.orientation == deviceOrientation) return;
    if (![device respondsToSelector:@selector(setOrientation:)]) return;
    SEL selector = NSSelectorFromString(@"setOrientation:");
    // NSInvocation 是通过签名NSMethodSignature 初始化的。NSMethodSignature 初始化有两种方法。 [UIDevice instanceMethodSignatureForSelector:selector];或者下面这个方法。
    NSMethodSignature *signature = [device methodSignatureForSelector:selector];
    NSInvocation *invocation     = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:device];
    [invocation setSelector:selector];
    // invocation有两个隐藏参数，所以这里需要从 2 开始设置。
    [invocation setArgument:&deviceOrientation atIndex:2];
    [invocation invoke];
}


#pragma mark -- private
+(NSString *)ipAddressWithIfaName:(NSString *)name {
    if (name.length == 0) return nil;
    NSString *address = nil;
    struct ifaddrs *addrs = NULL;
    if (getifaddrs(&addrs) == 0) {
        struct ifaddrs *addr = addrs;
        while (addr) {
            if ([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:name]) {
                sa_family_t family = addr->ifa_addr->sa_family;
                switch (family) {
                    case AF_INET: { // IPv4
                        char str[INET_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in *)addr->ifa_addr)->sin_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    } break;
                        
                    case AF_INET6: { // IPv6
                        char str[INET6_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in6 *)addr->ifa_addr)->sin6_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    }
                        
                    default: break;
                }
                if (address) break;
            }
            addr = addr->ifa_next;
        }
    }
    freeifaddrs(addrs);
    return address;
}

+(NSString *)realTypeFromInternalName:(NSString *)internalName
{
    if ([internalName isEqualToString:@"i386"])        return@"Simulator";
    if ([internalName isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([internalName isEqualToString:@"iPhone1,1"])   return@"iPhone 1";
    if ([internalName isEqualToString:@"iPhone1,2"])   return@"iPhone 3";
    if ([internalName isEqualToString:@"iPhone2,1"])   return@"iPhone 3S";
    if ([internalName isEqualToString:@"iPhone3,1"] || [internalName isEqualToString:@"iPhone3,2"])   return@"iPhone 4";
    if ([internalName isEqualToString:@"iPhone4,1"])   return@"iPhone 4S";
    if ([internalName isEqualToString:@"iPhone5,1"] || [internalName isEqualToString:@"iPhone5,2"])   return @"iPhone 5";
    if ([internalName isEqualToString:@"iPhone5,3"] || [internalName isEqualToString:@"iPhone5,4"])   return @"iPhone 5C";
    if ([internalName isEqualToString:@"iPhone6,1"] || [internalName isEqualToString:@"iPhone6,2"])   return @"iPhone 5S";
    if ([internalName isEqualToString:@"iPhone7,2"])   return @"iPhone 6";
    if ([internalName isEqualToString:@"iPhone7,1"])   return @"iPhone 6 plus";
    if ([internalName isEqualToString:@"iPhone8,1"])   return @"iPhone 6s";
    if ([internalName isEqualToString:@"iPhone8,2"])   return @"iPhone 6s plus";
    if ([internalName isEqualToString:@"iPhone8,4"])   return @"iPhone SE";
    if ([internalName isEqualToString:@"iPhone9,1"] || [internalName isEqualToString:@"iPhone9,3"])   return @"iPhone 7";
    if ([internalName isEqualToString:@"iPhone9,2"] || [internalName isEqualToString:@"iPhone9,4"])   return @"iPhone 7 plus";
    if ([internalName isEqualToString:@"iPhone10,1"] || [internalName isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([internalName isEqualToString:@"iPhone10,2"] || [internalName isEqualToString:@"iPhone10,5"])   return @"iPhone 8 plus";
    if ([internalName isEqualToString:@"iPhone10,3"] || [internalName isEqualToString:@"iPhone10,6"])   return @"iPhoneX";
    
    if ([internalName isEqualToString:@"iPod1,1"])     return@"iPod Touch 1";
    if ([internalName isEqualToString:@"iPod2,1"])     return@"iPod Touch 2";
    if ([internalName isEqualToString:@"iPod3,1"])     return@"iPod Touch 3";
    if ([internalName isEqualToString:@"iPod4,1"])     return@"iPod Touch 4";
    if ([internalName isEqualToString:@"iPod5,1"])     return@"iPod Touch 5";
    
    if ([internalName isEqualToString:@"iPad1,1"])     return@"iPad 1";
    if ([internalName isEqualToString:@"iPad2,1"] || [internalName isEqualToString:@"iPad2,2"] || [internalName isEqualToString:@"iPad2,3"] || [internalName isEqualToString:@"iPad2,4"])     return@"iPad 2";
    if ([internalName isEqualToString:@"iPad2,5"] || [internalName isEqualToString:@"iPad2,6"] || [internalName isEqualToString:@"iPad2,7"] )      return @"iPad Mini";
    if ([internalName isEqualToString:@"iPad3,1"] || [internalName isEqualToString:@"iPad3,2"] || [internalName isEqualToString:@"iPad3,3"] || [internalName isEqualToString:@"iPad3,4"] || [internalName isEqualToString:@"iPad3,5"] || [internalName isEqualToString:@"iPad3,6"])      return @"iPad 3";
    
    return internalName;
}

@end
