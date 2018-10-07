//
//  CJCountingLable.h
//  CJModule
//
//  Created by 仁和Mac on 2018/9/27.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJCountingLable : UILabel

/// 计数速率。默认2，表示屏幕刷新两次，更新一次计数数字。
@property(nonatomic, assign) NSInteger countingSpeed;

/// 计数幅度。
@property(nonatomic, assign) CGFloat countingRange;


-(void)countFromValue:(NSString *)fromValue toValue:(NSString *)toValue;
@end
