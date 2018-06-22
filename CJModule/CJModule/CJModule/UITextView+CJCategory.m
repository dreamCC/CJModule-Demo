//
//  UITextView+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UITextView+CJCategory.h"
#import "CJDefines.h"

@implementation UITextView (CJCategory)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CJSwizzleMethod([self class], @selector(setFont:), @selector(cj_setFont:));
    });
}

-(void)cj_setFont:(UIFont *)font {
    [self cj_setFont:font];
    UILabel *placeholder = [self cj_placeholderLab];
    placeholder.font = font;
}

#pragma mark - setter & getter
-(void)setCj_placeholder:(NSString *)cj_placeholder {
    UILabel *placeholder = [self cj_placeholderLab];
    placeholder.text = cj_placeholder;
}

-(NSString *)cj_placeholder {
    return self.cj_placeholderLab.text;
}


-(void)setCj_placeholderColor:(UIColor *)cj_placeholderColor {
    UILabel *placeholder = [self cj_placeholderLab];
    placeholder.textColor = cj_placeholderColor;
}

-(UIColor *)cj_placeholderColor {
    return self.cj_placeholderLab.textColor;
}


#pragma mark - private method
-(UILabel *)cj_placeholderLab {
    UILabel *placeholderLab = objc_getAssociatedObject(self, _cmd);
    if (!placeholderLab) {
        placeholderLab = [UILabel new];
        placeholderLab.textColor = [UIColor lightGrayColor];
        [placeholderLab sizeToFit];
        [self setValue:placeholderLab forKey:@"_placeholderLabel"];
        [self addSubview:placeholderLab];
        objc_setAssociatedObject(self, _cmd, placeholderLab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return placeholderLab;
}


@end
