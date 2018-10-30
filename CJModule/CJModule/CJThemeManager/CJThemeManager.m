//
//  CJThemeManager.m
//  CJModule
//
//  Created by 仁和Mac on 2018/9/15.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJThemeManager.h"

NSString *const kThemeChangeNotification = @"com.kThemeChangeNotification.cn";
NSString *const kCurrentTheme = @"com.kCurrentTheme.cn";
@interface CJThemeManager()

@end

static CJThemeManager *themeManager;
@implementation CJThemeManager


+(instancetype)shareThemeManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        themeManager = [[super allocWithZone:NULL] init];
    });
    return themeManager;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareThemeManager];
}


-(void)setCurrentTheme:(NSObject<QDThemeProtocol> *)currentTheme {
    _currentTheme = currentTheme;
    if ([currentTheme shouldApplyTemplateAutomatically]) {
        [currentTheme applyConfigurationTemplate];
        
        NSDictionary *userInfo = @{@"theme":currentTheme};
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeChangeNotification object:nil userInfo:userInfo];
        [[NSUserDefaults standardUserDefaults] setObject:currentTheme.class forKey:kCurrentTheme];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


@end
