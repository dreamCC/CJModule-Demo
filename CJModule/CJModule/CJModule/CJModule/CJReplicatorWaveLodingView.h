//
//  CJReplicatorWaveLodingView.h
//  CommonProject
//
//  Created by 仁和Mac on 2017/5/30.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJReplicatorWaveLodingView : UIView

/// item的宽度。默5.f
@property(nonatomic, assign) CGFloat itemW;

/// item的数量。默认4
@property(nonatomic, assign) NSUInteger itemCount;

/// 动画时间。默认2.f
@property(nonatomic, assign) NSTimeInterval duration;

@end
