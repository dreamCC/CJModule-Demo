//
//  UIView+CJCategory.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/23.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CJFrame)

/// x
@property (nonatomic, assign) CGFloat cj_x;

/// y
@property (nonatomic, assign) CGFloat cj_y;

/// 宽
@property (nonatomic, assign) CGFloat cj_w;

/// 高
@property (nonatomic, assign) CGFloat cj_h;

/// centerX
@property (nonatomic, assign) CGFloat cj_centerX;

/// centerY
@property (nonatomic, assign) CGFloat cj_centerY;


@end

@interface UIView (CJEffectView)


/**
 给UIView增加毛玻璃效果，默认样式=UIBlurEffectStyleLight

 @return self
 */
-(__kindof UIView *)cj_viewWithBlurVisualEffect;


/**
 给UIView增加毛玻璃效果

 @param blurEffectStyle 毛玻璃效果样式
 @return self
 */
-(__kindof UIView *)cj_viewWithBlurVisualEffectStyle:(UIBlurEffectStyle)blurEffectStyle;


/**
 给UIView增加Vibrancy效果，一般需要搭配SubView使用。

 @param subView 需要增加视觉效果的控件
 @return self
 */
-(__kindof UIView *)cj_viewWithVibrancyVisualSubView:(__kindof UIView *)subView;


/**
 给UIView增加Vibrancy效果，一般需要搭配SubView使用。

 @param blurEffectStyle blurStyle
 @param subView 需要增加视觉效果的控件
 @return self
 */
-(__kindof UIView *)cj_viewWithVibrancyVisualEffectStyle:(UIBlurEffectStyle)blurEffectStyle
                                                 subView:(__kindof UIView *)subView;

@end

