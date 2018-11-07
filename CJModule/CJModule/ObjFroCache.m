//
//  ObjFroCache.m
//  CJModule
//
//  Created by 仁和Mac on 2018/8/6.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "ObjFroCache.h"
#import <objc/runtime.h>
#import "NSObject+CJCategory.h"

@implementation ObjFroCache

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [self cj_encodeWithCoder:aCoder];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {

    return [[super init] cj_initWithCoder:aDecoder];
}


@end
