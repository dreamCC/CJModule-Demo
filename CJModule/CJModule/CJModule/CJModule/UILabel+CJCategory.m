//
//  UILabel+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/5/7.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UILabel+CJCategory.h"
#import <objc/runtime.h>

@implementation UILabel (CJCategory)

-(void)cj_addLongpressGesture {
    self.userInteractionEnabled = YES;
  
    [self addGestureRecognizer:self.cj_longpressGesture];
}

-(void)cj_removeLongpressGesture {
    self.userInteractionEnabled = NO;
    [self removeGestureRecognizer:self.cj_longpressGesture];
}

-(void)longpressStart:(UILongPressGestureRecognizer *)longpress {
    if (longpress.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        
        if (!self.cj_menuController.isMenuVisible) {
            [self.cj_menuController setMenuVisible:YES animated:YES];
        }
    }
}


-(BOOL)canBecomeFirstResponder {
    return self.cj_canCopy;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.cj_canCopy) {
        return (action == @selector(cj_copyStart));
    }
    return NO;
}



-(void)cj_copyStart {
    
    if (self.cj_canCopy) {
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        if (self.text) {
            pasteBoard.string = self.text;
        }
    }
}

-(UIMenuController *)cj_menuController {
    UIMenuController *menuController = objc_getAssociatedObject(self, _cmd);
    if (!menuController) {
        UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(cj_copyStart)];
        UIMenuController *copyMenu = [UIMenuController sharedMenuController];
        [copyMenu setTargetRect:self.frame inView:self.superview];
        [copyMenu setMenuItems:@[item]];
        objc_setAssociatedObject(self, _cmd, copyMenu, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return menuController;
}

-(UILongPressGestureRecognizer *)cj_longpressGesture {
    UILongPressGestureRecognizer *longpressGesture = objc_getAssociatedObject(self, _cmd);
    if (!longpressGesture) {
        longpressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressStart:)];
        objc_setAssociatedObject(self, _cmd, longpressGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return longpressGesture;
}

#pragma mark ---  setter &&getter
-(void)setCj_canCopy:(BOOL)cj_canCopy {
    objc_setAssociatedObject(self, @selector(cj_canCopy), @(cj_canCopy), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (cj_canCopy) {
        [self cj_addLongpressGesture];
    }else {
        [self cj_removeLongpressGesture];
    }
}

-(BOOL)cj_canCopy {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
