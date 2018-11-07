//
//  NSArray+CJLog.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/24.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CJLog)

@end


@interface NSArray (CJLetter)


/**
 通过首字母的形式将数组重写排序


 排序后数组的格式和规则为:
 
 [
    @{
        @"firstLetter": @"A",
        @"content": @[@"啊", @"阿狸"]
    },
    @{
        @"firstLetter": @"B",
        @"content": @[@"部落", @"帮派"]
    },
    ...
 ]
 
 只会出现有对应元素的字母字典, 例如: 如果没有对应 @"C"的字符串出现, 则数组内也不会出现 @"C"的字典.
 数组内字典的顺序按照26个字母的顺序排序
 @"#"对应的字典永远出现在数组最后一位

 @return 新数组
 */
-(NSArray *)cj_sortArryWithFirstLetter;

@end
