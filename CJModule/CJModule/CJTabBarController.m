//
//  CJTabBarController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/6/26.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJTabBarController.h"
#import "CJNavigationController.h"
#import "ViewController.h"


@interface CJTabBarController ()<UITabBarControllerDelegate>

@end

@implementation CJTabBarController

-(instancetype)init {
    self = [super init];
    if (self) {
        CJNavigationController *navi = [[CJNavigationController alloc] initWithRootViewController:[ViewController new]];
        CJNavigationController *navi1 = [[CJNavigationController alloc] initWithRootViewController:[UIViewController new]];
        CJNavigationController *navi2 = [[CJNavigationController alloc] initWithRootViewController:[UIViewController new]];
        navi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"first" image:nil selectedImage:nil];
        navi1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"second" image:nil selectedImage:nil];
        navi2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"third" image:nil selectedImage:nil];

        self.viewControllers = @[navi,navi1,navi2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}




@end
