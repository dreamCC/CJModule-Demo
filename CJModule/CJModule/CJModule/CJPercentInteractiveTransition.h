//
//  CJPercentInteractiveTransition.h
//  CJModule
//
//  Created by 仁和Mac on 2018/12/29.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CJPercentInteractiveTransitionDirection) {
    CJPercentInteractiveTransitionDirectionLeft,   // ←
    CJPercentInteractiveTransitionDirectionRight,  // →
    CJPercentInteractiveTransitionDirectionUp,     // ↑
    CJPercentInteractiveTransitionDirectionDown    // ↓
};

typedef NS_ENUM(NSUInteger, CJPercentInteractiveTransitionType) {
    CJPercentInteractiveTransitionTypeDismissed
};

@interface CJPercentInteractiveTransition : UIPercentDrivenInteractiveTransition

@property(nonatomic,assign) CJPercentInteractiveTransitionType interactivTransitionType;
@property(nonatomic,assign) CJPercentInteractiveTransitionDirection interactivTransitionDirection;


-(instancetype)initWithTransitionType:(CJPercentInteractiveTransitionType)transitionType
                  transitionDirection:(CJPercentInteractiveTransitionDirection)transitionDirection;

@end



@interface UIViewController (CJPercentInteractiveTransition)

@property(nonatomic, assign, readonly, getter=isUseInteractiveTransition) BOOL useInteractiveTransition;
@property(nonatomic, strong) CJPercentInteractiveTransition *interactiveTransition;

@end

NS_ASSUME_NONNULL_END
