//
//  UITextView+CJCategory.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (CJCategory)

/// placeholder文字。注意：使用该属性必须要设置textView.font
@property(nonatomic, strong) NSString *cj_placeholder;

/// palceholder颜色
@property(nonatomic, strong) UIColor *cj_placeholderColor;

@end
