//
//  CJGradientProgressView.m
//  CommonProject
//
//  Created by 仁和Mac on 2017/5/28.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJGradientProgressView.h"

static NSString *const kAnimationKey = @"com.kAnimationKey.cn";

@interface CJGradientProgressLayer : CALayer

@end

@implementation CJGradientProgressLayer

-(void)setCornerRadius:(CGFloat)cornerRadius {
    [super setCornerRadius:cornerRadius];
    CALayer *layer     = self.sublayers.firstObject;
    layer.cornerRadius = cornerRadius;
}

@end

@interface CJGradientProgressView ()

@end

@implementation CJGradientProgressView

+(Class)layerClass {
    return [CJGradientProgressLayer class];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self didInitializal];
    [self didSetupSubLayer];
    return self;
}

-(void)didInitializal {
    self.backgroundColor = [UIColor colorWithRed:208/255.f green:208/255.f blue:208/255.f alpha:1.0];
    
    _startColor = [UIColor grayColor];
    _endColor   = [UIColor whiteColor];
    _duration   = 1.5f;
    _progress   = 0.5f;
}

-(void)didSetupSubLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors     = @[(id)(_startColor.CGColor) ,
                                 (id)(_endColor.CGColor) ,
                                 (id)(_startColor.CGColor),
                                 (id)(_endColor.CGColor) ,
                                 (id)(_startColor.CGColor)];
    gradientLayer.locations  = @[@(-1) , @(-0.5) , @0 , @0.5 , @1];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint   = CGPointMake(1, 0.5);
    [self.layer addSublayer:gradientLayer];
    _gradientLayer = gradientLayer;
    
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"locations"];
    basic.toValue = @[@0 , @0.5 , @1 , @1.5 , @2];
    basic.repeatCount = HUGE;
    basic.duration    = _duration;
    [gradientLayer addAnimation:basic forKey:kAnimationKey];
    
    self.layer.cornerRadius = CGRectGetHeight(self.frame) / 3.f;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _gradientLayer.frame = (CGRect){{0 , 0},{CGRectGetWidth(self.frame) * _progress , CGRectGetHeight(self.frame)}};
}

-(void)setProgress:(CGFloat)progress {
    _progress  = progress;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}




@end
