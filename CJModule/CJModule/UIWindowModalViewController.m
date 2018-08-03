
//
//  UIWindowModalViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/31.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UIWindowModalViewController.h"
#import <QMUIKit.h>

@interface UIWindowModalViewController ()

@end

@implementation UIWindowModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.view.backgroundColor = [UIColor purpleColor];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@",self.qmui_modalPresentationViewController);
}



@end
