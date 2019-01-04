//
//  CJModalPresentViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/12/20.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJModalPresentViewController.h"

@interface CJModalPresentViewController ()

@end

@implementation CJModalPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


-(CGSize)preferredContentSizeInModalPresentationViewController:(QMUIModalPresentationViewController *)controller keyboardHeight:(CGFloat)keyboardHeight limitSize:(CGSize)limitSize {
    return CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
}
@end
