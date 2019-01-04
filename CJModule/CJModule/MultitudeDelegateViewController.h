//
//  MultitudeDelegateViewController.h
//  CJModule
//
//  Created by 仁和Mac on 2018/11/26.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultitudeDelegateViewController : QMUICommonViewController

@property (nonatomic, copy) void(^clickEnterBlock)(MultitudeDelegateViewController *mul);

@end

NS_ASSUME_NONNULL_END
