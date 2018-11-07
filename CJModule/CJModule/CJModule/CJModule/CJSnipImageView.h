//
//  CJSnipImageView.h
//  CJModule
//
//  Created by 仁和Mac on 2018/7/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMUIZoomImageView.h>
#import "CJCropBoxView.h"


@interface CJSnipImageView : UIView

/// 加载背景图片，详情使用请参考QMUIZoomImageView
@property(nonatomic, weak) QMUIZoomImageView *zoomImageView;

/// 剪切框
@property(nonatomic, weak)  CJCropBoxView *cropBoxView;

/// cropBoxView的左右边界。 默认，CJSnipImageView宽度的1/4。
@property(nonatomic, assign)  CGFloat cropBoxMargin;

/// cropBoxView的尺寸。默认，由上面属性控制。
@property(nonatomic, assign)  CGSize cropBoxSize;

/// 剪切后的图片
@property(nonatomic, strong, readonly) UIImage *snipImage;

/**
 剪切生成新图片

 @return 生成的新图片
 */
-(UIImage *)snipImage;


/**
 生成一个圆形图片，常用作头像

 @return 圆形图片
 */
-(UIImage *)snipCircleImage;


/**
 生成一个带边框的圆形图片，常用作头像

 @param boardWidth 边框宽度
 @param color 边框颜色
 @return 带边框的圆形图片
 */
-(UIImage *)snipCircleImageBoardWidth:(CGFloat)boardWidth boardColor:(UIColor *)color;
@end
