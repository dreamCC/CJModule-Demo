//
//  CJPieProgressView.m
//  CommonProject
//
//  Created by 仁和Mac on 2017/5/25.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJPieProgressView.h"

@interface CJPieProgressLayer : CALayer

@property(nonatomic,assign) CGFloat animationProgress;
@property(nonatomic,assign) NSTimeInterval animationDuration;
@property(nonatomic,strong) UIColor *fillColor;
@property(nonatomic,assign) BOOL progressChangeWithAnimation;

@end

@implementation CJPieProgressLayer
@dynamic animationProgress;
@dynamic fillColor;

+(BOOL)needsDisplayForKey:(NSString *)key {
    return [super needsDisplayForKey:key] || [key isEqualToString:@"animationProgress"];
}


-(id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"animationProgress"] && self.progressChangeWithAnimation) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        animation.duration = _animationDuration;
        animation.fromValue = [self.presentationLayer valueForKey:event];
        return animation;
    }
    
    return [super actionForKey:event];
}

-(void)drawInContext:(CGContextRef)ctx {
    if (CGRectIsEmpty(self.bounds)) return;
    [super drawInContext:ctx];

    CGPoint center  = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radians = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))*0.5f;
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle   = 2*M_PI*self.animationProgress + startAngle;
    CGContextMoveToPoint(ctx, center.x, center.y);
    CGContextAddArc(ctx, center.x, center.y, radians, startAngle, endAngle, 0);
    CGContextSetFillColorWithColor(ctx, self.fillColor.CGColor);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.cornerRadius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))*0.5f;
}


@end


@implementation CJPieProgressView
+(Class)layerClass {
    return [CJPieProgressLayer class];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

    [self didInitialized];
    return self;
}

-(void)didInitialized {
    self.backgroundColor = [UIColor clearColor];
    self.tintColor       = [UIColor colorWithRed:49/255.0 green:189/255.0 blue:243/255.0 alpha:1.f];
    
    self.duration = 0.2f;
    self.progress = 0.f;
    
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layer.borderWidth   = 1.f;
    self.mainLayer.animationDuration  = _duration;
    [self.layer setNeedsDisplay];
}


-(void)setProgress:(CGFloat)progress animated:(BOOL)animated {

    _progress = progress;
    if (progress > 1.f) return;
    self.mainLayer.animationProgress   = progress;
    self.mainLayer.progressChangeWithAnimation = animated;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

// 如果设置tintColor，将会调用改方法。
-(void)tintColorDidChange {
    [super tintColorDidChange];
    self.mainLayer.fillColor = self.tintColor;
    self.layer.borderColor   = self.tintColor.CGColor;
}





#pragma mark --- setter && getter
-(void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:NO];
}

-(void)setDuration:(NSTimeInterval)duration {
    _duration = duration;
    self.mainLayer.animationDuration = duration;
}

-(CJPieProgressLayer *)mainLayer {
    return (CJPieProgressLayer *)self.layer;
}

@end
