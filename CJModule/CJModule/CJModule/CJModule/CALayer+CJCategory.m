//
//  CALayer+CJAnimation.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/27.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CALayer+CJCategory.h"

@implementation CALayer (CJAnimation)

/// 停止动画
-(void)cj_pauseAnimation {
    if (self.speed == 0) return;
    
    CFTimeInterval pauseTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed      = 0.f;
    self.timeOffset = pauseTime;
}

/// 继续动画
-(void)cj_continueAnimation {
    if (self.speed != 0) return;
    CFTimeInterval  pauseTime = self.timeOffset;

    self.speed      = 1.0f;
    self.timeOffset = 0.f;
    self.beginTime  = 0.f; //表示持续时间内的，开始时间
    
    CFTimeInterval sinceTime = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    self.beginTime  = sinceTime;
}
@end
