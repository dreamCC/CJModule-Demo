//
//  UINavigationBar+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UINavigationBar+CJCategory.h"
#import <objc/runtime.h>

#define CURRENT_VERSION [UIDevice currentDevice].systemVersion.integerValue
#define IS_IPhoneX      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define StatusBarHeight (IS_IPhoneX ? 44.f : 20.f)

@implementation UINavigationBar (CJCategory)

-(void)cj_barBackgroudColor:(UIColor *)color {
    self.cj_overLayView.backgroundColor = color;
    
}

-(void)cj_navigationItemAlpha:(CGFloat)alpha {
    if (CURRENT_VERSION >= 11) {
        for (UIView *subV in self.subviews) {
            if ([subV isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
                [self cj_changeView:subV alpha:alpha];
                return;
            }
        }
    }else {
        [self cj_changeView:self alpha:alpha];
    }
}

-(void)cj_reset {
    [self.cj_overLayView removeFromSuperview];
    objc_setAssociatedObject(self, @selector(cj_overLayView), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark ---private
-(void)cj_changeView:(UIView *)view alpha:(CGFloat)alpha {
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.alpha = alpha;
    }];
}

-(UIView *)cj_overLayView {
    UIView *overLay = objc_getAssociatedObject(self, _cmd);
    if (!overLay) {
        overLay = [UIView new];
        overLay.userInteractionEnabled = NO;
        
        if (CURRENT_VERSION >= 11) {
            overLay.frame = CGRectMake(0, -StatusBarHeight, CGRectGetWidth(self.frame), StatusBarHeight+44);
            for (UIView *subV in self.subviews) {
                if ([subV isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
                    [self insertSubview:overLay belowSubview:subV];
                    break;
                }
            }
        }else {
            overLay.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 64);
            for (UIView *subV in self.subviews) {
                if ([subV isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                    [subV insertSubview:overLay atIndex:0];
                    break;
                }
                
            }
        }
        
        objc_setAssociatedObject(self, _cmd, overLay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self setShadowImage:[UIImage new]];
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    }
    return overLay;
}

@end
