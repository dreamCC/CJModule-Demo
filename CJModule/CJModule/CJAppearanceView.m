//
//  CJAppearanceView.m
//  CJModule
//
//  Created by 仁和Mac on 2018/6/22.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJAppearanceView.h"

@interface CJLayer:CALayer

@end

@implementation CJLayer

+(BOOL)needsDisplayForKey:(NSString *)key {
    return [key isEqualToString:@""] || [super needsDisplayForKey:key];
}

-(id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@""]) {
        CABasicAnimation *aniamtion = [CABasicAnimation animationWithKeyPath:event];
        aniamtion.duration = 1.f;
        aniamtion.toValue = [NSValue valueForKey:@""];
        return aniamtion;
    }
    return [super actionForKey:event];
}

-(void)drawInContext:(CGContextRef)ctx {
    
}

@end

@implementation CJAppearanceView (UIAppearance)

//+(void)initialize {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self appearance];
//    });
//
//}
//
//static CJAppearanceView *appearanceView;
//+(instancetype)appearance {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (!appearanceView) {
//            appearanceView = [[CJAppearanceView alloc] init];
//            appearanceView.cj_color = [UIColor grayColor];、
//        }
//    });
//    return appearanceView;
//}


@end


@implementation CJAppearanceView

+(void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self appearance];
    });
   

}

static CJAppearanceView *appearanceView;
+(instancetype)appearance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!appearanceView) {
            appearanceView = [[CJAppearanceView alloc] init];
            appearanceView.cj_color = [UIColor grayColor];
        }
    });
    return appearanceView;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (appearanceView) {
            self.cj_color = [CJAppearanceView appearance].cj_color;
            self.clipsToBounds = YES;
        }
    }
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
}

-(void)didMoveToWindow {
    [super didMoveToWindow];
}

-(void)didMoveToSuperview {
    [super didMoveToSuperview];
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
}

-(void)drawTextInRect:(CGRect)rect {
    
    [self.attributedText drawInRect:CGRectMake(-20, rect.origin.y, rect.size.width, rect.size.height)];
    
}


-(void)setCj_color:(UIColor *)cj_color {
    _cj_color = cj_color;
}






@end

