//
//  CJMenuView.h
//  CommonProject
//
//  Created by zhuChaojun的mac on 2017/3/20.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJProgressHUD.h"
#import "MBProgressHUD.h"

static const CGFloat kHintShowTime = 2.f;
static MBProgressHUD *_hud = nil;
@implementation CJProgressHUD


/// 显示提示问题
+(void)showHint:(NSString *)hint {
    [self showHint:hint toView:nil];
}
+(void)showHint:(NSString *)hint toView:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text     = hint;
    hud.mode           = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:kHintShowTime];
}
+(void)showHint:(NSString *)hint image:(UIImage *)image toView:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text     = hint;
    hud.mode           = MBProgressHUDModeCustomView;
    hud.customView     = [[UIImageView alloc] initWithImage:image];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:kHintShowTime];
}

+(void)showSuccessHint:(NSString *)hint {
    [self showSuccessHint:hint toView:nil];
}

+(void)showSuccessHint:(NSString *)hint toView:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    NSString *bundleString = [[NSBundle mainBundle] pathForResource:@"MBProgressHUD.bundle/success" ofType:@"png"];
    UIImage  *img = [UIImage imageNamed:bundleString];
    [self showHint:hint image:img toView:view];
}

+(void)showErrorHint:(NSString *)hint {
    [self showErrorHint:hint toView:nil];
}

+(void)showErrorHint:(NSString *)hint toView:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    NSString *bundleString = [[NSBundle mainBundle] pathForResource:@"MBProgressHUD.bundle/error" ofType:@"png"];
    UIImage  *img = [UIImage imageNamed:bundleString];
    [self showHint:hint image:img toView:view];
}

/// 显示activity提示
+(void)showNotice:(NSString *)notice {
    [self showNotice:notice toView:nil];
}
+(void)showNotice:(NSString *)notice toView:(UIView *)view {
    if (_hud) {
        _hud.label.text = notice;
        return;
    }
    
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
  
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text     = notice;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled    = NO; //关闭hud用户交互，使其父视图响应用户交互。
    _hud = hud;
}

+(void)hiddenNotice {
    [self hiddenNoticeAfterDelay:0.f];
}

+(void)hiddenNoticeAfterDelay:(CGFloat)second {
    if (!_hud) return;
    [_hud hideAnimated:YES afterDelay:second];
    _hud = nil;
}



@end
