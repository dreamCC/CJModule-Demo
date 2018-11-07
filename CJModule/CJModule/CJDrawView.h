//
//  CJDrawView.h
//  CJModule
//
//  Created by 仁和Mac on 2018/8/3.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJDrawView : UIView

@property(nonatomic, strong) UIColor *cj_backColor UI_APPEARANCE_SELECTOR;

@end


@interface CJDrawView (UIAppearance)


+(instancetype)appearance;

@end
