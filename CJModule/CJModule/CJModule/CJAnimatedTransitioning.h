//
//  CJAnimatedTransitioning.h
//  CJModule
//
//  Created by 仁和Mac on 2018/12/28.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CJAnimatedTransitioningType) {
    CJAnimatedTransitioningTypePresenting,
    CJAnimatedTransitioningTypeDismissed
};

typedef void(^PresentingAnimatedTransitionBlock)(id<UIViewControllerContextTransitioning> transitionContext);
typedef void(^DissmissedAnimatedTransitionBlock)(id<UIViewControllerContextTransitioning> transitionContext);

@interface CJAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, copy) PresentingAnimatedTransitionBlock presentingAnimatedTransition;

@property (nonatomic, copy) DissmissedAnimatedTransitionBlock dissmissedAnimatedTransition;



+(instancetype)animatedTransitioningWithType:(CJAnimatedTransitioningType)animatedTransitioningType;

-(instancetype)initWithTransitioningWithType:(CJAnimatedTransitioningType)animatedTransitioningType;
@end

NS_ASSUME_NONNULL_END
