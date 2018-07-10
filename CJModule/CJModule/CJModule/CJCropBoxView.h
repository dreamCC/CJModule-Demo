//
//  CJCropBoxView.h
//  CJModule
//
//  Created by 仁和Mac on 2018/7/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJCropBoxView : UIView

/// 几个角的线宽,默认 4.f
@property(nonatomic, assign) CGFloat cornerLineWidth;

/// 几个角的线高, 默认20.f
@property(nonatomic, assign) CGFloat cornerLineHeight;

/// 剪切线的线宽 默认 2.f
@property(nonatomic, assign) CGFloat cropBoardLineWidth;

/// 是否有剪切框内部的网状线。默认是YES。
@property(nonatomic, assign, getter=hasInsideMesh) BOOL insideMesh;

/// 剪切框内部网状线有几条。默认2条。如果insieMeshRowAndLine > 0 。那么insiMesh = YES。
@property(nonatomic, assign) NSUInteger insideMeshRowAndLine;

/// 剪切框内部网状线宽度。默认是1.f
@property(nonatomic, assign) CGFloat insideMeshLineWidth;

/// 剪切的最小区域。默认{60，60}，不能小于{2*cornerLineHeight，2*cornerLineHeight}。
@property(nonatomic, assign) CGSize minCropArea;

/// 裁剪框改变。包括拖动裁剪框或者拖动裁剪框几个角
@property (nonatomic, copy) void(^cropBoxChanging)(void);
@end
