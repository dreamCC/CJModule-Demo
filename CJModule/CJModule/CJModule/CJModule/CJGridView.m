//
//  CJGridView.m
//  CommonProject
//
//  Created by 仁和Mac on 2017/6/9.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJGridView.h"

@interface CJGridView()

@property(nonatomic,weak) CAShapeLayer *seperateLayer;

@property(nonatomic, strong) UIView *previousView;


@end

@implementation CJGridView

-(instancetype)initWithFrame:(CGRect)frame colum:(NSUInteger)colum {
    self = [super initWithFrame:frame];
    if (self) {
        _colum = colum;
        [self didInitialize];
        [self addSeperateLayer];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame colum:3];
}


-(void)didInitialize {
    _seperateWide  = 0.f;
    _seperateColor = _seperateWide?[UIColor lightGrayColor]:nil;
    _itemHeight    = 50.f;
}

-(void)addSeperateLayer {
    CAShapeLayer *seperateLayer = [CAShapeLayer layer];
    seperateLayer.lineWidth   = _seperateWide;
    seperateLayer.strokeColor = _seperateColor.CGColor;
    seperateLayer.fillColor   = [UIColor clearColor].CGColor;
    [self.layer addSublayer:seperateLayer];
    _seperateLayer = seperateLayer;
}


-(void)layoutSubviews {
    if (CGRectIsEmpty(self.frame)) return;
    
    UIBezierPath *seperatePath  = [UIBezierPath bezierPath];
    NSUInteger subViews = self.subviews.count;
    NSUInteger row = subViews/_colum  + (subViews%_colum?1:0);
    CGFloat  wide  = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat estimatedItemW = floor(_seperateWide?((wide+_seperateWide)/_colum-_seperateWide):wide/_colum);
    CGFloat estimatedItemH = floor(CGRectGetHeight(self.subviews.firstObject.frame)?:_itemHeight);
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < _colum; j++) {
            @autoreleasepool {
                NSInteger index  = i*_colum + j;
                if (index == subViews) break;
        
                UIView *currentSubV   = self.subviews[index];
                CGFloat currentSubV_W = 0,currentSubV_H = 0;
                
                BOOL isLastColum = j == _colum-1;
                BOOL isLastRow   = i == row-1;
                if (isLastColum) {
                    currentSubV_W = wide - j*(_seperateWide + estimatedItemW);
                }else {
                    currentSubV_W = estimatedItemW;
                }
                
                if (isLastRow) {
                    currentSubV_H = height - i*(_seperateWide + estimatedItemH)?:estimatedItemH;
                }else {
                    currentSubV_H = estimatedItemH;
                }
                
                if (CGRectGetMaxY(_previousView.frame) >= height) {
#ifdef DEBUG
                    NSLog(@"注意:subView的高度太高,已不足以显示全部，请设置合适高度");
#endif
                }
                currentSubV.frame = CGRectMake(j*(estimatedItemW+_seperateWide), i*(estimatedItemH+_seperateWide), currentSubV_W, currentSubV_H);
                _previousView = currentSubV;
                
                if (!_seperateWide) continue;
                UIBezierPath *seperatePart = [UIBezierPath bezierPath];
                if (isLastColum && !isLastRow) {
                    CGPoint movePoint = CGPointMake(CGRectGetMinX(currentSubV.frame), CGRectGetMaxY(currentSubV.frame)+_seperateWide*0.5);
                    CGPoint endPoint  = CGPointMake(CGRectGetMaxX(currentSubV.frame), CGRectGetMaxY(currentSubV.frame)+_seperateWide*0.5);
                    [seperatePart moveToPoint:movePoint];
                    [seperatePart addLineToPoint:endPoint];
                }else if(!isLastColum && !isLastRow) {
                    CGPoint movePoint = CGPointMake(CGRectGetMaxX(currentSubV.frame)+_seperateWide*0.5, CGRectGetMinY(currentSubV.frame));
                    CGPoint addPoint  = CGPointMake(CGRectGetMaxX(currentSubV.frame)+_seperateWide*0.5, CGRectGetMaxY(currentSubV.frame)+_seperateWide*0.5);
                    CGPoint endPoint  = CGPointMake(CGRectGetMinX(currentSubV.frame), CGRectGetMaxY(currentSubV.frame)+_seperateWide*0.5);
                    [seperatePart moveToPoint:movePoint];
                    [seperatePart addLineToPoint:addPoint];
                    [seperatePart addLineToPoint:endPoint];
                }else if (!isLastColum && isLastRow && index != self.subviews.count-1)  {
                    CGPoint movePoint = CGPointMake(CGRectGetMaxX(currentSubV.frame)+_seperateWide*0.5, CGRectGetMinY(currentSubV.frame));
                    CGPoint endPoint  = CGPointMake(CGRectGetMaxX(currentSubV.frame)+_seperateWide*0.5, CGRectGetMaxY(currentSubV.frame));
                    [seperatePart moveToPoint:movePoint];
                    [seperatePart addLineToPoint:endPoint];
                }
                [seperatePath appendPath:seperatePart];
            }
            
        }
    }
    if (_seperateWide) {
        _seperateLayer.path = seperatePath.CGPath;
    }
}


#pragma mark --- private method
-(void)setSeperateWide:(CGFloat)seperateWide {
    _seperateWide = seperateWide;
    _seperateLayer.lineWidth = seperateWide;
}

-(void)setSeperateColor:(UIColor *)seperateColor {
    _seperateColor = seperateColor;
    _seperateLayer.strokeColor = seperateColor.CGColor;
}

-(void)setSeperateDashPattern:(NSArray<NSNumber *> *)seperateDashPattern {
    _seperateDashPattern = seperateDashPattern;
    _seperateLayer.lineDashPattern = seperateDashPattern;
}

@end
