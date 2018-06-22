//
//  CJApplicationInfo.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/5/31.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJApplicationInfo.h"

@implementation CJApplicationInfo

+(instancetype)shareApplicationInfo {
    static CJApplicationInfo *appInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appInfo = [[CJApplicationInfo alloc] init];
    });
    return appInfo;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        [self didInitializelInfo];
    }
    return self;
}

-(void)didInitializelInfo {
    NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
    _infoDictionary       = infoDic;
    
    _appName  = infoDic[@"CFBundleName"];
    _bundleID = infoDic[@"CFBundleIdentifier"];
    _version  = infoDic[@"CFBundleShortVersionString"];
    
    _photoLibraryUsageDescription               = infoDic[@"NSPhotoLibraryUsageDescription"];
    _photoLibraryAddUsageDescription            = infoDic[@"NSPhotoLibraryAddUsageDescription"];
    _cameraUsageDescription                     = infoDic[@"NSCameraUsageDescription"];
    _microphoneUsageDescription                 = infoDic[@"NSMicrophoneUsageDescription"];
    _locationWhenInUseUsageDescription          = infoDic[@"NSLocationWhenInUseUsageDescription"];
    _locationAlwaysAndWhenInUseUsageDescription = infoDic[@"NSLocationAlwaysAndWhenInUseUsageDescription"];
    
}

@end
