//
//  NSDictionary+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/13.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "NSDictionary+CJCategory.h"

@implementation NSDictionary (CJLog)

-(NSString *)descriptionWithLocale:(id)locale {
    
    return [self cj_description];
}

// 输出台po命令输出
-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self cj_description];
}

-(NSString *)cj_description {
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"\n{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" = "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

@end

@implementation NSDictionary (CJConvert)

-(NSString *)cj_convertToJsonString {
    return [self cj_convertToJsonStringWithOptions:NSJSONWritingSortedKeys];
}

-(NSString *)cj_convertToPrettyPrintJsonString {
    return [self cj_convertToJsonStringWithOptions:NSJSONWritingPrettyPrinted];
}

-(NSString *)cj_convertToJsonStringWithOptions:(NSJSONWritingOptions)options {
    if (![NSJSONSerialization isValidJSONObject:self]) return nil;
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:options error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return string;
}
@end
