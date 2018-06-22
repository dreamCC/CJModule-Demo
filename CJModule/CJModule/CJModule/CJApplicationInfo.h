//
//  CJApplicationInfo.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/5/31.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJApplicationInfo : NSObject

/// infoPlist对于的字典
@property(nonatomic, strong ,readonly) NSDictionary<NSString *,id> *infoDictionary;

/// app的名字
@property(nonatomic, strong, readonly) NSString *appName;

/// app版本号
@property(nonatomic, strong, readonly) NSString *version;

/// app的bundleID
@property(nonatomic, strong, readonly) NSString *bundleID;

/// 相册访问提示语
@property(nonatomic, strong, readonly) NSString *photoLibraryUsageDescription;

/// 相册添加图片提示语
@property(nonatomic, strong, readonly) NSString *photoLibraryAddUsageDescription;

/// 摄像头访问提示语
@property(nonatomic, strong, readonly) NSString *cameraUsageDescription;

/// 麦克风访问提示语
@property(nonatomic, strong, readonly) NSString *microphoneUsageDescription;

/// 试用期间定位提示语
@property(nonatomic, strong, readonly) NSString *locationWhenInUseUsageDescription;

/// 始终允许定位提示语
@property(nonatomic, strong, readonly) NSString *locationAlwaysAndWhenInUseUsageDescription;


/**
 初始化appinfo

 @return CJApplicationInfo对象
 */
+(instancetype)shareApplicationInfo;

@end
