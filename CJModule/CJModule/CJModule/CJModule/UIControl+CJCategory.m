//
//  UIControl+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/8.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UIControl+CJCategory.h"
#import "CJDefines.h"

@implementation UIControl (CJCategory)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CJSwizzleMethod([self class], @selector(sendAction:to:forEvent:), @selector(cj_sendAction:to:forEvent:));
    });
}


-(void)cj_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.cj_acceptEventTime < self.cj_acceptEventInterval) {
        return;
    }
    
    if (self.cj_acceptEventInterval > 0) {
        self.cj_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }

    [self cj_sendAction:action to:target forEvent:event];
}

#pragma mark --- setter && getter
-(void)setCj_acceptEventInterval:(NSTimeInterval)cj_acceptEventInterval {
    objc_setAssociatedObject(self, @selector(cj_acceptEventInterval), @(cj_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimeInterval)cj_acceptEventInterval {
    NSNumber *value = (NSNumber *)objc_getAssociatedObject(self, _cmd);
    return [value doubleValue];
}

-(void)setCj_acceptEventTime:(NSTimeInterval)cj_acceptEventTime {
    objc_setAssociatedObject(self, @selector(cj_acceptEventTime), @(cj_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimeInterval)cj_acceptEventTime {
    NSNumber *value = objc_getAssociatedObject(self, _cmd);
    return [value doubleValue];
}
@end
