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
#import "ModalViewController.h"

@interface QMViewController ()


@end

@implementation QMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *bk = [[UIView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:bk];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage qmui_imageWithColor:[UIColor cyanColor]] forBarMetrics:UIBarMetricsDefault];
    
    QMUITextField *field = [[QMUITextField alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
    
    field.backgroundColor = [UIColor purpleColor];
    field.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:field];
    
   
    
 
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
   
}


-(BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
    
   
    return [view isDescendantOfView:self.view];
}

-(void)contentSizeCategoryDidChanged:(NSNotification *)notification {
    NSLog(@"%@",notification);
}

@end
