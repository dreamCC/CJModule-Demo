//
//  UINavigationController+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/29.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UINavigationController+CJCategory.h"
#import "CJDefines.h"

@interface CJFullScreenGestureDelegate : NSObject<UIGestureRecognizerDelegate>

@property(nonatomic, weak) UINavigationController *navigationController;


@end

@implementation CJFullScreenGestureDelegate

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 根视图关闭手势
    if (self.navigationController.childViewControllers.count <= 1) {
        return NO;
    }
    
    // 正在动画，忽略掉手势
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    UIPanGestureRecognizer *currentGesture = (UIPanGestureRecognizer *)gestureRecognizer;
    CGFloat translate = [currentGesture translationInView:currentGesture.view].x;
    if (translate <= 0) {
        return NO;
    }

    return YES;
}

#if 0
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return NO;
    }
    return YES;
}
#endif

@end

@implementation UINavigationController (CJCategory)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CJSwizzleMethod([self class], @selector(viewDidLoad), @selector(cj_viewDidLoad));
    });
}

-(void)cj_viewDidLoad {
    [self cj_viewDidLoad];

    
    NSArray *targets    = [self.interactivePopGestureRecognizer valueForKey:@"targets"]; //UIGestureRecognizer 的ivar属性
    id target           = [targets.firstObject valueForKey:@"target"];
    UIView *gestureView = self.interactivePopGestureRecognizer.view;
    [self.cj_panGesture addTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    [gestureView addGestureRecognizer:self.cj_panGesture];
    self.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark ---delegate
-(UIPanGestureRecognizer *)cj_panGesture {
    UIPanGestureRecognizer *pan = objc_getAssociatedObject(self, _cmd);
    if (!pan) {
        pan = [[UIPanGestureRecognizer alloc] init];
        pan.delegate = self.cj_fullScreenGestureDelegate;
        objc_setAssociatedObject(self, _cmd, pan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return pan;
}

-(CJFullScreenGestureDelegate *)cj_fullScreenGestureDelegate {
    CJFullScreenGestureDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [CJFullScreenGestureDelegate new];
        delegate.navigationController = self;
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}



@end
