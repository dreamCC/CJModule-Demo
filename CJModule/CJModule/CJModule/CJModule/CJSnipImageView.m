//
//  CJSnipImageView.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/9.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJSnipImageView.h"


@interface CJSnipImageView ()

@property(nonatomic,weak) UIView *backView;

@property(nonatomic,strong) CAShapeLayer *backShapeLayer;

@end


@implementation CJSnipImageView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self didInitializeSubViews];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didInitializeSubViews];
    }
    return self;
}

-(void)didInitializeSubViews {

    QMUIZoomImageView *zoomImageView = [[QMUIZoomImageView alloc] init];
    [self addSubview:zoomImageView];
    self.zoomImageView = zoomImageView;
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.4f];
    [self addSubview:backView];
    self.backView =backView;
    
    CJCropBoxView *cropBoxView = [[CJCropBoxView alloc] init];
    [self insertSubview:cropBoxView aboveSubview:backView];
    self.cropBoxView = cropBoxView;
    
    __weak typeof(self)weakSelf = self;
    self.cropBoxView.cropBoxChanging = ^{
        
        UIBezierPath *backBezierPath = [UIBezierPath bezierPathWithRect:weakSelf.backView.bounds];
        [backBezierPath appendPath:[[UIBezierPath bezierPathWithRect:CGRectInset(weakSelf.cropBoxView.frame, weakSelf.cropBoxView.cornerLineWidth, weakSelf.cropBoxView.cornerLineWidth)] bezierPathByReversingPath]];
        weakSelf.backShapeLayer.path = backBezierPath.CGPath;
        weakSelf.backView.layer.mask = weakSelf.backShapeLayer;
    };
    
    CAShapeLayer *backShapeLayer = [CAShapeLayer layer];
    self.backShapeLayer  = backShapeLayer;
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.zoomImageView.frame = self.bounds;
    self.backView.frame = self.bounds;
    if (CGRectIsEmpty(self.cropBoxView.frame)) {
        self.cropBoxView.frame = CGRectMake(40, 40, CGRectGetWidth(self.frame) - 40*2, CGRectGetHeight(self.frame) - 40 *2);
    }
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.cropBoxMargin = CGRectGetWidth(frame) / 4;
    self.cropBoxSize = CGSizeMake(CGRectGetWidth(frame)/2, CGRectGetWidth(frame)/2);
}


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint zoomPoint = [self convertPoint:point toView:self.zoomImageView];
    if (CGRectContainsPoint(self.cropBoxView.frame, zoomPoint)) {
        return [super hitTest:point withEvent:event];
    }
    return [self.zoomImageView hitTest:zoomPoint withEvent:event];
}


-(UIImage *)snipImage {
    UIView *snipView = [self.zoomImageView snapshotViewAfterScreenUpdates:YES];
    CGRect targetSnipFrame = CGRectInset(self.cropBoxView.frame, self.cropBoxView.cornerLineWidth, self.cropBoxView.cornerLineWidth);
    UIGraphicsBeginImageContextWithOptions(targetSnipFrame.size, NO, 0);
    [snipView drawViewHierarchyInRect:(CGRect){{-targetSnipFrame.origin.x,-targetSnipFrame.origin.y},snipView.frame.size} afterScreenUpdates:YES];
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}


-(UIImage *)snipCircleImage {
    return [self snipCircleImageBoardWidth:0.f boardColor:nil];
}

-(UIImage *)snipCircleImageBoardWidth:(CGFloat)boardWidth boardColor:(UIColor *)color {
    UIView *snipView = [self.zoomImageView snapshotViewAfterScreenUpdates:YES];
    CGRect targetSnipFrame = CGRectInset(self.cropBoxView.frame, self.cropBoxView.cornerLineWidth, self.cropBoxView.cornerLineWidth);
    
    CGFloat targetSnipSize = fmin(targetSnipFrame.size.width, targetSnipFrame.size.height);
    CGFloat spaceW = (CGRectGetWidth(targetSnipFrame) - targetSnipSize)/2;
    CGFloat spaceH = (CGRectGetHeight(targetSnipFrame) - targetSnipSize)/2;
    targetSnipFrame.origin.x += spaceW;
    targetSnipFrame.origin.y += spaceH;
    targetSnipFrame.size = CGSizeMake(targetSnipSize, targetSnipSize);
    
    UIGraphicsBeginImageContextWithOptions(targetSnipFrame.size, NO, 0);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, targetSnipSize, targetSnipSize)];
    [clipPath addClip];
    [snipView drawViewHierarchyInRect:(CGRect){{-targetSnipFrame.origin.x,-targetSnipFrame.origin.y},snipView.frame.size} afterScreenUpdates:YES];
    if (boardWidth) {
        [clipPath setLineWidth:boardWidth];
        [color set];
        [clipPath stroke];
    }
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}
@end
