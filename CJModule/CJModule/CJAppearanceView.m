//
//  CJAppearanceView.m
//  CJModule
//
//  Created by 仁和Mac on 2018/6/22.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJAppearanceView.h"
#import <Masonry.h>

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


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
    
        
    }
    return self;
}




@end

