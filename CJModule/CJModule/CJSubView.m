//
//  CJSubView.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/23.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJSubView.h"

@implementation CJSubView

//-(void)setCj_subColor:(UIColor *)cj_subColor {
//    _cj_subColor = cj_subColor;
//    [self willChangeValueForKey:@"cj_color"];
//
//    _cj_color = [UIColor redColor];
//
//    [self didChangeValueForKey:@"cj_color"];
//}

+(NSSet<NSString *> *)keyPathsForValuesAffectingCj_color {
    return [[NSSet alloc] initWithObjects:@"cj_subColor", nil];
}


-(void)testCategoryMethod {
    NSLog(@"CJSubView--testCategoryMethod");
}

@end
