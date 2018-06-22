//
//  CJMenuView.h
//  CommonProject
//
//  Created by zhuChaojun的mac on 2017/3/20.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJProgressHUD : NSObject


/**
 显示提示，默认在window上面

 @param hint 提示
 */
+(void)showHint:(NSString *)hint;

/**
 显示提示

 @param hint 提示
 @param view 指定的view
 */
+(void)showHint:(NSString *)hint toView:(UIView *)view;

/**
 显示带图片的提示

 @param hint 提示
 @param image 图片
 @param view 指定的view
 */
+(void)showHint:(NSString *)hint image:(UIImage *)image toView:(UIView *)view;


/**
 显示成功提示

 @param hint 提示
 */
+(void)showSuccessHint:(NSString *)hint;

/**
 显示成功提示到指定view

 @param hint 提示
 */
+(void)showSuccessHint:(NSString *)hint toView:(UIView *)view;

/**
 显示失败提示，默认到window上面

 @param hint 提示
 */
+(void)showErrorHint:(NSString *)hint;

/**
 显示失败提示到指定view

 @param hint 提示
 @param view 指定view
 */
+(void)showErrorHint:(NSString *)hint toView:(UIView *)view;

/**
 显示加载提示框，默认在window上面

 @param notice 提示内容
 */
+(void)showNotice:(NSString *)notice;

/**
 显示加载提示框到指定view

 @param notice 提示内容
 @param view 指定view
 */
+(void)showNotice:(NSString *)notice toView:(UIView *)view;


/**
 隐藏提示框
 */
+(void)hiddenNotice;

/**
 多少秒后隐藏提示框

 @param second 延时时间
 */
+(void)hiddenNoticeAfterDelay:(CGFloat)second;

@end
