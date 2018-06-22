//
//  NSDate+CJCategory.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CJConvert)

/// 年
@property(nonatomic, assign, readonly) NSInteger cj_year;

/// 月
@property(nonatomic, assign, readonly) NSInteger cj_month;

/// 日
@property(nonatomic, assign, readonly) NSInteger cj_day;

/// 时
@property(nonatomic, assign, readonly) NSInteger cj_hour;

/// 分
@property(nonatomic, assign, readonly) NSInteger cj_minute;

/// 秒
@property(nonatomic, assign, readonly) NSInteger cj_second;

@property(nonatomic, strong, readonly) NSDateComponents *cj_dateComponents;

/// 转换成YYYY-MM-DD hh:mm:ss
-(NSString *)cj_toString;
@end
