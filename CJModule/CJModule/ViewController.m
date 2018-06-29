//
//  ViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/6/22.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "ViewController.h"
#import <QMUIKit.h>
#import "CJAppearanceView.h"
#import "CJModule.h"
#import "CJMarqueeLabel.h"
#import "ModalViewController.h"

@interface ViewController () {
    CJMarqueeLabel *_marqueel;
    UILabel *_label;
    
}

@property(nonatomic,weak) CJAppearanceView *appearanceView;

@property(nonatomic, strong) UIWindow *windo;



@end

@implementation ViewController {
    QMUIEmotionInputManager *_manager;
    
}

-(void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CJAppearanceView *appearanceView = [[CJAppearanceView alloc] init];
    appearanceView.frame = CGRectMake(10, 100, 100, 100);
    appearanceView.layer.cornerRadius = 5;
    //appearanceView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    appearanceView.layer.allowsGroupOpacity = NO;
    appearanceView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:appearanceView];
    _appearanceView = appearanceView;

   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
    QMUINavigationTitleView *titleV = [[QMUINavigationTitleView alloc] initWithStyle:QMUINavigationTitleViewStyleDefault];
    titleV.needsLoadingView = YES;
    titleV.loadingViewHidden = NO;
    titleV.userInteractionEnabled = YES;
    titleV.title = @"nTitleView";
    titleV.accessoryType = QMUINavigationTitleViewAccessoryTypeDisclosureIndicator;

    self.navigationItem.titleView = titleV;
    
 
    UIInterpolatingMotionEffect *motionX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionX.minimumRelativeValue = @(-50);
    motionX.maximumRelativeValue = @50;
    [appearanceView addMotionEffect:motionX];
    
    UIInterpolatingMotionEffect *motionY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    motionX.minimumRelativeValue = @(-50);
    motionX.maximumRelativeValue = @50;
    [self.view addMotionEffect:motionY];
    

    CJMarqueeLabel *marqueelLab = [[CJMarqueeLabel alloc] initWithFrame:CGRectMake(10, 350, 100, 40)];
    marqueelLab.backgroundColor = [UIColor lightGrayColor];
    marqueelLab.text = @"这是一个跑马灯，所以内容要很长的";
    marqueelLab.textAlignment = NSTextAlignmentCenter;
    marqueelLab.userInteractionEnabled = YES;
    [self.view addSubview:marqueelLab];
    _marqueel = marqueelLab;
   

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 480, 100, 40)];
    lab.text = @"this is a ad";
    lab.backgroundColor = [UIColor purpleColor];
    lab.layer.anchorPoint = CGPointMake(0.5, 0);
    [self.view addSubview:lab];
    _label = lab;
   
    
}



-(void)leftItemClick:(UIBarButtonItem *)item {
    NSLog(@"左边点击");
   
    
//    [self presentViewController:modal animated:YES completion:nil];

//    QMUIEmotion *emotion = [QMUIEmotion emotionWithIdentifier:@"-hot" displayName:@"-hot"];
//    QMUIEmotionInputManager *manager = [[QMUIEmotionInputManager alloc] init];
//    manager.emotionView.emotions = @[emotion];
//    manager.emotionView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:manager.emotionView];
//    _manager = manager;
//
//    manager.emotionView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 200, CGRectGetWidth(self.view.frame), 200);
//    [_appearanceView setNeedsDisplay];
    
    
    __block typeof(_label)blockLab = _label;
    [UIView animateWithDuration:1.f animations:^{
       
        CATransform3D trans = CATransform3DIdentity;
        trans = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
        trans = CATransform3DTranslate(trans, 0, - 20 / 2, -20 / 2);
        blockLab.layer.transform = trans;
        
    }];
 
   
}


-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan 方法");
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
  
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}


@end
