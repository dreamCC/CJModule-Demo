//
//  CJAdViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/24.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJAdViewController.h"
#import "AppDelegate.h"
#import "ModalViewController.h"


@interface CJAdViewController ()

@end

@implementation CJAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *adLab = [UILabel new];
    adLab.text = @"广告页";
    adLab.textColor = [UIColor purpleColor];
    [self.view addSubview:adLab];
    [adLab sizeToFit];
    adLab.center = self.view.center;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"gotoAd" object:nil];
    
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navi = (UINavigationController *)tabBar.selectedViewController;
    [navi pushViewController:[ModalViewController new] animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([CATransaction animationDuration] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.view.window.hidden = YES;
    });

}

@end
