//
//  NSDictionary+CJCategory.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/13.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CJLog)

@end

@interface NSDictionary (CJConvert)

/**
 转换成json字符串
 
 @return 字符串
 */
-(NSString *)cj_convertToJsonString;


/**
 转换成有格式的json字符串，跟上面方法的唯一不同点，下面会格式化，上面的方法就是输出一行。

 @return 字符串
 */
-(NSString *)cj_convertToPrettyPrintJsonString;
@end

