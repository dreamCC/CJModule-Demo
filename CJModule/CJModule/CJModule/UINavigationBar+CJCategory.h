//
//  UINavigationBar+CJCategory.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (CJCategory)

/// 设置背景颜色
-(void)cj_barBackgroudColor:(UIColor *)color;

/// item的透明度
-(void)cj_navigationItemAlpha:(CGFloat)alpha;

/// 恢复
-(void)cj_reset;
@end
