//
//  UIView+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/23.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UIView+CJCategory.h"
#import <objc/runtime.h>
#import "UIVisualEffectView+CJCategory.h"

@implementation UIView (CJFrame)

-(void)setCj_x:(CGFloat)cj_x {
    CGRect frame   = self.frame;
    frame.origin.x = cj_x;
    self.frame     = frame;
}

-(CGFloat)cj_x {
    return self.frame.origin.x;
}


-(void)setCj_y:(CGFloat)cj_y {
    CGRect frame   = self.frame;
    frame.origin.y = cj_y;
    self.frame     = frame;
}

-(CGFloat)cj_y {
    return self.frame.origin.y;
}


-(void)setCj_h:(CGFloat)cj_h {
    CGRect frame      = self.frame;
    frame.size.height = cj_h;
    self.frame        = frame;
}

-(CGFloat)cj_h {
    return self.frame.size.height;
}

-(void)setCj_w:(CGFloat)cj_w {
    CGRect frame      = self.frame;
    frame.size.width  = cj_w;
    self.frame        = frame;
}

-(CGFloat)cj_w {
    return self.frame.size.width;
}

-(void)setCj_centerX:(CGFloat)cj_centerX {
    CGPoint center = self.center;
    center.x       = cj_centerX;
    self.center    = center;
}

-(CGFloat)cj_centerX {
    return self.center.x;
}

-(void)setCj_centerY:(CGFloat)cj_centerY {
    CGPoint center = self.center;
    center.y       = cj_centerY;
    self.center    = center;
}

-(CGFloat)cj_centerY {
    return self.center.y;
}

@end


static NSArray<NSLayoutConstraint *> * CJEdgesConstraints(UIView *item, UIView *toItem){
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:item
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:toItem
                                                           attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:item
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:toItem
                                                            attribute:NSLayoutAttributeLeft multiplier:1.f constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:item
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:toItem
                                                              attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:item
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:toItem
                                                             attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    return @[top,left,bottom,right];
}

@implementation UIView (CJEffectView)

-(UIView *)cj_viewWithBlurVisualEffect {
    return [self cj_viewWithBlurVisualEffectStyle:UIBlurEffectStyleLight];
}

-(UIView *)cj_viewWithBlurVisualEffectStyle:(UIBlurEffectStyle)blurEffectStyle {
    UIVisualEffectView *effectView = [UIVisualEffectView cj_blurVisualEffectViewBlurStyle:blurEffectStyle];
    [self addSubview:effectView];
    [self addConstraints:CJEdgesConstraints(effectView, self)];
    return self;
}

-(UIView *)cj_viewWithVibrancyVisualSubView:(__kindof UIView *)subView {
    return [self cj_viewWithVibrancyVisualEffectStyle:UIBlurEffectStyleLight subView:subView];
}

-(UIView *)cj_viewWithVibrancyVisualEffectStyle:(UIBlurEffectStyle)blurEffectStyle subView:(UIView *)subView {
    UIVisualEffectView *visualEffectV = [UIVisualEffectView cj_vibrancyVisualEffectViewBlurStyle:blurEffectStyle subView:subView];
    [self addSubview:visualEffectV];
    [self addConstraints:CJEdgesConstraints(visualEffectV, self)];
    return self;
}



@end




