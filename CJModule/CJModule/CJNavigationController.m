//
//  CJNavigationController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/6/26.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJNavigationController.h"

@interface CJNavigationController ()

@end

@implementation CJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

-(UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

-(BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}


@end
