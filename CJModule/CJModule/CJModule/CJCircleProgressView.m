//
//  CJCircleProgressView.m
//  CommonProject
//
//  Created by 仁和Mac on 2017/5/29.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJCircleProgressView.h"

@interface CJCircleProgressLayer : CALayer

@property(nonatomic,assign) CGFloat layerProgress;
@property(nonatomic,assign) CGFloat layerDuration;
@property(nonatomic, strong) UIColor *strokColor;


@end

@implementation CJCircleProgressLayer
@dynamic layerProgress;
@dynamic strokColor;

-(instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

+(BOOL)needsDisplayForKey:(NSString *)key {
    return [key isEqualToString:@"layerProgress"] || [super needsDisplayForKey:key];
}

-(id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"layerProgress"]) {
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:event];
        basic.duration  =  _layerDuration;
        basic.fromValue = [self.presentationLayer valueForKey:@"layerProgress"];
        return basic;
    }
    return [super actionForKey:event];
}

-(void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
   
    CGFloat progressW  = 4.f;
    CGPoint startPoint = CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame) * 0.5);
    CGPoint movePoint  = CGPointMake(CGRectGetWidth(self.frame) * 0.5, progressW * 0.5);
    CGFloat radius     = (MIN(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) - progressW) * 0.5;
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle   = M_PI * 2 * (self.layerProgress) + startAngle; // 想画的弧度，是endAngle - startAngle
    CGContextMoveToPoint(ctx, movePoint.x, movePoint.y);
    CGContextAddArc(ctx, startPoint.x, startPoint.y, radius, startAngle, endAngle, NO);
    CGContextSetStrokeColorWithColor(ctx, self.strokColor.CGColor);
    CGContextSetLineWidth(ctx, progressW);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextStrokePath(ctx);
    
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
}

@end

@interface CJCircleProgressView ()

@end

@implementation CJCircleProgressView

+(Class)layerClass {
    return [CJCircleProgressLayer class];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self didInitialize];
    return self;
}

-(void)didInitialize {
    self.backgroundColor = [UIColor clearColor];
    self.tintColor       = [UIColor colorWithRed:49/255.0 green:189/255.0 blue:243/255.0 alpha:1.f];
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    
    self.mainLayer.layerDuration = 0.5f;
 
}

-(void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.mainLayer.layerProgress = progress;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


-(void)tintColorDidChange {
    [super tintColorDidChange];
    self.mainLayer.strokColor = self.tintColor;
}

-(CJCircleProgressLayer *)mainLayer {
    return (CJCircleProgressLayer *)self.layer;
}

@end
