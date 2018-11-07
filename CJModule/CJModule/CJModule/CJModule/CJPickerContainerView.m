//
//  CJPickerView.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/3.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJPickerContainerView.h"
#import "Masonry.h"


@interface CJPickerContainerView ()<UIPickerViewDelegate,UIPickerViewDataSource> {
    NSInteger _components;
}
@property(nonatomic, weak) UIView *toolView;

@property(nonatomic, strong) NSMutableArray<NSString *> *mSelectInfo;
@end

@implementation CJPickerContainerView


-(void)defaultConfig {
    _fontColor = [UIColor blackColor];
    _fontSize  = 15.f;
    _toolBarPosition   = CJPickerContainerViewToolBarPositionBottom;
}

-(void)initSubViews {
    
    self.layer.cornerRadius  = 5;
    self.layer.masksToBounds = YES;
    
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0];
    [self addSubview:backView];
    _toolView = backView;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(@40);
    }];
    
    CGFloat fonSize = 15;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:fonSize];
    [cancelBtn addTarget:self action:@selector(cancelItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.left.equalTo(backView).offset(10);
        make.width.mas_equalTo(@50);
    }];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:fonSize];
    [sureBtn addTarget:self action:@selector(sureItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.width.mas_equalTo(@40);
        make.right.equalTo(backView).offset(-10);
    }];
    
    
    UILabel *titleLab = [UILabel new];
    titleLab.font     = [UIFont systemFontOfSize:fonSize];
    titleLab.textColor= [UIColor grayColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLab];
    _titleLab = titleLab;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.left.equalTo(cancelBtn.mas_right);
        make.right.equalTo(sureBtn.mas_left);
    }];
   

    CJPickerView *pickerV = [[CJPickerView alloc] init];
    pickerV.delegate      = self;
    pickerV.dataSource    = self;
    pickerV.backgroundColor   = [UIColor whiteColor];
    pickerV.seperateLineColor = self.seperateLineColor?:[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0];
    [self addSubview:pickerV];
    _pikerView = pickerV;
    [pickerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(backView.mas_bottom);
    }];
}


#pragma mark -- public method
-(instancetype)initWithStyle:(CJPickerContainerViewStyle)style{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _pickerContainerViewStyle = style;
        [self defaultConfig];
        [self initSubViews];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame {
    return [self initWithStyle:CJPickerContainerViewStyleActionSheet];
}

-(void)dismissWithAnimated:(BOOL)animated{
    if (animated) {
        switch (_pickerContainerViewStyle) {
            case CJPickerContainerViewStyleAlert:
            {
                [UIView animateWithDuration:0.2f animations:^{
                    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
                    self.superview.alpha = 0.f;
                } completion:^(BOOL finished) {
                    UIViewController *pickerViewControlelr = (UIViewController *)self.superview.nextResponder;
                    [pickerViewControlelr dismissViewControllerAnimated:NO completion:nil];
                }];
            }
                break;
            case CJPickerContainerViewStyleActionSheet:
            {
                [UIView animateWithDuration:0.2f animations:^{
                    self.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height);
                    self.superview.alpha = 0.f;
                } completion:^(BOOL finished) {
                    UIViewController *pickerViewControlelr = (UIViewController *)self.superview.nextResponder;
                    [pickerViewControlelr dismissViewControllerAnimated:NO completion:nil];
                }];
            }
                break;
            default:
                break;
        }
    }else {
        UIViewController *pickerViewControlelr = (UIViewController *)self.superview.nextResponder;
        [pickerViewControlelr dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark --- item click
-(void)cancelItemClick:(UIBarButtonItem *)cancelItem {
    if ([self.delegate respondsToSelector:@selector(cj_pickerContainerViewDidCancel:)]) {
        [self.delegate cj_pickerContainerViewDidCancel:self];
    }
}

-(void)sureItemClick:(UIBarButtonItem *)sureItem {
    if ([self.delegate respondsToSelector:@selector(cj_pickerContainerView:didFinishWithInfo:)]) {
        [self.mSelectInfo removeAllObjects];
        for (int i = 0; i < _components; i++) {
            NSInteger row = [_pikerView selectedRowInComponent:i];
            NSArray<NSString *> *titles = [self.dataSource cj_pickerContainerView:self titlesForComponent:i];
            [self.mSelectInfo addObject:titles[row]];
        }
        [self.delegate cj_pickerContainerView:self didFinishWithInfo:_mSelectInfo];
    }
}

#pragma mark --- pickerView delagete && dataSources
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([self.dataSource respondsToSelector:@selector(cj_pickerContainerView:numberOfRowsInComponent:)]) {
        return [self.dataSource cj_pickerContainerView:self numberOfRowsInComponent:component];
    }
    return 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if ([self.dataSource respondsToSelector:@selector(cj_numberOfComponentsInPickerContainerView:)]) {
        _components = [self.dataSource cj_numberOfComponentsInPickerContainerView:self];
        return _components;
    }
    return 1;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if ([self.dataSource respondsToSelector:@selector(cj_pickerContainerView:titlesForComponent:)]) {
        NSArray<NSString *> *titles = [self.dataSource cj_pickerContainerView:self titlesForComponent:component];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:titles[row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_fontSize],
                                                                                   NSForegroundColorAttributeName:_fontColor
                                                                                   }];
        UILabel *lab = [UILabel new];
        lab.textAlignment  = NSTextAlignmentCenter;
        lab.attributedText = attrString;
        return lab;
    }
    return nil;
}



#pragma mark ---- setter
-(void)setSeperateLineColor:(UIColor *)seperateLineColor {
    _seperateLineColor = seperateLineColor;
    _pikerView.seperateLineColor = seperateLineColor;
}

-(void)setToolBarPosition:(CJPickerContainerViewToolBarPosition)toolBarPosition {
    _toolBarPosition = toolBarPosition;
    if (_toolBarPosition == CJPickerContainerViewToolBarPositionTop || _pickerContainerViewStyle == CJPickerContainerViewStyleActionSheet)
    return;
    
    [_toolView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(@40);
    }];
    
    [_pikerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(_toolView.mas_top);
    }];
}


#pragma mark ---- lazy
-(NSMutableArray<NSString *> *)mSelectInfo {
    if (!_mSelectInfo) {
        _mSelectInfo = [NSMutableArray array];
    }
    return _mSelectInfo;
}

@end
