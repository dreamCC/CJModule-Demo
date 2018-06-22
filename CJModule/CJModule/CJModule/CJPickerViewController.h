//
//  CJPickerViewController.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/3.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJPickerContainerView.h"



@interface CJPickerViewController : UIViewController

/// pickerContainerView高度
@property(nonatomic, assign) CGFloat pickerContainerViewH;

/// pickerView
@property(nonatomic, strong) CJPickerContainerView *pickerContainerView;

/**
 初始化方法

 @param pickerContainerView pickerContainerView
 @return self
 */
-(instancetype)initWithPickerView:(CJPickerContainerView *)pickerContainerView pickerViewHeight:(CGFloat)pickerViewH;

@end
