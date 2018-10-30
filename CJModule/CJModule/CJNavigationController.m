//
//  CJNavigationController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/6/26.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJNavigationController.h"

@interface CJNavigationController ()<UINavigationControllerDelegate> {
    BOOL _isPushing;
}

@end

@implementation CJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.delegate = self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    
    if (_isPushing) {
        return;
    }
    
    _isPushing = YES;
    viewController.hidesBottomBarWhenPushed = YES;
    
//    self.topViewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"-hot"] style:UIBarButtonItemStylePlain target:self action:@selector(popViewControllerAnimated:)];
    
    self.topViewController.navigationItem.hidesBackButton = YES;
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.topViewController.navigationItem.title style:UIBarButtonItemStyleDone target:self action:@selector(pop)];

    [super pushViewController:viewController animated:animated];
    


}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    _isPushing = NO;
}


-(void)pop {
    [self popViewControllerAnimated:YES];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated {


    UIViewController *vc =  [super popViewControllerAnimated:animated];
    return vc;
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
