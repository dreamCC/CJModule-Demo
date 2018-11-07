//
//  CJReplicatorWaveLodingView.m
//  CommonProject
//
//  Created by 仁和Mac on 2017/5/30.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJReplicatorWaveLodingView.h"

static NSString *const kWaveLodingAnimation = @"com.kWaveLodingAnimation.cn";

@interface CJReplicatorWaveLodingView ()

@property(nonatomic,weak) CALayer *itemLayer;

@end

@implementation CJReplicatorWaveLodingView

+(Class)layerClass {
    return [CAReplicatorLayer class];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self didInitializel];
        [self didSetupItems];
        
    }
    return self;
}

-(void)didInitializel {
    self.itemW = 5.f;
    self.itemCount = 4;
    self.duration  = 2.f;
}

-(void)didSetupItems {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor colorWithRed:49/255.0 green:189/255.0 blue:243/255.0 alpha:1.f].CGColor;
    layer.cornerRadius    = _itemW * 0.5f;
    
    CGFloat minWidth = MIN(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGFloat scale    = minWidth / _itemW;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue = @(0);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scaleAnimation,opacityAnimation];
    group.duration   = _duration;
    group.repeatCount = HUGE;
    group.removedOnCompletion = NO;
    group.fillMode   = kCAFillModeForwards;
    [layer addAnimation:group forKey:kWaveLodingAnimation];
    
    CAReplicatorLayer *replicator = (CAReplicatorLayer *)self.layer;
    replicator.instanceCount = _itemCount;
    replicator.instanceDelay = _duration / _itemCount;
    [replicator addSublayer:layer];
    
    _itemLayer = layer;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    _itemLayer.frame = CGRectMake((CGRectGetWidth(self.frame) - _itemW)*0.5, (CGRectGetHeight(self.frame) - _itemW) * 0.5, _itemW, _itemW);
}

-(void)tintColorDidChange {
    [super tintColorDidChange];
    _itemLayer.backgroundColor = self.tintColor.CGColor;
}

@end
