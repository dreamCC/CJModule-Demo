//
//  UIControl+CJCategory.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/8.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (CJCategory)

/// 接收事件的间隔
@property(nonatomic, assign) NSTimeInterval cj_acceptEventInterval;

/// 接收事件的时间
@property(nonatomic, assign) NSTimeInterval cj_acceptEventTime;
@end
