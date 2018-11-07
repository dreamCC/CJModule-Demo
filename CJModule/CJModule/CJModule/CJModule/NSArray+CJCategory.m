//
//  NSArray+CJLog.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/24.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "NSArray+CJCategory.h"
#import "NSString+CJCategory.h"

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

@implementation NSArray (CJLetter)

-(NSArray *)cj_sortArryWithFirstLetter {
    if (![self count]) {
        return [NSMutableArray array];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSMutableArray array] forKey:@"#"];
    for (int i = 'A'; i <= 'Z'; i++) {
        [dict setObject:[NSMutableArray array]
                 forKey:[NSString stringWithUTF8String:(const char *)&i]];
    }
    
    for (NSString *words in self) {
        NSString *firstLetter = [words cj_firstLetter];
        NSMutableArray *array = dict[firstLetter];
        [array addObject:words];
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i = 'A'; i <= 'Z'; i++) {
        NSString *firstLetter = [NSString stringWithUTF8String:(const char *)&i];
        NSMutableArray *array = dict[firstLetter];
        if ([array count]) {
            [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSString *word1 = obj1;
                NSString *word2 = obj2;
                return [word1 localizedCompare:word2];
            }];
            NSDictionary *resultDict = @{@"firstLetter": firstLetter,
                                         @"content": array};
            [resultArray addObject:resultDict];
        }
    }
    
    if ([dict[@"#"] count]) {
        NSMutableArray *array = dict[@"#"];
        [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString *word1 = obj1;
            NSString *word2 = obj2;
            return [word1 localizedCompare:word2];
        }];
        NSDictionary *resultDict = @{@"firstLetter": @"#",
                                     @"content": array};
        [resultArray addObject:resultDict];
    }
    return resultArray;
}

@end




