//
//  UIVisualEffectView+CJCategory.m
//  CJModule
//
//  Created by 仁和Mac on 2019/1/3.
//  Copyright © 2019年 zhucj. All rights reserved.
//

#import "UIVisualEffectView+CJCategory.h"

@implementation UIVisualEffectView (CJCategory)

+(UIVisualEffectView *)cj_blurVisualEffectView {
    return [self cj_blurVisualEffectViewBlurStyle:UIBlurEffectStyleLight];
}

+(UIVisualEffectView *)cj_blurVisualEffectViewBlurStyle:(UIBlurEffectStyle)blurStyle {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:blurStyle];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.translatesAutoresizingMaskIntoConstraints = NO;
    return effectView;
}


+(UIVisualEffectView *)cj_vibrancyVisualEffectViewWithSubView:(__kindof UIView *)view {
    return [self cj_vibrancyVisualEffectViewBlurStyle:UIBlurEffectStyleLight subView:view];
}

+(UIVisualEffectView *)cj_vibrancyVisualEffectViewBlurStyle:(UIBlurEffectStyle)blurStyle subView:(__kindof UIView *)view {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:blurStyle];
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *effectView   = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    effectView.translatesAutoresizingMaskIntoConstraints = NO;
    [effectView.contentView addSubview:view];
    return effectView;
}
@end
