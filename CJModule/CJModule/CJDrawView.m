//
//  CJDrawView.m
//  CJModule
//
//  Created by 仁和Mac on 2018/8/3.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJDrawView.h"

static CJDrawView *drawView;
@implementation CJDrawView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self && drawView) {
        self.cj_backColor = [CJDrawView appearance].cj_backColor;
    }
    return self;
}

@end


@implementation CJDrawView (UIAppearance)

+(void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self appearance];
    });
}

+(instancetype)appearance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!drawView) {
            drawView = [[CJDrawView alloc] init];
            
            drawView.cj_backColor = [UIColor redColor];
        }
    });
    return drawView;
}

@end

