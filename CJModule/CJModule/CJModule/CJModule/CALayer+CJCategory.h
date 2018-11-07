//
//  CALayer+CJAnimation.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/27.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (CJAnimation)

/// 停止动画
-(void)cj_pauseAnimation;

/// 继续动画
-(void)cj_continueAnimation;
@end
