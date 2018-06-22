//
//  CJReplicatorHeightLodingView.h
//  CommonProject
//
//  Created by 仁和Mac on 2017/5/30.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJReplicatorHeightLodingView : UIView

/// item的size。默认(2,20)
@property(nonatomic, assign) CGSize itemSize;

/// item的数量。默认7
@property(nonatomic, assign) NSUInteger itemCount;

/// 每个item的距离。 默认3
@property(nonatomic, assign) CGFloat itemSpace;

/// 动画时间。默认0.5f
@property(nonatomic, assign) NSTimeInterval duration;


@end
