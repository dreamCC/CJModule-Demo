//
//  NSString+CJCategory.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/2/28.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (CJCalculate)

/**
 计算字符串长度

 @param fontSize 字体大小
 @param height 字符串内容的高度（比如：如果在Lable里面，传的就是lable的高度）
 @return 长度
 */
-(CGFloat)cj_stringWidthFontSize:(CGFloat)fontSize height:(CGFloat)height;


/**
 计算字符串高度

 @param fontSize 字体大小
 @param width 字符串宽度
 @return 长度
 */
-(CGFloat)cj_stringHeightFontSize:(CGFloat)fontSize width:(CGFloat)width;



/**
 字符串rect

 @param fontSize 字体大小
 @param size 尺寸
 @return 字体rect
 */
-(CGRect)cj_stringRectFontSize:(CGFloat)fontSize size:(CGSize)size;

@end



typedef NS_ENUM(NSUInteger, CJPhoneOperatorsType) {
    CJPhoneOperatorsUnkonwn, // 未知
    CJPhoneOperatorsMobile,  // 移动
    CJPhoneOperatorsTelecom, // 电信
    CJPhoneOperatorsUnicom,  // 联通
    CJPhoneOperatorsTelephone // 固定电话、小灵通
};
@interface NSString (CJRegex)

/**
 是否是有效的手机号码
 */
-(BOOL)cj_isValidMobilePhoneNum;



/**
 * 获取手机号码运营商
 
 * 手机号码
 * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
 * 联通：130,131,132,152,155,156,185,186,1709
 * 电信：133,1349,153,177,180,189,1700
 *
 *
 * 大陆地区固话及小灵通
 * 区号：010,020,021,022,023,024,025,027,028,029
 * 号码：七位或八位

 @return 运营商类型
 */
-(CJPhoneOperatorsType)cj_phoneOperatorsType;


/**
 是否为邮箱

 @return 结果
 */
-(BOOL)cj_isValidEmail;


/**
 是否为车牌号

 @return 结果
 */
-(BOOL)cj_isValidCarLicense;


/**
 是否为身份证

 @return 结果
 */
-(BOOL)cj_isValidIdentityCard;


@end

@interface NSString (CJLetter)


/**
 获取字符串的首字母，以大写的形式返回。
 1、如果字符串是汉字开头，则返回汉字的首字母大写。如"你好"->"N"
 2、如果字符串是字母开头，则返回字母的大写。如"h你好"->"H"
 3、如果字符串首字母不是汉字也不是字母，则返回"#"。如"^你好"->"#"。
 
 @return 字符串的首字母
 */
-(NSString *)cj_firstLetter;

@end




