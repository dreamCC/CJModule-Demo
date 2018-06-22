//
//  UIGestureRecognizer+CJCategory.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (CJCategory)

/// 回调
-(instancetype)initWithAction:(void(^)(id sender)) action;

/// 添加事件
-(void)addAction:(void(^)(id sender))action;

/// 移除所有targets
-(void)removeAllTargets;

@end
