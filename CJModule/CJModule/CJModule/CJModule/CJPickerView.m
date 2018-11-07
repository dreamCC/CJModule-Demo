//
//  CJPickerView.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/5.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJPickerView.h"

@implementation CJPickerView


-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self setValue:_seperateLineColor forKey:@"magnifierLineColor"];
}
@end
