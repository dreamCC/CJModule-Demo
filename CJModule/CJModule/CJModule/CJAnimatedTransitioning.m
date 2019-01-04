//
//  CJAnimatedTransitioning.m
//  CJModule
//
//  Created by 仁和Mac on 2018/12/28.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJAnimatedTransitioning.h"

@implementation CJAnimatedTransitioning {
    CJAnimatedTransitioningType _animatedTransitioningType;
}


+(instancetype)animatedTransitioningWithType:(CJAnimatedTransitioningType)animatedTransitioningType {
    return [[CJAnimatedTransitioning alloc] initWithTransitioningWithType:animatedTransitioningType];
}

-(instancetype)initWithTransitioningWithType:(CJAnimatedTransitioningType)animatedTransitioningType {
    self = [super init];
    if (self) {
        _animatedTransitioningType = animatedTransitioningType;
        self.duration = 0.25f;
    }
    return self;
}

#pragma mark ----- UIViewControllerAnimatedTransitioning
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_animatedTransitioningType) {
        case CJAnimatedTransitioningTypePresenting:
            !self.presentingAnimatedTransition?:self.presentingAnimatedTransition(transitionContext);
            break;
        case CJAnimatedTransitioningTypeDismissed:
            !self.dissmissedAnimatedTransition?:self.dissmissedAnimatedTransition(transitionContext);
            break;
        default:
            break;
    }
}


@end
