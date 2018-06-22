//
//  MJRefreshFooter+CJAutoFooter.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "MJRefreshFooter+CJCategory.h"
#import "CJDefines.h"


@implementation MJRefreshFooter (CJAutoFooter)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CJSwizzleMethod([self class], @selector(endRefreshingWithNoMoreData), @selector(cj_endRefreshingWithNoMoreData));
    });
}

-(void)cj_endRefreshingWithNoMoreData {
    [self cj_endRefreshingWithNoMoreData];
    if (![self.superview isKindOfClass:[UITableView class]]) return;
    
    UITableView *tableV = (UITableView *)self.superview;
    if (tableV.contentOffset.x > 0) return;
    
    CGRect convertRect = [self convertRect:self.bounds toView:nil];
    CGFloat footer_y = CGRectGetMinY(convertRect);
    if (footer_y < [UIApplication sharedApplication].keyWindow.frame.size.height) {
        [self setHidden:YES];
    }else {
        [self setHidden:NO];
    }
    
}
@end
