
//
//  DefineTransformViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/12/28.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "DefineTransformViewController.h"
#import "CJPercentInteractiveTransition.h"
#import <Masonry.h>
#import <QMUIKit.h>

typedef NS_ENUM(NSUInteger, DefineAnimatedTransitioningType) {
    DefineAnimatedTransitioningTypePrsented,
    DefineAnimatedTransitioningTypeDismiss
};

@interface DefineAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerInteractiveTransitioning>

-(instancetype)initWithTransitioningType:(DefineAnimatedTransitioningType)transitioningType;

@end

@implementation DefineAnimatedTransitioning {
    DefineAnimatedTransitioningType _transitioningType;
}

-(instancetype)initWithTransitioningType:(DefineAnimatedTransitioningType)transitioningType {
    self = [super init];
    if (self) {
        _transitioningType = transitioningType;
    }
    return self;
}




- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.f;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_transitioningType) {
        case DefineAnimatedTransitioningTypePrsented:
            [self presentAnimateTransition:transitionContext];
            break;
        case DefineAnimatedTransitioningTypeDismiss:
            [self dismissAnimateTransition:transitionContext];
            break;
        default:
            break;
    }
}

-(void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
  
    
    toView.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(toView.frame), 0);
    [containerView addSubview:toView];
    [UIView animateWithDuration:1.f animations:^{
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            [toView removeFromSuperview];
        }else {
            
        }
       
    }];
}

-(void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
   
    [UIView animateWithDuration:1.f animations:^{
        fromView.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(fromView.frame), 0);
    } completion:^(BOOL finished) {
        NSLog(@"transitionWasCancelled:%d",[transitionContext transitionWasCancelled]);
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
         if ([transitionContext transitionWasCancelled]) {
             
         }else {
             
         }
    }];
    
}



// 开始手势
- (void)startInteractiveTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
}

@end

@interface DefineTransformViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation DefineTransformViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *disMissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [disMissBtn addTarget:self action:@selector(disMissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [disMissBtn setTitle:@"disMissBtn" forState:UIControlStateNormal];
    
    disMissBtn.backgroundColor = [UIColor qmui_randomColor];
    [self.view addSubview:disMissBtn];
    [disMissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
 
    self.interactiveTransition = [[CJPercentInteractiveTransition alloc] initWithTransitionType:CJPercentInteractiveTransitionTypeDismissed
                                                                            transitionDirection:CJPercentInteractiveTransitionDirectionDown];

}

-(void)disMissBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}




-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[DefineAnimatedTransitioning alloc] initWithTransitioningType:DefineAnimatedTransitioningTypePrsented];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DefineAnimatedTransitioning alloc] initWithTransitioningType:DefineAnimatedTransitioningTypeDismiss];
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.isUseInteractiveTransition?self.interactiveTransition:nil;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}


-(void)dealloc {
    NSLog(@"%s",__func__);
}

@end
