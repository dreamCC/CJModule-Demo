//
//  NSArray+CJLog.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/24.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "NSArray+CJCategory.h"

@implementation NSArray (CJLog)

- (NSString *)descriptionWithLocale:(id)locale
{
    return [self cj_description];
}

-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    return [self cj_description];
}

-(NSString *)cj_description {
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"\n[\n"];
    
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

@end
