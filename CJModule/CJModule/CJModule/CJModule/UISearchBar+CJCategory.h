//
//  UISearchBar+CJCategory.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/6/6.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJSearchBarPlaceholderPosition) {
    CJSearchBarPlaceholderPositionCenter = 1,
    CJSearchBarPlaceholderPositionLeft // Default
};

@interface UISearchBar (CJCategory)


/// textField
@property(nonatomic,weak,readonly) UITextField *cj_searchTextField;

/// placeHolderLable
@property(nonatomic,weak,readonly) UILabel *cj_placeholderLabel;

/// placeholderColor
@property(nonatomic, strong) UIColor *cj_placeholderColor;

/// textColor
@property(nonatomic, strong) UIColor *cj_textColor;

/// 占位时候，位置
@property(nonatomic, assign) CJSearchBarPlaceholderPosition cj_placeholderPosition;


/**
 给searchBar添加rightView。

 @param view view
 @param mode mode
 */
-(void)setCj_searchTextFieldRightView:(UIView *)view mode:(UITextFieldViewMode)mode;
@end
