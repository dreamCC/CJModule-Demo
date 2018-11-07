//
//  CJReplicatorHeightLodingView.m
//  CommonProject
//
//  Created by 仁和Mac on 2017/5/30.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJReplicatorHeightLodingView.h"

static NSString *const kHeightLodingAnimation = @"com.kHeightLodingAnimation.cn";

@interface CJReplicatorHeightLodingView ()

@property(nonatomic,weak) CALayer *itemLayer;
@property(nonatomic,weak) CAReplicatorLayer *replicatorLayer;

@end

@implementation CJReplicatorHeightLodingView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self didInitializel];
        [self didSetupItems];
        
    }
    return self;
}

-(void)didInitializel {
    self.itemSize  = CGSizeMake(2, 20);
    self.itemCount = 7;
    self.itemSpace = 3.f;
    self.duration  = 0.5f;
}

-(void)didSetupItems {
    CALayer *itemLayer = [CALayer layer];
    itemLayer.cornerRadius    = _itemSize.width * 0.25;
    itemLayer.backgroundColor = [UIColor colorWithRed:49/255.0 green:189/255.0 blue:243/255.0 alpha:1.f].CGColor;
    
    CABasicAnimation *heightAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    heightAnimation.toValue  = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.f, 0.f, 1.f)];
    heightAnimation.duration = _duration;
    heightAnimation.repeatCount  = HUGE;
    heightAnimation.removedOnCompletion = NO;
    heightAnimation.autoreverses = YES;
    heightAnimation.fillMode = kCAFillModeForwards;
    [itemLayer addAnimation:heightAnimation forKey:kHeightLodingAnimation];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceCount = _itemCount;
    replicatorLayer.instanceDelay = _duration / _itemCount;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(_itemSpace + _itemSize.width, 0, 0);
    [self.layer addSublayer:replicatorLayer];
    [replicatorLayer addSublayer:itemLayer];
    
    _itemLayer = itemLayer;
    _replicatorLayer = replicatorLayer;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = (CGRect){{(CGRectGetWidth(self.frame) - (_itemCount*(_itemSize.width + _itemSpace) - _itemSpace))*0.5,
                            (CGRectGetHeight(self.frame) - _itemSize.height)*0.5f},
                            _itemSize};
    _itemLayer.frame = frame;
    _replicatorLayer.frame = self.bounds;
}

-(void)tintColorDidChange {
    [super tintColorDidChange];
    _itemLayer.backgroundColor = self.tintColor.CGColor;
}

-(void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
    _itemLayer.cornerRadius    = _itemSize.width * 0.25;
}

@end
