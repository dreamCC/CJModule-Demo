//
//  CJDownloadSource.m
//  CommonProject
//
//  Created by 仁和Mac on 2017/2/2.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJDownloadSource.h"
#import <objc/runtime.h>

@implementation CJDownloadSource

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        unsigned int outCount;
        Ivar *ivars   = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            const char *ivar_name  = ivar_getName(ivar);
            NSString *propertyName = [NSString stringWithUTF8String:ivar_name];
            id value = [aDecoder decodeObjectForKey:propertyName];
            [self setValue:value forKey:propertyName];
        }
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount;
    Ivar *ivars   = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const char *ivar_name  = ivar_getName(ivar);
        NSString *propertyName = [NSString stringWithUTF8String:ivar_name];
        id value  = [self valueForKey:propertyName];
        [aCoder encodeObject:value forKey:propertyName];
    }
    
}

@end
