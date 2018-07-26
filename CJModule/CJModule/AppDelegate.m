//
//  AppDelegate.m
//  CJModule
//
//  Created by 仁和Mac on 2018/6/22.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "AppDelegate.h"

#import <QMUIKit.h>

#import <CocoaLumberjack.h>

#import "CJRollingAdView.h"
#import "ViewController.h"
#import <IQKeyboardManager.h>
#import "QMViewController.h"
#import "CJAdViewController.h"

@interface AppDelegate ()

@property(nonatomic,strong) UIWindow *adWindow;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  

    
    [[QMUILogger sharedInstance].logNameManager setEnabled:YES forLogName:@"log"];
    [[QMUILogger sharedInstance].logNameManager setEnabled:YES forLogName:@"info"];
    [[QMUILogger sharedInstance].logNameManager setEnabled:YES forLogName:@"warn"];
    
    NSLog(@"%@",[QMUILogger sharedInstance].logNameManager.allNames);
    
    
    [[QMUIToastBackgroundView appearance] setStyleColor:[UIColor cyanColor]];
    [[QMUIToastContentView appearance] setTextLabelAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [[QMUIToastContentView appearance] setDetailTextLabelAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12]}];
  
    //[[CJAppearanceView appearance] setCj_color:[UIColor magentaColor]];

    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    
    manager.enable = YES;
    manager.shouldShowToolbarPlaceholder = YES;
    manager.keyboardDistanceFromTextField = 20.f;

//    UIWindow *adWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    adWindow.rootViewController = [CJAdViewController new];
//    adWindow.windowLevel = UIWindowLevelAlert;
//    adWindow.hidden = NO;
//    _adWindow = adWindow;
    

    
    return YES;
}



-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    
    
   
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
