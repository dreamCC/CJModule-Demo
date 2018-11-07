//
//  CJDefine.h
//  CommonProject
//
//  Created by 仁和Mac on 2017/3/22.
//  Copyright © 2017年 zhucj. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

/******************** 日志 **********************************************/

#if DEBUG
    //#define CJLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
    #define CJLog(...) [[QMUILogger sharedInstance] printLogWithFile:__FILE__ line:__LINE__ func:__FUNCTION__ logItem:[QMUILogItem logItemWithLevel:QMUILogLevelDefault name:@"log" logString:__VA_ARGS__]]
    #define CJLogInfo(...) [[QMUILogger sharedInstance] printLogWithFile:__FILE__ line:__LINE__ func:__FUNCTION__ logItem:[QMUILogItem logItemWithLevel:QMUILogLevelInfo name:@"info" logString:__VA_ARGS__]]
    #define CJLogWarn(...) [[QMUILogger sharedInstance] printLogWithFile:__FILE__ line:__LINE__ func:__FUNCTION__ logItem:[QMUILogItem logItemWithLevel:QMUILogLevelWarn name:@"warn" logString:__VA_ARGS__]]
#else
    #define CJLog(...)
    #define CJLogInfo(...)
    #define CJLogWarn(...)
#endif

/******************** 尺寸 ***********************************************/
#define kScreen_width  ([UIScreen mainScreen].bounds.size.width)
#define kScreen_height ([UIScreen mainScreen].bounds.size.height)
#define kIs_iphoneX    (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f)
#define kTop_guid      (Is_iPhoneX ? 88.f : 64.f)
#define kTop_add       (Is_iPhoneX ? 24.f : 0.f)
#define kBottom_add    (Is_iPhoneX ? 34.f : 0.f)

/******************** 颜色 ***********************************************/
#define CJRGB(r,g,b)          [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define CJRGB_Hex(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                             green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                              blue:((float)(rgbValue & 0xFF))/255.0 \
                                             alpha:1.0]
#define CJRandomColor         CJRGB(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256)) 

/******************** weakself & strongSelf *******************************/
#define CJWeak_self(weakSelf)       __weak __typeof(&*self) weakSelf = self;
#define CJStrong_self(strongSelf)   __strong __typeof(&*weakSelf) strongSelf = weakSelf;

/******************** NotificationCenter **********************************/
#define CJNotificationCenter   [NSNotificationCenter defaultCenter]



/*
 #pragma clang diagnostic push
 
 #pragma clang diagnostic ignored "-Wdeprecated-declarations"  -Wdeprecated-declarations 表示忽略那种警告。
 
 这里写出现警告的代码
 
 #pragma clang diagnostic pop
 */
/******************** Methods use c **********************************/
CG_INLINE void CJSwizzleMethod(Class cls, SEL orgSel, SEL swzSel) {
    Method orgMethod = class_getInstanceMethod(cls, orgSel);
    Method swzMethod = class_getInstanceMethod(cls, swzSel);
    IMP orgImp = method_getImplementation(orgMethod);
    IMP swzImp = method_getImplementation(swzMethod);
    BOOL isAdd = class_addMethod(cls, orgSel, swzImp, method_getTypeEncoding(swzMethod));
    if (isAdd) {
        class_replaceMethod(cls, swzSel, orgImp, method_getTypeEncoding(orgMethod));
    }else {
        method_exchangeImplementations(orgMethod, swzMethod);
    }
}








