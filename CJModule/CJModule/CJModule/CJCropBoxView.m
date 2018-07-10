//
//  CJCropBoxView.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJCropBoxView.h"

static CGFloat cornerTouchArea = 20.f;
@interface CJCropBoxView ()

@property(nonatomic,weak) UIView *top_left_view;
@property(nonatomic,weak) UIView *top_right_view;
@property(nonatomic,weak) UIView *bottom_left_view;
@property(nonatomic,weak) UIView *bottom_right_view;

@property(nonatomic,weak) CAShapeLayer *cropShapeLayer;
@property(nonatomic,weak) CAShapeLayer *cornerShapeLayer;
@property(nonatomic,weak) CAShapeLayer *insideMeshShapeLayer;

@end

@implementation CJCropBoxView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self didInitialize];
        [self didInitializeSubViews];
    }
    return self;
}

-(void)didInitialize {
    self.backgroundColor = [UIColor clearColor];
    
    self.cornerLineWidth     = 4.f;
    self.cornerLineHeight    = 20.f;
    self.cropBoardLineWidth  = 2.f;
    self.insideMesh = YES;
    self.insideMeshRowAndLine = 2;
    self.insideMeshLineWidth  = 1.f;
    
    self.minCropArea = CGSizeMake(2 * cornerTouchArea + 20, 2 * cornerTouchArea +20);
}


-(void)didInitializeSubViews {
   
    UIPanGestureRecognizer *backPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backPanGesture:)];
    [self addGestureRecognizer:backPanGesture];
    

    // 四个角
    for (int i = 0,count = 4; i < count; i++) {
        UIView *cornerV = [[UIView alloc] init];
        cornerV.tag = 100 + i;
        [self addSubview:cornerV];
        
        UIPanGestureRecognizer *cornerPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cornerPanGesture:)];
        [cornerV addGestureRecognizer:cornerPanGesture];
    }
    
    self.top_left_view     = self.subviews.firstObject;
    self.top_right_view    = self.subviews[1];
    self.bottom_left_view  = self.subviews[2];
    self.bottom_right_view = self.subviews[3];
    
    CAShapeLayer *cropShapeLayer = [CAShapeLayer layer];
    cropShapeLayer.strokeColor  = [UIColor whiteColor].CGColor;
    cropShapeLayer.fillColor    = [UIColor clearColor].CGColor;
    cropShapeLayer.lineWidth    = _cropBoardLineWidth;
    [self.layer insertSublayer:cropShapeLayer atIndex:0];
    self.cropShapeLayer = cropShapeLayer;
    
    CAShapeLayer *cornerShapeLayer = [CAShapeLayer layer];
    cornerShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    cornerShapeLayer.fillColor   = [UIColor clearColor].CGColor;
    cornerShapeLayer.lineWidth   = _cornerLineWidth;
    [self.layer insertSublayer:cornerShapeLayer atIndex:1];
    self.cornerShapeLayer = cornerShapeLayer;
    
    CAShapeLayer *insideMeshShapeLayer = [CAShapeLayer layer];
    insideMeshShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    insideMeshShapeLayer.fillColor   = [UIColor clearColor].CGColor;
    insideMeshShapeLayer.lineWidth   = _insideMeshLineWidth;
    [self.layer insertSublayer:insideMeshShapeLayer atIndex:2];
    self.insideMeshShapeLayer = insideMeshShapeLayer;
}

-(void)tintColorDidChange {
    self.cropShapeLayer.strokeColor = self.tintColor.CGColor;
    self.cornerShapeLayer.strokeColor = self.tintColor.CGColor;
    self.insideMeshShapeLayer.strokeColor = self.tintColor.CGColor;
}

-(void)layoutSubviews {
    CGFloat frameW = CGRectGetWidth(self.frame);
    CGFloat frameH = CGRectGetHeight(self.frame);
    
    
    self.top_left_view.frame     = CGRectMake(0, 0, cornerTouchArea, cornerTouchArea);
    self.top_right_view.frame    = CGRectMake(frameW - cornerTouchArea, 0, cornerTouchArea, cornerTouchArea);
    self.bottom_left_view.frame  = CGRectMake(0, frameH - cornerTouchArea, cornerTouchArea, cornerTouchArea);
    self.bottom_right_view.frame = CGRectMake(frameW - cornerTouchArea, frameH - cornerTouchArea, cornerTouchArea, cornerTouchArea);
    
    // 四个角
    UIBezierPath *cornerPath = [UIBezierPath bezierPath];
    CGFloat halfCornerW = _cornerLineWidth * 0.5;
    // 1、左上
    [cornerPath moveToPoint:CGPointMake(halfCornerW, _cornerLineHeight)];
    [cornerPath addLineToPoint:CGPointMake(halfCornerW, halfCornerW)];
    [cornerPath addLineToPoint:CGPointMake(_cornerLineHeight, halfCornerW)];
    
    // 2、右上
    [cornerPath moveToPoint:CGPointMake(frameW - _cornerLineHeight, halfCornerW)];
    [cornerPath addLineToPoint:CGPointMake(frameW - halfCornerW, halfCornerW)];
    [cornerPath addLineToPoint:CGPointMake(frameW - halfCornerW, _cornerLineHeight)];
    
    // 3、左下
    [cornerPath moveToPoint:CGPointMake(halfCornerW, frameH - _cornerLineHeight)];
    [cornerPath addLineToPoint:CGPointMake(halfCornerW, frameH - halfCornerW)];
    [cornerPath addLineToPoint:CGPointMake(_cornerLineHeight, frameH - halfCornerW)];
    
    // 4、右下
    [cornerPath moveToPoint:CGPointMake(frameW - _cornerLineHeight, frameH - halfCornerW)];
    [cornerPath addLineToPoint:CGPointMake(frameW - halfCornerW, frameH - halfCornerW)];
    [cornerPath addLineToPoint:CGPointMake(frameW - halfCornerW, frameH - _cornerLineHeight)];
    self.cornerShapeLayer.path = cornerPath.CGPath;
    
    // 剪切框
    UIBezierPath *cropBezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(_cornerLineWidth, _cornerLineWidth, frameW - 2*_cornerLineWidth, frameH - 2*_cornerLineWidth)];
    self.cropShapeLayer.path = cropBezierPath.CGPath;

    // 剪切框，内部网状交叉线
    if (_insideMesh) {
        UIBezierPath *insideMeshPath = [UIBezierPath bezierPath];
        CGFloat spaceW = (frameW - _cornerLineWidth*2 - _cropBoardLineWidth*2 - _insideMeshRowAndLine*_insideMeshLineWidth)/(_insideMeshRowAndLine+1);
        CGFloat spaceH = (frameH - _cornerLineWidth*2 - _cropBoardLineWidth*2 - _insideMeshRowAndLine*_insideMeshLineWidth)/(_insideMeshRowAndLine+1);
        for (int line = 0; line < _insideMeshRowAndLine; line++) {
            [insideMeshPath moveToPoint:CGPointMake((spaceW + _insideMeshLineWidth*0.5)*(line+1)+_cornerLineWidth + _cropBoardLineWidth, _cornerLineWidth + _cropBoardLineWidth)];
            [insideMeshPath addLineToPoint:CGPointMake((spaceW + _insideMeshLineWidth*0.5)*(line+1)+_cornerLineWidth + _cropBoardLineWidth, frameH - _cornerLineWidth - _cropBoardLineWidth)];
        }
        for (int row = 0; row < _insideMeshRowAndLine; row++) {
            [insideMeshPath moveToPoint:CGPointMake(_cornerLineWidth + _cropBoardLineWidth, (spaceH + _insideMeshLineWidth*0.5)*(row+1)+_cornerLineWidth + _cropBoardLineWidth)];
            [insideMeshPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) - _cornerLineWidth - _cropBoardLineWidth, (spaceH + _insideMeshLineWidth*0.5)*(row+1)+_cornerLineWidth + _cropBoardLineWidth)];
        }
        self.insideMeshShapeLayer.path = insideMeshPath.CGPath;
    }
    
    !self.cropBoxChanging?:self.cropBoxChanging();
}

-(void)cornerPanGesture:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateBegan) return;
    
    CGRect frame = self.frame;
    UIView *localView = panGesture.view;
    
    CGPoint translationPoint = [panGesture translationInView:localView];
    CGFloat translationX ,translationY;
    switch (localView.tag) {
        case 100: // 左上
        {
            translationX = translationPoint.x > 0?-(translationPoint.x):fabs(translationPoint.x);
            translationY = translationPoint.y > 0?-(translationPoint.y):fabs(translationPoint.y);
            
            self.frame = (CGRect){{frame.origin.x + translationPoint.x,frame.origin.y + translationPoint.y},
                {frame.size.width + translationX ,frame.size.height + translationY}};
        }
            break;
        
        case 101: // 右上
        {
            translationX = translationPoint.x;
            translationY = -translationPoint.y;
            self.frame = (CGRect){{frame.origin.x,frame.origin.y - translationY},{frame.size.width + translationX,frame.size.height + translationY}};
        }
            break;
        case 102: // 左下
        {
            translationX = -translationPoint.x;
            translationY = translationPoint.y;
            self.frame = (CGRect){{frame.origin.x - translationX,frame.origin.y},{frame.size.width + translationX,frame.size.height + translationY}};
        }
            break;
        case 103: // 右下
        {
            self.frame = (CGRect){frame.origin,{frame.size.width + translationPoint.x,frame.size.height + translationPoint.y}};
        }
            break;
        default:
            break;
    }
    [panGesture setTranslation:CGPointZero inView:localView];
    
    if (CGRectGetWidth(self.frame) <= self.minCropArea.width) {
        CGRect frame = self.frame;
        frame.size.width = self.minCropArea.width;
        self.frame = frame;
    }
    
    if (CGRectGetHeight(self.frame) <= self.minCropArea.height) {
        CGRect frame = self.frame;
        frame.size.height = self.minCropArea.height;
        self.frame = frame;
    }
    [self layoutIfNeeded];
}

-(void)backPanGesture:(UIPanGestureRecognizer *)backPanGesture {
    CGRect frame = self.frame;
    CGPoint translation = [backPanGesture translationInView:self];
    [backPanGesture setTranslation:CGPointZero inView:self];
    
    CGRect translatedRect = (CGRect){{frame.origin.x + translation.x,frame.origin.y + translation.y},frame.size};
    translatedRect.origin.x = translatedRect.origin.x > 0?translatedRect.origin.x:0;
    translatedRect.origin.x = translatedRect.origin.x < (CGRectGetWidth(self.superview.frame)-CGRectGetWidth(self.frame))?translatedRect.origin.x:(CGRectGetWidth(self.superview.frame)-CGRectGetWidth(self.frame));
    translatedRect.origin.y = translatedRect.origin.y > 0?translatedRect.origin.y:0;
    translatedRect.origin.y = translatedRect.origin.y < (CGRectGetHeight(self.superview.frame)-CGRectGetHeight(self.frame))?translatedRect.origin.y:(CGRectGetHeight(self.superview.frame)-CGRectGetHeight(self.frame));
    
    self.frame = translatedRect;
    !self.cropBoxChanging?:self.cropBoxChanging();
}


#pragma mark --- setter method
-(void)setCornerLineWidth:(CGFloat)cornerLineWidth {
    _cornerLineWidth = cornerLineWidth;
    self.cornerShapeLayer.lineWidth = cornerLineWidth;
}

-(void)setcropBoardLineWidth:(CGFloat)cropBoardLineWidth {
    _cropBoardLineWidth = cropBoardLineWidth;
    self.cropShapeLayer.lineWidth = cropBoardLineWidth;
}

-(void)setInsideMeshRowAndLine:(NSUInteger)insideMeshRowAndLine {
    _insideMeshRowAndLine = insideMeshRowAndLine;
    self.insideMesh = insideMeshRowAndLine > 0;
}

@end
