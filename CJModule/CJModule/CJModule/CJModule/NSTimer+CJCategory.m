//
//  NSTimer+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/5/21.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "NSTimer+CJCategory.h"

@implementation NSTimer (CJHandle)


-(void)cj_pause {
    [self setFireDate:[NSDate distantFuture]];
}


-(void)cj_continue {
    [self setFireDate:[NSDate date]];
}

@end
