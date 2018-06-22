//
//  CJPieProgressView.h
//  CommonProject
//
//  Created by 仁和Mac on 2017/5/25.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJPieProgressView : UIControl

/// 动画时间。默认0.2
@property(nonatomic, assign) NSTimeInterval duration;

/// 动画进度。默认0.f
@property(nonatomic, assign) CGFloat progress;


-(void)setProgress:(CGFloat)progress animated:(BOOL)animated;
@end
