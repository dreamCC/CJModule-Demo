//
//  CJReplicatorRotateLodingView.m
//  CommonProject
//
//  Created by 仁和Mac on 2017/5/30.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJReplicatorRotateLodingView.h"

static NSString *const kShapelayerAnimationKey = @"com.kShapelayerAnimationKey.cn";

@interface CJReplicatorRotateLodingView ()

@property(nonatomic,weak) CALayer *itemLayer;
@property(nonatomic,weak) CAReplicatorLayer *replicatorLayer;

@end

@implementation CJReplicatorRotateLodingView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self didInitializel];
        [self didSetupItems];
        
    }
    return self;
}

-(void)didInitializel {
    self.itemW = 8.f;
    self.itemCount = 12.f;
    self.duration  = 1.f;
}

-(void)didSetupItems {
    CALayer *itemLayer = [CALayer layer];
    itemLayer.backgroundColor = [UIColor colorWithRed:49/255.0 green:189/255.0 blue:243/255.0 alpha:1.f].CGColor;
    itemLayer.cornerRadius = _itemW*0.5;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue    = @(0);
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[scaleAnimation, opacityAnimation];
    groupAnimation.duration   = _duration;
    groupAnimation.repeatCount  = HUGE;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode   = kCAFillModeForwards;
    [itemLayer addAnimation:groupAnimation forKey:kShapelayerAnimationKey];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.bounds;
    replicatorLayer.instanceCount  = _itemCount;
    replicatorLayer.instanceDelay  = _duration / _itemCount ;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(2*M_PI / _itemCount, 0, 0, 1);
    [self.layer addSublayer:replicatorLayer];
    [replicatorLayer addSublayer:itemLayer];
    
    _itemLayer       = itemLayer;
    _replicatorLayer = replicatorLayer;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = CGRectMake((CGRectGetWidth(self.frame) - _itemW)*0.5, 0, _itemW, _itemW);
    _itemLayer.frame       = frame;
    _replicatorLayer.frame = self.bounds;
}

-(void)tintColorDidChange {
    [super tintColorDidChange];
    _itemLayer.backgroundColor = self.tintColor.CGColor;
}


@end
