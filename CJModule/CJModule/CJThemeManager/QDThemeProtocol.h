//
//  QDThemeProtocol.h
//  qmuidemo
//
//  Created by MoLice on 2017/5/9.
//  Copyright © 2017年 QMUI Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QMUIKit.h>

#pragma mark - Colors

#define UIColorGray1 UIColorMake(53, 60, 70)
#define UIColorGray2 UIColorMake(73, 80, 90)
#define UIColorGray3 UIColorMake(93, 100, 110)
#define UIColorGray4 UIColorMake(113, 120, 130)
#define UIColorGray5 UIColorMake(133, 140, 150)
#define UIColorGray6 UIColorMake(153, 160, 170)
#define UIColorGray7 UIColorMake(173, 180, 190)
#define UIColorGray8 UIColorMake(196, 200, 208)
#define UIColorGray9 UIColorMake(216, 220, 228)

#define UIColorTheme1 UIColorMake(239, 83, 98) // Grapefruit
#define UIColorTheme2 UIColorMake(254, 109, 75) // Bittersweet
#define UIColorTheme3 UIColorMake(255, 207, 71) // Sunflower
#define UIColorTheme4 UIColorMake(159, 214, 97) // Grass
#define UIColorTheme5 UIColorMake(63, 208, 173) // Mint
#define UIColorTheme6 UIColorMake(49, 189, 243) // Aqua
#define UIColorTheme7 UIColorMake(90, 154, 239) // Blue Jeans
#define UIColorTheme8 UIColorMake(172, 143, 239) // Lavender
#define UIColorTheme9 UIColorMake(238, 133, 193) // Pink Rose

/// 所有主题均应实现这个协议，规定了 QMUI Demo 里常用的几个关键外观属性
@protocol QDThemeProtocol <QMUIConfigurationTemplateProtocol>

@required

- (UIColor *)themeTintColor;
- (UIColor *)themeListTextColor;
- (UIColor *)themeCodeColor;
- (UIColor *)themeGridItemTintColor;

- (NSString *)themeName;

@end


/// 所有能响应主题变化的对象均应实现这个协议，目前主要用于 QDCommonViewController 及 QDCommonTableViewController
@protocol QDChangingThemeDelegate <NSObject>

@required

- (void)themeBeforeChanged:(NSObject<QDThemeProtocol> *)themeBeforeChanged afterChanged:(NSObject<QDThemeProtocol> *)themeAfterChanged;

@end
