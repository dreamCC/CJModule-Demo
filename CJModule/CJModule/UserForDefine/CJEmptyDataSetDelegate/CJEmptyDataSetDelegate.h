//
//  CJEmptyDataSetDelegate.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/4/16.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIScrollView+EmptyDataSet.h>

@interface CJEmptyDataSetDelegate : NSObject<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/// 是否显示小菊花，默认是显示，整个界面呈现加载状态
@property(nonatomic, assign) BOOL activityShow;

/// 提示信息
@property(nonatomic, strong) NSString *hintDesc;

/// 按钮文字，默认是、、 重新加载
@property(nonatomic, strong) NSString *buttonTitle;



/**
 初始化方法

 @param buttonClick 按钮点击
 @return self ===  该对象需要强引用
 */
-(instancetype)initWithButtonClick:(void(^)(void))buttonClick;

@end
