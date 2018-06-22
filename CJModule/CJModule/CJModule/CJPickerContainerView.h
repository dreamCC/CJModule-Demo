//
//  CJPickerView.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/3.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJPickerView.h"

typedef NS_ENUM(NSUInteger, CJPickerContainerViewStyle) {
    CJPickerContainerViewStyleAlert,
    CJPickerContainerViewStyleActionSheet
};

typedef NS_ENUM(NSUInteger, CJPickerContainerViewToolBarPosition) {
    CJPickerContainerViewToolBarPositionTop,
    CJPickerContainerViewToolBarPositionBottom
};


@protocol CJPickerContainerViewDelegate, CJPickerContainerViewDataSource;
@interface CJPickerContainerView : UIView

@property(nonatomic, strong) CJPickerView *pikerView;

/// 标题
@property(nonatomic, weak) UILabel *titleLab;

/// 内容字体的大小, 默认15
@property(nonatomic, assign) CGFloat fontSize;

/// 内容文字颜色，默认black
@property(nonatomic, strong) UIColor *fontColor;

/// 分隔线颜色，默认系统自带
@property(nonatomic, strong) UIColor *seperateLineColor;

/// pikerView的样式,default CJPickerViewStyleActionSheet
@property(nonatomic, assign) CJPickerContainerViewStyle pickerContainerViewStyle;

/// toolBar的位置，默认CJPickerContainerViewToolBarPositionBottom
@property(nonatomic, assign) CJPickerContainerViewToolBarPosition toolBarPosition;

@property(nonatomic, weak) id<CJPickerContainerViewDelegate> delegate;
@property(nonatomic, weak) id<CJPickerContainerViewDataSource> dataSource;




/**
 初始化方法

 @param style 样式，默认CJPickerContainerViewStyleActionSheet
 @return self
 */
-(instancetype)initWithStyle:(CJPickerContainerViewStyle)style;



/**
 隐藏
 */
-(void)dismissWithAnimated:(BOOL)animated;
@end

@protocol CJPickerContainerViewDelegate <NSObject>

-(void)cj_pickerContainerViewDidCancel:(CJPickerContainerView *)containerView;

-(void)cj_pickerContainerView:(CJPickerContainerView *)containerView didFinishWithInfo:(NSArray<NSString *> *)selectInfo;

@end



@protocol CJPickerContainerViewDataSource <NSObject>
@required
-(NSInteger)cj_numberOfComponentsInPickerContainerView:(CJPickerContainerView *)pickerContainerView;
-(NSInteger)cj_pickerContainerView:(CJPickerContainerView *)pickerContainerView numberOfRowsInComponent:(NSInteger)component;

@optional
-(NSArray<NSString *> *)cj_pickerContainerView:(CJPickerContainerView *)pickerContainerView titlesForComponent:(NSInteger)component;
@end

