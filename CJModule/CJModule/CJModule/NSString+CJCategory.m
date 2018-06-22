//
//  NSString+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/2/28.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "NSString+CJCategory.h"


@implementation NSString (CJCalculate)

-(CGFloat)cj_stringWidthFontSize:(CGFloat)fontSize height:(CGFloat)height {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    CGRect stringRect = [self cj_stringRectFontSize:fontSize size:size];
    return stringRect.size.width;
}


-(CGFloat)cj_stringHeightFontSize:(CGFloat)fontSize width:(CGFloat)width {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    CGRect stingRect = [self cj_stringRectFontSize:fontSize size:size];
    return stingRect.size.height;
}


-(CGRect)cj_stringRectFontSize:(CGFloat)fontSize size:(CGSize)size {
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
}

@end

@implementation NSString (CJRegex)

-(BOOL)cj_isValidMobilePhoneNum {
    NSString *regexString = @"^1[3578]\\d{9}$";
    return [self cj_verifyWithRegexString:regexString];
}


-(CJPhoneOperatorsType)cj_phoneOperatorsType {
    // 移动
    NSString *mobile = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
    // 联通
    NSString *unicom = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    // 电信
    NSString *telecom = @"^1((33|53|77|8[09])\\d|349|700)\\d{7}$";
    // 固定电话及小灵通
    NSString *telephone = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    if ([self cj_verifyWithRegexString:mobile]) {
        return CJPhoneOperatorsMobile;
    } else if ([self cj_verifyWithRegexString:unicom]) {
        return CJPhoneOperatorsUnicom;
    }else if ([self cj_verifyWithRegexString:telecom]) {
        return CJPhoneOperatorsTelecom;
    }else if ([self cj_verifyWithRegexString:telephone]) {
        return CJPhoneOperatorsTelephone;
    }else {
        return CJPhoneOperatorsUnkonwn;
    }
}

-(BOOL)cj_isValidEmail {
    NSString *regexString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self cj_verifyWithRegexString:regexString];
}

-(BOOL)cj_isValidCarLicense {
    NSString *regexString = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    return [self cj_verifyWithRegexString:regexString];
}

-(BOOL)cj_isValidIdentityCard {
    NSString *regexString = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self cj_verifyWithRegexString:regexString];
}

-(BOOL)cj_verifyWithRegexString:(NSString *)regexString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexString];
    return [predicate evaluateWithObject:self];
}
@end
