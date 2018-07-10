//
//  QMViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/5.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "QMViewController.h"
#import <QMUIKit.h>
#import "CJSnipImageView.h"

@interface QMViewController ()

@end

@implementation QMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *bk = [[UIView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:bk];
    
    

//    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage qmui_imageWithColor:[UIColor cyanColor]] forBarMetrics:UIBarMetricsDefault];
    
    QMUITextField *field = [[QMUITextField alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
    field.borderStyle = UITextBorderStyleBezel;
    
    field.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:field];
    
    CJSnipImageView *snipImageView = [[CJSnipImageView alloc] init];
    
    snipImageView.frame = CGRectMake(10, 210, self.view.qmui_width - 20, 300);
    snipImageView.zoomImageView.image = [UIImage imageNamed:@"image0"];
    [self.view addSubview:snipImageView];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"---%@",self.navigationController.navigationBar.translucent?@"YES":@"NO");

}


-(BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
    
   
    return [view isDescendantOfView:self.view];
}

-(void)contentSizeCategoryDidChanged:(NSNotification *)notification {
    NSLog(@"%@",notification);
}

@end
