//
//  UIButton+CJCategory.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJImagePosition) {
    CJImagePositionRight, // 图片在右,默认
    CJImagePositionLeft,
    CJImagePositionTop,
    CJImagePositionBottom
};

typedef NS_ENUM(NSUInteger, CJTextAlignment) {
    CJTextAlignmentCenter, // 如果没有图片,默认居中
    CJTextAlignmentLeft,
    CJTextAlignmentRight
};

typedef NS_ENUM(NSUInteger, CJImageAlignment) {
    CJImageAlignmentCenter, // 如果没有文字,默认居中
    CJImageAlignmentLeft,
    CJImageAlignmentRight
};
@interface UIButton (CJContentsPosition)

/// 文字位置
@property(nonatomic, assign) CJTextAlignment cj_textAlignment;

/// 图片位置
@property(nonatomic, assign) CJImageAlignment cj_imageAlignment;



/**
 改变图片和文字的位置。

 @param imagePosition 图片的位置。
 */
-(void)cj_changeImagePosition:(CJImagePosition)imagePosition;

@end


/**************************按钮的响应区域***********************************/
@interface UIButton (CJResponseRect)

/// 左边 +缩小，-扩大
@property(nonatomic, assign) CGFloat cj_response_left;

/// 右边 +扩大，-缩小
@property(nonatomic, assign) CGFloat cj_response_right;

/// 上边 +缩小，-扩大
@property(nonatomic, assign) CGFloat cj_response_top;

/// 下边 +扩大，-缩小
@property(nonatomic, assign) CGFloat cj_response_bottom;

/// 四周边界
@property(nonatomic, assign) UIEdgeInsets cj_response_insets;

@end



