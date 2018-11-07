//
//  ObjFroCache.h
//  CJModule
//
//  Created by 仁和Mac on 2018/8/6.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjFroCache : NSObject<NSCoding>

@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) NSString *height;

@property(nonatomic, assign) int age;

@end
