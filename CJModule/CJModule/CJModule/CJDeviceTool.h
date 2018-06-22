//
//  CJDeviceTool.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/21.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJDeviceTool : NSObject


/**
 获取设备类型

 @return 类型
 
 型号网站:
 http://theiphonewiki.com/wiki/IPhone
 http://theiphonewiki.com/wiki/IPad
 */
+(NSString *)getDeviceType;

/**
 是否是ipad

 @return yes or no
 */
+(BOOL)isPad;

/**
 是否是模拟器

 @return yes or no
 */
+(BOOL)isSimulator;

/**
 获取wifi的ip地址

 @return ip
 */
+(NSString *)IPAddressWithWifi;


/**
 获取蜂窝数据的ip地址

 @return ip
 */
+(NSString *)IPAddressWithCell;

/**
 屏幕缩放比例

 @return scle
 */
+(CGFloat)screenScale;

/// 系统版本号
+(NSString *)systemVersion;


/**
 旋转屏幕到指定方向。注意：旋转成功的前提是当前页面支持屏幕旋转（项目配置、AppDelegate配置、window的rootViewController配置或者modal出当前页面）。

 @param deviceOrientation 设备方向方向。以home键为参考点
 */
+(void)rotationToDeviceOrientation:(UIDeviceOrientation)deviceOrientation;
@end
