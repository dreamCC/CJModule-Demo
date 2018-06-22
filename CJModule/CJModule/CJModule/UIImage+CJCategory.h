//
//  UIImage+CJCategory.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/6.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CJCategory)


/**
 通过颜色来获取图片

 @param color 颜色
 @return 图片 
 */
+(UIImage *)cj_imageWithColor:(UIColor *)color;


/**
 通过颜色来获取固定尺寸的图片

 @param color 颜色
 @param size 尺寸
 @return 图片
 */
+(UIImage *)cj_imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 通过颜色来获取固定尺寸的图片，带圆角

 @param color 颜色
 @param size 尺寸
 @param corner 圆角
 @return 图片
 */
+(UIImage *)cj_imageWithColor:(UIColor *)color size:(CGSize)size corner:(CGFloat)corner;


/**
 通过view来生成一张图片，类似截图。

 @param view view
 @return 图片
 */
+(UIImage *)cj_imageWithView:(UIView *)view;


/**
 通过View生成一张图片，采用的是系统方法。

 @param view view
 @param afterScreenUpdates afterScreenUpdates
 @return 图片
 */
+(UIImage *)cj_imageWithView:(UIView *)view afterScreenUpdates:(BOOL)afterScreenUpdates;


/**
 图片像素大小

 @return 像素大小
 */
-(CGSize)cj_pixelSize;

/**
 将图片置灰，主要通过重绘，将颜色空间设置为CGColorSpaceCreateDeviceGray()

 @return 灰度图片
 */
-(UIImage *)cj_grayImage;



/**
 生成一张带透明度的图片

 @param alpha 透明度
 @return 透明度图片
 */
-(UIImage *)cj_imageWithAlpha:(CGFloat)alpha;

/**
 通过blendMode的形式来改变图片颜色。通过，kCGBlendModeOverlay + kCGBlendModeDestinationIn

 @param tintColor 颜色
 @return image
 */
-(UIImage *)cj_imageWithTintColor:(UIColor *)tintColor;


/**
 通过blendModes的形式改变图片颜色

 @param tintColor 颜色
 @param blendModes blendModes
 @return image
 */
-(UIImage *)cj_imageWithTintColor:(UIColor *)tintColor blendModes:(NSArray *)blendModes;


/**
 图片上面添加一个新的图片

 @param aboveImage aboveImage
 @param point  位置
 @return 新图片
 */
-(UIImage *)cj_imageWithAboveImage:(UIImage *)aboveImage point:(CGPoint)point;


/**
 给图片切圆角

 @param cornerRadius 圆角大小
 @return 处理后图片
 */
-(UIImage *)cj_imageWithCornerRadius:(CGFloat)cornerRadius;


/**
 给图片设置圆角，同时添加边框

 @param cornerRadius 圆角
 @param boardWide 边框宽度
 @param boardColor 边框颜色
 @return 处理后图片
 */
-(UIImage *)cj_imageWithCornerRadius:(CGFloat)cornerRadius boardWide:(CGFloat)boardWide boardColor:(UIColor *)boardColor;
@end



