//
//  CJAppearanceView.h
//  CJModule
//
//  Created by 仁和Mac on 2018/6/22.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJAppearanceView : UILabel

@property(nonatomic, strong) UIColor *cj_color UI_APPEARANCE_SELECTOR;

@end

@interface CJAppearanceView (UIAppearance)

//+(instancetype)appearance;

@end
