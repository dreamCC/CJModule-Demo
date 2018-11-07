//
//  CJGridView.h
//  CommonProject
//
//  Created by 仁和Mac on 2017/6/9.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJGridView : UIView

/// 多少列，默认3
@property(nonatomic, assign) NSUInteger colum;

/// 内部每个item高度，默认50。如果item设置size。那么itemHeight由size决定。
@property(nonatomic, assign) CGFloat itemHeight;

/// 分隔线宽度，默认0，不显示分割线
@property(nonatomic, assign) CGFloat seperateWide;

/// 分隔线颜色，默认lightGrayColor
@property(nonatomic, strong) UIColor *seperateColor;

/// 需要手动设置，分隔线是虚线
@property(nonatomic, strong) NSArray<NSNumber *> *seperateDashPattern;


/**
 通过多少列来初始化

 @param frame frame
 @param colum 列
 @return self
 */
-(instancetype)initWithFrame:(CGRect)frame colum:(NSUInteger)colum;
@end
