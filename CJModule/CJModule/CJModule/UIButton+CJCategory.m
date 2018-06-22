//
//  UIButton+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UIButton+CJCategory.h"
#import <objc/runtime.h>

@implementation UIButton (CJContentsPosition)

-(void)cj_changeImagePosition:(CJImagePosition)imagePosition {
    switch (imagePosition) {
        case CJImagePositionRight:
        {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.currentImage.size.width, 0, self.currentImage.size.width);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.intrinsicContentSize.width, 0, -self.titleLabel.intrinsicContentSize.width);
            
        }
            break;
        case CJImagePositionLeft:
            break;
        case CJImagePositionTop:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height-3, 0, 0, -self.titleLabel.intrinsicContentSize.width)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(self.currentImage.size.height+3, -self.currentImage.size.width, 0, 0)];
        }
            
            break;
        case CJImagePositionBottom:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -self.titleLabel.intrinsicContentSize.height, -self.titleLabel.intrinsicContentSize.width)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(-self.currentImage.size.width, -self.currentImage.size.height, 0, 0)];
            
        }
            break;
        default:
            break;
    }
}


-(void)setCj_textAlignment:(CJTextAlignment)cj_textAlignment {
    objc_setAssociatedObject(self, @selector(cj_textAlignment), @(cj_textAlignment), OBJC_ASSOCIATION_ASSIGN);
    switch (cj_textAlignment) {
        case CJTextAlignmentCenter:
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, 0)];
            break;
        case CJTextAlignmentLeft:
        {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(self.frame.size.width-self.titleLabel.frame.size.width)*0.5+(-self.imageView.frame.size.width), 0, 0)];
        }
            break;
        case CJTextAlignmentRight:
        {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, (self.frame.size.width-self.titleLabel.frame.size.width)*0.5+(-self.imageView.frame.size.width ), 0, 0)];
        }
            break;
        default:
            break;
    }
}

-(CJTextAlignment)cj_textAlignment {
    return [objc_getAssociatedObject(self, _cmd) intValue];
}


-(void)setCj_imageAlignment:(CJImageAlignment)cj_imageAlignment {
    objc_setAssociatedObject(self, @selector(cj_imageAlignment), @(cj_imageAlignment), OBJC_ASSOCIATION_ASSIGN);
     switch (cj_imageAlignment) {
        case CJImageAlignmentCenter:
             self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.titleLabel.intrinsicContentSize.width);
            break;
        case CJImageAlignmentLeft:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -(self.frame.size.width - self.currentImage.size.width)+(-self.titleLabel.frame.size.width), 0, 0)];
        }
            break;
        case CJImageAlignmentRight:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, (self.frame.size.width - self.currentImage.size.width)+(-self.titleLabel.frame.size.width), 0, 0)];
        }
            break;
        default:
            break;
    }
}

-(CJImageAlignment)cj_imageAlignment {
    return [objc_getAssociatedObject(self, _cmd) intValue];
}

@end




@implementation UIButton (CJResponseRect)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = [self class];
        SEL orgSel = @selector(pointInside:withEvent:);
        SEL swzSel = @selector(cj_pointInside:withEvent:);
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




-(BOOL)cj_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect newRect = [self cj_responseRect];
    if (CGRectEqualToRect(newRect, self.bounds)) {
        return [self cj_pointInside:point withEvent:event];
    }
    
    return CGRectContainsPoint(newRect, point) ?YES:NO;
}


-(CGRect)cj_responseRect {
    CGRect bounds = self.bounds;
    CGFloat cj_x  = bounds.origin.x + self.cj_response_left;
    CGFloat cj_y  = bounds.origin.y + self.cj_response_top;
    CGFloat cj_w  = bounds.size.width - self.cj_response_left + self.cj_response_right;
    CGFloat cj_h  = bounds.size.height - self.cj_response_top + self.cj_response_bottom;
    return CGRectMake(cj_x, cj_y, cj_w, cj_h);
}

#pragma mark ---- setter && getter


-(void)setCj_response_left:(CGFloat)cj_response_left {
    objc_setAssociatedObject(self, @selector(cj_response_left), @(cj_response_left), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)cj_response_left {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setCj_response_right:(CGFloat)cj_response_right {
    objc_setAssociatedObject(self, @selector(cj_response_right), @(cj_response_right), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)cj_response_right {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setCj_response_top:(CGFloat)cj_response_top {
    objc_setAssociatedObject(self, @selector(cj_response_top), @(cj_response_top), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)cj_response_top {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setCj_response_bottom:(CGFloat)cj_response_bottom {
    objc_setAssociatedObject(self, @selector(cj_response_bottom), @(cj_response_bottom), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)cj_response_bottom {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setCj_response_insets:(UIEdgeInsets)cj_response_insets {
    self.cj_response_left   = cj_response_insets.left;
    self.cj_response_top    = cj_response_insets.top;
    self.cj_response_right  = cj_response_insets.right;
    self.cj_response_bottom = cj_response_insets.bottom;
}

-(UIEdgeInsets)cj_response_insets {
    return UIEdgeInsetsMake(self.cj_response_top, self.cj_response_left, self.cj_response_bottom, self.cj_response_right);
}



@end

















