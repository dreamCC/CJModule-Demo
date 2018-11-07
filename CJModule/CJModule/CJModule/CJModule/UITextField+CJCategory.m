//
//  UITextField+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/4/10.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UITextField+CJCategory.h"
#import "CJDefines.h"

@implementation UITextField (CJCategory)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CJSwizzleMethod(self, @selector(leftViewRectForBounds:), @selector(cj_leftViewRectForBounds:));
        CJSwizzleMethod(self, @selector(rightViewRectForBounds:), @selector(cj_rightViewRectForBounds:));
        CJSwizzleMethod(self, @selector(textRectForBounds:), @selector(cj_textRectForBounds:));
        CJSwizzleMethod(self, @selector(editingRectForBounds:), @selector(cj_editingRectForBounds:));
    });
}

-(CGRect)cj_textRectForBounds:(CGRect)bounds {
    
    CGFloat imgW = self.leftView.frame.size.width;
    
    return CGRectOffset(bounds, self.cj_leftView_offset + imgW + self.cj_text_offset, 0);
}

-(CGRect)cj_editingRectForBounds:(CGRect)bounds {
    CGFloat imgW = self.leftView.frame.size.width;
    
    return CGRectOffset(bounds, self.cj_leftView_offset + imgW + self.cj_text_offset, 0);
}

-(CGRect)cj_rightViewRectForBounds:(CGRect)bounds {
    CGRect rect = [self cj_rightViewRectForBounds:bounds];
    return CGRectOffset(rect, self.cj_rightView_offset, 0);
}

-(CGRect)cj_leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [self cj_leftViewRectForBounds:bounds];
    return CGRectOffset(rect, self.cj_leftView_offset, 0);
}


#pragma mark --- setter && getter
-(CGFloat)cj_leftView_offset {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setCj_leftView_offset:(CGFloat)cj_leftView_offset {
    objc_setAssociatedObject(self, @selector(cj_leftView_offset), @(cj_leftView_offset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)cj_rightView_offset {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setCj_rightView_offset:(CGFloat)cj_rightView_offset {
    objc_setAssociatedObject(self, @selector(cj_rightView_offset), @(cj_rightView_offset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)cj_text_offset {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setCj_text_offset:(CGFloat)cj_text_offset {
    objc_setAssociatedObject(self, @selector(cj_text_offset), @(cj_text_offset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
