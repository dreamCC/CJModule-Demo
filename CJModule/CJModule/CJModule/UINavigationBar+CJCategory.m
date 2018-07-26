//
//  UINavigationBar+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UINavigationBar+CJCategory.h"
#import <objc/runtime.h>

@implementation UINavigationBar (CJCategory)




-(void)cj_reset {
    
}

#pragma mark ---private
-(UIView *)cj_navigationBarContentView {
    UIView *contentView = objc_getAssociatedObject(self, _cmd);
    if (!contentView) {
        for (UIView *subV in self.subviews) {
            if ([subV isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
                objc_setAssociatedObject(self, _cmd, subV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                return subV;
            }
        }
    }
    return contentView;
}

-(UIView *)cj_barBackground {
    UIView *background = objc_getAssociatedObject(self, _cmd);
    if (!background) {
        for (UIView *subV in self.subviews) {
            if ([subV isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                return subV;
            }
            
        }
    }
    return background;
}

@end
