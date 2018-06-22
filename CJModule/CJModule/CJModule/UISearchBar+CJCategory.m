//
//  UISearchBar+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/6/6.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UISearchBar+CJCategory.h"
#import <objc/runtime.h>

@implementation UISearchBar (CJCategory)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        Class cls = [self class];
        SEL orgSel = @selector(layoutSubviews);
        SEL swzSel = @selector(cj_layoutSubviews);
        Method orgMethod = class_getInstanceMethod(cls, orgSel);
        Method swzMethod = class_getInstanceMethod(cls, swzSel);
        IMP orgImp = method_getImplementation(orgMethod);
        IMP swzImp = method_getImplementation(swzMethod);
        BOOL isAdd = class_addMethod(cls, orgSel, swzImp, method_getTypeEncoding(swzMethod));
        if (isAdd) {
            class_replaceMethod(cls, swzSel, orgImp, method_getTypeEncoding(orgMethod));
        }else {
            method_exchangeImplementations(orgMethod, swzMethod);
        }
        
    });
    
}

-(void)cj_layoutSubviews {
    [self cj_layoutSubviews];
    
    if (self.cj_rightView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cj_searchTextField.rightView     = self.cj_rightView;
            self.cj_searchTextField.rightViewMode = self.cj_rightViewMode;
        });
    };

    if (self.cj_placeholderPosition == CJSearchBarPlaceholderPositionCenter) {
        CGSize textFieldSize = self.cj_searchTextField.bounds.size;
        CGSize placeholderSize = self.cj_placeholderLabel.bounds.size;
        CGSize searchSize    = self.cj_searchTextField.leftView.bounds.size;
        CGFloat moveX   = textFieldSize.width * 0.5 - (searchSize.width + placeholderSize.width)*0.5;
        self.searchTextPositionAdjustment = UIOffsetMake(moveX + 10, 0);
        [self setPositionAdjustment:UIOffsetMake(moveX, 0) forSearchBarIcon:UISearchBarIconSearch];
    }else if (self.cj_placeholderPosition == CJSearchBarPlaceholderPositionLeft) {
        self.searchTextPositionAdjustment = UIOffsetMake(10, 0);
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
    
}


-(void)setCj_searchTextFieldRightView:(UIView *)view mode:(UITextFieldViewMode)mode {
    [self setCj_rightView:view];
    [self setCj_rightViewMode:mode];
}


#pragma mark --- setter && getter
-(UITextField *)cj_searchTextField {
    UITextField *field = [self valueForKey:@"searchField"];
    return field;
}

-(UILabel *)cj_placeholderLabel {
    return [self.cj_searchTextField valueForKey:@"placeholderLabel"];
}

static char kAssociated_cj_rightView;
-(void)setCj_rightView:(UIView *)view {
    objc_setAssociatedObject(self, &kAssociated_cj_rightView, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)cj_rightView {
    return objc_getAssociatedObject(self, &kAssociated_cj_rightView);
}

static char kAssociated_cj_rightViewMode;
-(void)setCj_rightViewMode:(UITextFieldViewMode)mode {
    objc_setAssociatedObject(self, &kAssociated_cj_rightViewMode, @(mode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UITextFieldViewMode)cj_rightViewMode {
    return [objc_getAssociatedObject(self, &kAssociated_cj_rightViewMode) integerValue];
}


static char kAssociate_cj_placeholderColor;
-(void)setCj_placeholderColor:(UIColor *)cj_placeholderColor {
    objc_setAssociatedObject(self, &kAssociate_cj_placeholderColor, cj_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.cj_placeholderLabel.textColor = cj_placeholderColor;
}
-(UIColor *)cj_placeholderColor {
    return objc_getAssociatedObject(self, &kAssociate_cj_placeholderColor);
}

static char kAssociate_cj_textColor;
-(void)setCj_textColor:(UIColor *)cj_textColor {
    objc_setAssociatedObject(self, &kAssociate_cj_textColor, cj_textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.cj_searchTextField.textColor = cj_textColor;
}

-(UIColor *)cj_textColor {
    return objc_getAssociatedObject(self, &kAssociate_cj_textColor);
}

static char kAssociate_cj_placeholderPosition;
-(void)setCj_placeholderPosition:(CJSearchBarPlaceholderPosition)cj_placeholderPosition {
    objc_setAssociatedObject(self, &kAssociate_cj_placeholderPosition, @(cj_placeholderPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

-(CJSearchBarPlaceholderPosition)cj_placeholderPosition {
    return [objc_getAssociatedObject(self, &kAssociate_cj_placeholderPosition) integerValue];
}



@end
