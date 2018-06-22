//
//  CJEmptyDataSetDelegate.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/4/16.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJEmptyDataSetDelegate.h"

@interface CJEmptyDataSetDelegate ()

@property(nonatomic,copy) void(^buttonClickBlock)(void);

@end

@implementation CJEmptyDataSetDelegate


-(instancetype)initWithButtonClick:(void (^)(void))buttonClick {
    self = [super init];
    if (self) {
        _buttonClickBlock = buttonClick;
    }
    return self;
}


#pragma mark --- 代理
-(NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (1) {
        return [self descStringWithString:@"当前网络不可用，请检查后重试!"];
    }
    return [self descStringWithString:_hintDesc?:@"暂无数据"];
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (1) {
        return [UIImage imageNamed:@"error_img"];
    }
    return [UIImage imageNamed:@"noting_img"];
}

-(NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *buttonString = _buttonTitle?:@"重新加载";
    NSRange allRange = NSMakeRange(0, buttonString.length);
    NSMutableAttributedString *mAttr = [[NSMutableAttributedString alloc] initWithString:buttonString];
    [mAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:allRange];
    [mAttr addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithRed:(62.0)/255.0 green:(130.0)/255.0 blue:(228.0)/255.0 alpha:1.0]
                  range:allRange];
    
    return mAttr;
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    _activityShow = YES;
    [scrollView reloadEmptyDataSet];
}


-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    if (_activityShow) {
        UIActivityIndicatorView *activity   = [[UIActivityIndicatorView alloc] init];
        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [activity startAnimating];
        return activity;
    }
    return nil;
}

#pragma mark ---- private Method
-(NSAttributedString *)descStringWithString:(NSString *)string {
    
    NSRange allRange = NSMakeRange(0, string.length);
    NSMutableAttributedString *mAttr = [[NSMutableAttributedString alloc] initWithString:string];
    [mAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:allRange];
    [mAttr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:allRange];
    return mAttr;
}


@end
