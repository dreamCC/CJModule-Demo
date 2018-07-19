//
//  NSObject+CJCategory.h
//  CJModule
//
//  Created by 仁和Mac on 2018/7/12.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CJObjcRuntime)



/**
 获取所有ivar的name
 
 @return ivarNames
 */
+(NSArray<NSString *> *)cj_ivarNames;

/**
 获取所有ivar的type和name

 @return ivarNameDic
 */
+(NSDictionary<NSString *,NSString *> *)cj_ivarTypesAndNames;


@end
