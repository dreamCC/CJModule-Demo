//
//  CJAppearanceView.m
//  CJModule
//
//  Created by 仁和Mac on 2018/6/22.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJAppearanceView.h"

@implementation CJAppearanceView (UIAppearance)

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
            self.clipsToBounds = YES;
            NSLog(@"initWithFrame-%@",self.cj_color);

        }
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        NSLog(@"initWithCoder-%@",self.cj_color);
        
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"awakeFromNib-%@",self.cj_color);


}

-(void)setCj_color:(UIColor *)cj_color {
    _cj_color = cj_color;
    self.backgroundColor = cj_color;
}


@end

