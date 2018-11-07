//
//  CJPickerViewController.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/3.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJPickerViewController.h"

@implementation CJPickerViewController

-(instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    return self;
}

-(instancetype)initWithPickerView:(CJPickerContainerView *)pickerContainerView pickerViewHeight:(CGFloat)pickerViewH{
    self = [self init];
    if (!self) return nil;
    
    _pickerContainerView = pickerContainerView;
    _pickerContainerViewH= pickerViewH;
    return self;
}

#pragma mark --- life cycle
-(void)loadView {
    UIBlurEffect *blurEffect    = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *visualV = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualV.frame = [UIScreen mainScreen].bounds;
    self.view     = visualV.contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
    [self configPickerView];
    
    [self pickerContainerViewStyleAlert:^{
        _pickerContainerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } actionSheet:^{
        _pickerContainerView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(_pickerContainerView.frame));
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2f animations:^{
        _pickerContainerView.transform = CGAffineTransformIdentity;
        self.view.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.8];
    }];
}


#pragma mark ---private method
-(void)configPickerView {
    
    if (!_pickerContainerView) {
        [NSException exceptionWithName:@"containerView must be not nil" reason:nil userInfo:nil];
        return;
    }
    [self.view addSubview:_pickerContainerView];

    _pickerContainerViewH = (_pickerContainerViewH > 0) ? _pickerContainerViewH:300;
    _pickerContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self pickerContainerViewStyleAlert:^{
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_pickerContainerView
                                                 attribute:NSLayoutAttributeCenterX
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:self.view
                                                 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_pickerContainerView
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        NSLayoutConstraint *height  = [NSLayoutConstraint constraintWithItem:_pickerContainerView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:0.0 constant:_pickerContainerViewH];
        
        NSLayoutConstraint *width  = [NSLayoutConstraint constraintWithItem:_pickerContainerView
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0
                                                                constant:CGRectGetWidth(self.view.frame) - 30*2];
        [_pickerContainerView addConstraints:@[height,width]];
        [self.view addConstraints:@[centerY,centerX]];
  
    } actionSheet:^{
        NSLayoutConstraint *height  = [NSLayoutConstraint constraintWithItem:_pickerContainerView
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:0.0 constant:_pickerContainerViewH];
        [_pickerContainerView addConstraint:height];

        
        NSLayoutConstraint *right  = [NSLayoutConstraint constraintWithItem:_pickerContainerView
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeRight multiplier:1.0
                                                                    constant:0];
    
        NSLayoutConstraint *left    = [NSLayoutConstraint constraintWithItem:_pickerContainerView
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0 constant:0];
        NSLayoutConstraint *bottom  = [NSLayoutConstraint constraintWithItem:_pickerContainerView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0 constant:0];
        [self.view addConstraints:@[left,right,bottom]];
    }];


}

-(void)pickerContainerViewStyleAlert:(dispatch_block_t)alertBlock actionSheet:(dispatch_block_t)actionSheetBlock {
    switch (_pickerContainerView.pickerContainerViewStyle) {
        case CJPickerContainerViewStyleAlert:
            alertBlock();
            break;
        case CJPickerContainerViewStyleActionSheet:
            actionSheetBlock();
            break;
        default:
            break;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_pickerContainerView dismissWithAnimated:YES];
}

-(void)dealloc {
    
}


@end
