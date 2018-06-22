//
//  CJPhotoLibraryManager.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/6/4.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSUInteger, CJPhotoLibraryAuthorizationStatus) {
    CJPhotoLibraryAuthorizationStatusAuthorized,
    CJPhotoLibraryAuthorizationStatusDenied,
    CJPhotoLibraryAuthorizationStatusNotDetermined
};

@interface CJPhotoLibraryManager : NSObject


/**
 单利初始化

 @return 对象
 */
+(instancetype)sharePhotoLibraryManger;


/**
 相册授权状态

 @return status
 */
+(CJPhotoLibraryAuthorizationStatus)authorizationStatus;


/**
 请求授权。当CJPhotoLibraryAuthorizationStatus == CJPhotoLibraryAuthorizationStatusNotDetermined时候，调用该方法，弹出授权alter。

 @param handler 授权结果
 */
+(void)requestAuthorization:(void(^)(CJPhotoLibraryAuthorizationStatus status))handler;


-(void)addImage:(UIImage *)image toColletion:(NSString *)name;


-(PHCachingImageManager *)phCachingImageManager;
@end
