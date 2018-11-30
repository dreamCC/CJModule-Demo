//
//  CJPasswordTextField.h
//  CJModule
//
//  Created by 仁和Mac on 2017/11/28.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol CJPasswordTextFieldDelegate <NSObject>

// 文本输入
-(void)passwordTextDidInsertText:(NSString *)text range:(NSRange)range;

// 文本删除
-(void)passwordTextDidDeleteText:(NSString *)text range:(NSRange)range;

@end



@interface CJPasswordTextField : UIControl<UIKeyInput>

@property(nonatomic, weak) id<CJPasswordTextFieldDelegate> delegate;


// 字体。默认 = [UIFont systemFontOfSize:16]
@property(nonatomic, strong) UIFont *font;

// 文字
@property(nonatomic, strong) NSString *text;

// 字体颜色。默认 = [UIColor colorWithRed:ren30/255.0 green:32/255.0 blue:40/255.0 alpha:1]
@property(nonatomic, strong) UIColor *textColor;

// 密码长度。默认 = 6
@property(nonatomic, assign) NSUInteger passwordLength;

// 密码框间的间距。 默认 = 0
@property(nonatomic, assign) CGFloat passwordBoxSpace;

// 密码框的宽度。默认 = 1
@property(nonatomic, assign) CGFloat passwordBoxLayerWidth;

// 密码框颜色。默认 = [UIColor colorWithRed:89/255.0 green:88/255.0 blue:89/255.0 alpha:1]
@property(nonatomic, strong) UIColor *passwordBoxColor;

// 密文输入时，小黑点的尺寸。默认 = CGSizeMake(10, 10)。注意，设置该属性时候，必须要保证self.secureTextEntry = YES;
@property(nonatomic, assign) CGSize secureDotSize;

// 密文输入时，小黑点的颜色。默认 = _textColor。注意，设置该属性时候，必须要保证self.secureTextEntry = YES;
@property(nonatomic, strong) UIColor *secureDotColor;

// 是否显示光标。默认 = YES，光标的颜色 = self.tintColor
@property(nonatomic, assign, getter=isShowingCursor) BOOL showingCursor;

/**
 初始化方法

 @param frame frame
 @param passwordLength 密码长度
 @return returnType
 */
-(instancetype)initWithFrame:(CGRect)frame passwordLength:(NSUInteger)passwordLength;
@end

NS_ASSUME_NONNULL_END
