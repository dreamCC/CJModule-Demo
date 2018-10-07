//
//  CJCountingLable.m
//  CJModule
//
//  Created by 仁和Mac on 2018/9/27.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJCountingLable.h"

@interface CJCountingLable()

@property(nonatomic,strong) CADisplayLink *displayLink;

@end

@implementation CJCountingLable

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self didInitialize];
    }
    return self;
}


#pragma mark ---- public method
-(void)countFromValue:(NSString *)fromValue toValue:(NSString *)toValue {
    if (!self.countingRange) {
        @throw [NSException exceptionWithName:@"CJCountingLable's countingRange" reason:@"countingRange is not set or set zero. countingRange must be not zero or nil" userInfo:nil];
    }
    if (![self validateNumberString:fromValue]) {
        @throw [NSException exceptionWithName:@"CJCountingLable's fromValue" reason:@"fromValue  must be numbers" userInfo:nil];
    }
    
    if (![self validateNumberString:toValue]) {
        @throw [NSException exceptionWithName:@"CJCountingLable's countingRange" reason:@"fromValue  must be numbers" userInfo:nil];
    }
    self.text = fromValue;
    self.displayLink.frameInterval = _countingSpeed;
    [self.displayLink setPaused:NO];
}


#pragma mark ---- private method
-(void)didInitialize {
    self.textAlignment = NSTextAlignmentCenter;
    
    self.countingSpeed = 2;
}

-(void)updateLableText {
    
    self.text = [NSString stringWithFormat:@"%.2f",self.text.floatValue + self.countingRange];
}

-(BOOL)validateNumberString:(NSString *)value {
    NSString *regularString = @"^\\d+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regularString];
    return [predicate evaluateWithObject:value];
}


#pragma mark ---- getter
-(CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLableText)];
        _displayLink.paused = YES;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}

@end
