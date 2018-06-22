//
//  CJPhotoLibraryManager.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/6/4.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJPhotoLibraryManager.h"
#import <Photos/Photos.h>

@interface CJPhotoLibraryManager()

@property(nonatomic,strong) PHCachingImageManager *phCachingImageManger;

@end

@implementation CJPhotoLibraryManager


+(instancetype)sharePhotoLibraryManger {
    static CJPhotoLibraryManager *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[super allocWithZone:NULL] init];
    });
    return manger;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharePhotoLibraryManger];
}

+(CJPhotoLibraryAuthorizationStatus)authorizationStatus {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    return [self cj_statusFromePHPhotoLibStatus:status];
}
+(void)requestAuthorization:(void (^)(CJPhotoLibraryAuthorizationStatus))handler {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        handler([self cj_statusFromePHPhotoLibStatus:status]);
    }];
}

-(PHCachingImageManager *)phCachingImageManager {
    if (!_phCachingImageManger) {
        return [[PHCachingImageManager alloc] init];
    }
    return _phCachingImageManger;
}
#pragma mark --- private Method
+(CJPhotoLibraryAuthorizationStatus)cj_statusFromePHPhotoLibStatus:(PHAuthorizationStatus)status {
    CJPhotoLibraryAuthorizationStatus cj_status;
    switch (status) {
        case PHAuthorizationStatusDenied:
        case PHAuthorizationStatusRestricted:
            cj_status = CJPhotoLibraryAuthorizationStatusDenied;
        case PHAuthorizationStatusAuthorized:
            cj_status = CJPhotoLibraryAuthorizationStatusAuthorized;
        case PHAuthorizationStatusNotDetermined:
            cj_status = CJPhotoLibraryAuthorizationStatusNotDetermined;
        default:
            break;
    }
    return cj_status;
}
@end
