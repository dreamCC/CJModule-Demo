//
//  UIVisualEffectView+CJCategory.h
//  CJModule
//
//  Created by 仁和Mac on 2019/1/3.
//  Copyright © 2019年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIVisualEffectView (CJCategory)


/**
 生成一个毛玻璃效果的effectView。其blurStyle = UIBlurEffectStyleLight

 @return 毛玻璃效果的View
 */
+(UIVisualEffectView *)cj_blurVisualEffectView;


/**
 通过UIBlurEffectStyle生成一个毛玻璃效果的effectView

 @param blurStyle blurStyle
 @return 毛玻璃效果effectView
 */
+(UIVisualEffectView *)cj_blurVisualEffectViewBlurStyle:(UIBlurEffectStyle)blurStyle;


/**
 生成一个vibrancyEffectView
 
 @param view 子控件
 @return 毛玻璃效果
 */
+(UIVisualEffectView *)cj_vibrancyVisualEffectViewWithSubView:(__kindof UIView *)view;



/**
 生成一个vibrancyEffectView

 @param blurStyle blurStyle
 @param view 子控件
 @return 毛玻璃效果
 */
+(UIVisualEffectView *)cj_vibrancyVisualEffectViewBlurStyle:(UIBlurEffectStyle)blurStyle subView:(__kindof UIView *)view;

@end

NS_ASSUME_NONNULL_END
