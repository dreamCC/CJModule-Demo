//
//  NSObject+CJCategory.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/12.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "NSObject+CJCategory.h"
#import <objc/runtime.h>

@implementation NSObject (CJObjcRuntime)

+(NSArray<NSString *> *)cj_ivarNames {
    NSMutableArray *ivarNames = [NSMutableArray array];
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const char *ivar_name = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:ivar_name];
        [ivarNames addObject:ivarName];
        
    }
    return ivarNames.copy;
}

+(NSDictionary<NSString *,NSString *> *)cj_ivarTypesAndNames {
    NSMutableDictionary *ivarNamesDic = [NSMutableDictionary dictionary];
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const char *ivar_name = ivar_getName(ivar);
        const char *ivar_type = ivar_getTypeEncoding(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:ivar_name];
        NSString *ivarType = [NSString stringWithUTF8String:ivar_type];
        [ivarNamesDic setValue:ivarName forKey:ivarType];
        
    }
    return ivarNamesDic.copy;
}



@end
