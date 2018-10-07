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
    
//    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40)];
//    
//    naviBar.backgroundColor = [UIColor redColor];
//    [self.view addSubview:naviBar];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {


    
    if (viewController == self.topViewController) {
        return;
    }
    viewController.hidesBottomBarWhenPushed = YES;
    
//    self.topViewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"-hot"] style:UIBarButtonItemStylePlain target:self action:@selector(popViewControllerAnimated:)];
    
    self.topViewController.navigationItem.hidesBackButton = YES;
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.topViewController.navigationItem.title style:UIBarButtonItemStyleDone target:self action:@selector(pop)];

    [super pushViewController:viewController animated:animated];
    


}


-(void)pop {
    [self popViewControllerAnimated:YES];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated {

    NSLog(@"%@",self.topViewController);
    NSLog(@"%@",self.viewControllers);
    
    UIViewController *vc =  [super popViewControllerAnimated:animated];
    NSLog(@"%@",vc);
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
