//
//  CJThemeManager.h
//  CJModule
//
//  Created by 仁和Mac on 2018/9/15.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QDThemeProtocol.h"

extern NSString *const kThemeChangeNotification;
extern NSString *const kCurrentTheme;
@interface CJThemeManager : NSObject

@property(nonatomic, strong) NSObject<QDThemeProtocol> *currentTheme;

+(instancetype)shareThemeManager;

@end
