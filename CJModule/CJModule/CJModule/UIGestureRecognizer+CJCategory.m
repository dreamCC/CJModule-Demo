//
//  UIGestureRecognizer+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UIGestureRecognizer+CJCategory.h"
#import <objc/runtime.h>


@interface CJGesturenTarget : NSObject

@property(nonatomic, copy) void(^action)(id sender);

-(instancetype)initWithAction:(void(^)(id sender))action;
-(void)invoke:(id)sender;
@end

@implementation CJGesturenTarget

-(instancetype)initWithAction:(void (^)(id))action {
    self = [super init];
    if (!self) return nil;
    _action = action;
    return self;
    
}

-(void)invoke:(id)sender {
    if (_action) {
        _action(sender);
    }
}
@end

@implementation UIGestureRecognizer (CJCategory)

-(instancetype)initWithAction:(void (^)(id sender))action {
    self = [self init];
    
    [self addAction:action];
    
    return self;
}

-(void)addAction:(void(^)(id sender))action {
    CJGesturenTarget *target = [[CJGesturenTarget alloc] initWithAction:action];
    
    [self addTarget:target action:@selector(invoke:)];
    
    [[self cj_allActionTargets] addObject:target];
}

-(void)removeAllTargets {
    NSMutableArray *targets = [self cj_allActionTargets];
    [targets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeTarget:obj action:@selector(invoke:)];
    }];
}

-(NSMutableArray *)cj_allActionTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, _cmd);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}
@end






