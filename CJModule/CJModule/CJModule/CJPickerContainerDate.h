//
//  CJPickerContainerDateView.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/12.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJPickerContainerView.h"

typedef NS_ENUM(NSUInteger, CJPickerContainerDateMode) {
    CJPickerContainerDateModeYear   = 0,
    CJPickerContainerDateModeMonth,
    CJPickerContainerDateModeDay,
    CJPickerContainerDateModeHour,
    CJPickerContainerDateModeMinute,
    CJPickerContainerDateModeSecond
};

@interface CJPickerContainerDate : CJPickerContainerView

/// date的类型
@property(nonatomic, assign, readonly) CJPickerContainerDateMode dateMode;

/// 日期
@property(nonatomic, strong, readonly) NSDate *date;

/// 最小时间
@property(nonatomic, strong) NSDate *minimunDate;

/// 最大时间
@property(nonatomic, strong) NSDate *maximunDate;


/**
 初始化方法

 @param style 样式
 @param currentDate 时间
 @param mode   模式
 @return self
 */
-(instancetype)initWithStyle:(CJPickerContainerViewStyle)style date:(NSDate *)currentDate mode:(CJPickerContainerDateMode)mode NS_DESIGNATED_INITIALIZER;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
+(instancetype)new NS_UNAVAILABLE;
@end
