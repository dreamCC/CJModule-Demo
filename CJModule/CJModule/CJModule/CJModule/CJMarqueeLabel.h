//
//  CJMarqueeLabel.h
//  CJModule
//
//  Created by 仁和Mac on 2017/6/23.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJMarqueeLabel : UILabel


/**
 暂停的时间间隔，默认2.5f
 */
@property(nonatomic, assign) NSTimeInterval cj_pauseTimeInterval;


/**
 滚动速度，默认0.5f
 */
@property(nonatomic, assign) CGFloat cj_speed;

/**
 头尾间距，默认40
 */
@property(nonatomic, assign) CGFloat cj_spacesForHeaderToTrail;


/**
 是否自动播放，如果textWidth 比label长，那么默认YES，否则为 NO
 */
@property(nonatomic, assign, readonly) BOOL cj_autoPlay;

@end
