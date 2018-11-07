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


@interface NSObject (CJCoding)


/**
 对对象进行归档，常用于遵循 NSCoding 协议的类，进行归档的方法中。

 @param aCoder 归档器
 */
-(void)cj_encodeWithCoder:(NSCoder *)aCoder;


/**
 对对象进行解档，常用于遵循 NSCoding 协议的类，进行解档的方法中。
 通过，[[super init] cj_initWithCoder:adecoder]; 调用。
 
 @param aDecoder 解档器
 */
-(instancetype)cj_initWithCoder:(NSCoder *)aDecoder;


@end


