//
//  CJPercentInteractiveTransition.m
//  CJModule
//
//  Created by 仁和Mac on 2018/12/29.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJPercentInteractiveTransition.h"
#import <objc/runtime.h>

@interface CJPercentInteractiveTransition ()



@end

@implementation CJPercentInteractiveTransition

-(instancetype)initWithTransitionType:(CJPercentInteractiveTransitionType)transitionType transitionDirection:(CJPercentInteractiveTransitionDirection)transitionDirection {
    self = [super init];
    if (self) {
        self.interactivTransitionType = transitionType;
        self.interactivTransitionDirection = transitionDirection;
    }
    return self;
}



@end


@implementation UIViewController (CJPercentInteractiveTransition)

static char kInteractiveTransition;
-(void)setInteractiveTransition:(CJPercentInteractiveTransition *)interactiveTransition {
    [self.view addGestureRecognizer:self.cj_panGesture];
    objc_setAssociatedObject(self, &kInteractiveTransition, interactiveTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CJPercentInteractiveTransition *)interactiveTransition  {
    return objc_getAssociatedObject(self, &kInteractiveTransition);
}

static char kUseInteractiveTransition;
-(void)setUseInteractiveTransition:(BOOL)useInteractiveTransition {
    objc_setAssociatedObject(self, &kUseInteractiveTransition, @(useInteractiveTransition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isUseInteractiveTransition {
    return objc_getAssociatedObject(self, &kUseInteractiveTransition);
}


-(UIPanGestureRecognizer *)cj_panGesture {
    UIPanGestureRecognizer *pan  = objc_getAssociatedObject(self, _cmd);
    if (!pan) {
        pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cj_panGestureStart:)];
        objc_setAssociatedObject(self, _cmd, pan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return pan;
}

-(void)cj_panGestureStart:(UIPanGestureRecognizer *)panGesture {
    CGFloat transitionPercent = 0, view_W = CGRectGetWidth(self.view.frame), view_H = CGRectGetHeight(self.view.frame);
    switch (self.interactiveTransition.interactivTransitionDirection) {
        case CJPercentInteractiveTransitionDirectionRight:
        {
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            transitionPercent = transitionX/view_W;
        }
            break;
        case CJPercentInteractiveTransitionDirectionLeft:
        {
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            transitionPercent = transitionX/view_W;
        }
            break;
        case CJPercentInteractiveTransitionDirectionDown:
        {
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            transitionPercent = transitionY/view_H;
        }
            break;
        case CJPercentInteractiveTransitionDirectionUp:
        {
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            transitionPercent = transitionY/view_H;
        }
            break;
        default:
            break;
    }
    
    NSLog(@"%f",transitionPercent);
        
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.useInteractiveTransition = YES;
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.interactiveTransition updateInteractiveTransition:transitionPercent];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            self.useInteractiveTransition = NO;
            if (transitionPercent >= 0.5) {
                [self.interactiveTransition finishInteractiveTransition];
            }else {
                [self.interactiveTransition cancelInteractiveTransition];
            }
        }
            break;
        default:
            break;
    }
}
@end
