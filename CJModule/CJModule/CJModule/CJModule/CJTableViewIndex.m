//
//  CJTableViewIndex.m
//  CJModule
//
//  Created by 仁和Mac on 2017/7/13.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJTableViewIndex.h"
#import <objc/runtime.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreText/CoreText.h>

static inline void _swizzleMethod(Class cls, SEL orgSel, SEL swzSel) {
    Method orgMethod = class_getInstanceMethod(cls, orgSel);
    Method swzMethod = class_getInstanceMethod(cls, swzSel);
    IMP orgImp = method_getImplementation(orgMethod);
    IMP swzImp = method_getImplementation(swzMethod);
    BOOL isAdd = class_addMethod(cls, orgSel, swzImp, method_getTypeEncoding(swzMethod));
    if (isAdd) {
        class_replaceMethod(cls, swzSel, orgImp, method_getTypeEncoding(orgMethod));
    }else {
        method_exchangeImplementations(orgMethod, swzMethod);
    }
}

static inline UIImage * _imageWithTintColor(UIImage * image, UIColor *color) {
    if (!image) return nil;
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}

@interface _CJTextLayer: CATextLayer



@end

@implementation _CJTextLayer

-(void)drawInContext:(CGContextRef)ctx {

    CGSize stringSize = [(NSString *)self.string boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize]} context:nil].size;
    
    CGSize size = self.bounds.size;
    // 控制垂直居中的核心代码
    CGRect pathFrame = (CGRect){{(size.width - stringSize.width)/2,(size.height - stringSize.height)/2},{stringSize.width+1,stringSize.height+1}};


    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, pathFrame);
    NSMutableAttributedString *mAttString = [[NSMutableAttributedString alloc] initWithString:self.string];
    [mAttString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)self.foregroundColor range:NSMakeRange(0, mAttString.length)];
    [mAttString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)self.font range:NSMakeRange(0, mAttString.length)];

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)mAttString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, mAttString.length), path, NULL);

    [CATransaction setDisableActions:YES];
    CTFrameDraw(frame, ctx);

    CFRelease(path);
    CFRelease(framesetter);
    CFRelease(frame);

}
@end


@interface CJIndicatorImageView : UIImageView

@property(nonatomic, weak) UILabel *titleLab;
@property(nonatomic, assign) CGSize indicatorSize;


-(void)changeIndicatorPositionY:(CGFloat)positionY title:(NSString *)title;
@end

@implementation CJIndicatorImageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self didInitialize];
    }
    return self;
}

-(void)didInitialize {
    self.indicatorSize = CGSizeMake(50, 50);
    
    NSString *imagePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"sources.bundle/index_indicator"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    self.image  = image;
    
    UILabel *titleLab  = [UILabel new];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [self addSubview:titleLab];
    _titleLab = titleLab;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleLab sizeToFit];
    _titleLab.center = CGPointMake(CGRectGetWidth(self.frame)/2 - 2, CGRectGetHeight(self.frame)/2);
}

-(void)changeIndicatorPositionY:(CGFloat)positionY title:(NSString *)title {
    _titleLab.text = title;
    self.frame = (CGRect){CGPointMake(-(_indicatorSize.width + 2), positionY - _indicatorSize.height/2),_indicatorSize};
    [self setNeedsLayout];
}

-(void)setHidden:(BOOL)hidden {
    if (hidden == self.hidden) return; 
    if (hidden) {
        [UIView animateWithDuration:[CATransaction animationDuration] animations:^{
            self.alpha = 0.f;
        } completion:^(BOOL finished) {
            if (finished) {
                [super setHidden:hidden];
                self.alpha = 1.f;
            }
        }];
    }else {
        [super setHidden:hidden];
    }
}
@end


static NSString *const kUIControlStateNormal   = @"kUIControlStateNormal";
static NSString *const kUIControlStateSelected = @"kUIControlStateSelected";
@interface CJTableViewIndex()

@property(nonatomic,assign) CGFloat indexsStartY;
@property(nonatomic,assign) CGFloat indexsEndY;

@property(nonatomic, strong) _CJTextLayer *previousTouchIndexLayer;
@property(nonatomic, weak) UIImageView *searchImageV;
@property(nonatomic, weak) CJIndicatorImageView *indicatorImgV;


@property(nonatomic, strong) NSMutableArray<_CJTextLayer *> *mTextLayerAry;

@property(nonatomic, strong) NSMutableDictionary<NSString *,UIColor *> *indexColor;
@property(nonatomic, strong) NSMutableDictionary<NSString *,UIColor *> *indexBackgroudColor;

@property(nonatomic, strong, readwrite) NSString *selectString;

@property(nonatomic, strong) UISelectionFeedbackGenerator *feedbackGenerator API_AVAILABLE(ios(10.0));
@end

@implementation CJTableViewIndex


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self didInitialize];
    }
    return self;
}

-(void)didInitialize {
    self.backgroundColor = [UIColor clearColor];
    
    
    self.fontSize   = 10.f;
    self.indexWidth = 16.f;
    self.showSearchIcon    = YES;
    self.showIndicatorView = YES;
    _selectIndex = HUGE; // 防止第一次setSelectIndex：传0时候不识别问题。
    
    
    CJIndicatorImageView *indicatorImgV = [[CJIndicatorImageView alloc] init];
    indicatorImgV.hidden = YES;
    [self addSubview:indicatorImgV];
    _indicatorImgV = indicatorImgV;
    
    NSString *imagePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"sources.bundle/icon_user_search"];
    UIImageView *searchImageV = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath]];
    [self addSubview:searchImageV];
    _searchImageV = searchImageV;
    
    
    [self setIndexsColor:[UIColor lightGrayColor] state:UIControlStateNormal];
    [self setIndexsColor:[UIColor whiteColor] state:UIControlStateSelected];
    [self setIndexsBackgroudColor:[UIColor clearColor] state:UIControlStateNormal];
    [self setIndexsBackgroudColor:[UIColor lightGrayColor] state:UIControlStateSelected];
}


-(void)didInitializeSectionIndexs {
    if (self.mTextLayerAry.count) {
        [self.mTextLayerAry makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self.mTextLayerAry removeAllObjects];
    }
    for (NSInteger i = 0,indexs = self.sectionIndexs.count; i < indexs; i++) {
        _CJTextLayer *textLayer = [_CJTextLayer layer];
        textLayer.fontSize = _fontSize;
        UIFont *font       = [UIFont systemFontOfSize:_fontSize];
        textLayer.font     = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
        textLayer.string   = self.sectionIndexs[i];
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:textLayer];
        [self.mTextLayerAry addObject:textLayer];
    }
}


-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat frameH  = CGRectGetHeight(self.frame);
    CGFloat originY = (frameH - _indexWidth*self.mTextLayerAry.count)*0.5;
    CGFloat originX = (CGRectGetWidth(self.frame) - _indexWidth)*0.5;
    
    if (_searchImageV) {
        _searchImageV.center = CGPointMake(CGRectGetWidth(self.frame)*0.5, originY-_indexWidth*0.5);
    }
    
    for (NSInteger i = 0,indexs = self.mTextLayerAry.count; i < indexs; i++) {
        
        _CJTextLayer *textLayer = self.mTextLayerAry[i];
        textLayer.frame = CGRectMake(originX, originY + i*_indexWidth, _indexWidth, _indexWidth);
        textLayer.cornerRadius = _indexWidth * 0.5;
        textLayer.foregroundColor = [self.indexColor valueForKey:kUIControlStateNormal].CGColor;
        textLayer.backgroundColor = [self.indexBackgroudColor valueForKey:kUIControlStateNormal].CGColor;
        
    }
    
    self.indexsStartY = originY;
    self.indexsEndY   = CGRectGetMaxY(self.mTextLayerAry.lastObject.frame);
}

#pragma mark --- tracking
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    return [self handleSectionIndexsDisplayTouch:touch];
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    return [self handleSectionIndexsDisplayTouch:touch];
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_indicatorImgV.hidden = YES;
    });
}

-(void)cancelTrackingWithEvent:(UIEvent *)event {
    if (!_indicatorImgV) return;
    _indicatorImgV.hidden = YES;

}

-(BOOL)handleSectionIndexsDisplayTouch:(UITouch *)touch {
    CGFloat touchPointY = [touch locationInView:touch.view].y;
    if (touchPointY < _indexsStartY || touchPointY >= _indexsEndY) return YES;
    
    NSInteger touchIndex = floor((touchPointY-_indexsStartY) / _indexWidth);
    if (touchIndex >= self.mTextLayerAry.count) return YES;

    // 点击同一个，不处理。
    _CJTextLayer *touchIndexLayer = self.mTextLayerAry[touchIndex];
    if (_indicatorImgV) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self-> _indicatorImgV.hidden = NO;
            [self->_indicatorImgV changeIndicatorPositionY:(CGRectGetMinY(touchIndexLayer.frame)+self->_indexWidth/2) title:self.sectionIndexs[touchIndex]];
        });
    }
    
    if (touchIndexLayer == self.previousTouchIndexLayer) return YES;
   
    // display
    self.selectString = self.sectionIndexs[touchIndex];
    self.selectIndex = touchIndex;
    
    !self.selectIndexChange?:self.selectIndexChange((UITableView *)self.superview, touchIndex, _selectString);
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0,*)) {
        [self.feedbackGenerator selectionChanged];
    }else {
        AudioServicesPlaySystemSound(1519);
    }
    return YES;
}

-(void)handleSectionIndexsDisplayWithTouchIndex:(NSInteger)touchIndex {
    _CJTextLayer *touchIndexLayer = self.mTextLayerAry[touchIndex];
    [CATransaction setDisableActions:YES];
    touchIndexLayer.backgroundColor = [self.indexBackgroudColor valueForKey:kUIControlStateSelected].CGColor;
    touchIndexLayer.foregroundColor = [self.indexColor valueForKey:kUIControlStateSelected].CGColor;
    if (self.previousTouchIndexLayer) {
        self.previousTouchIndexLayer.backgroundColor = [self.indexBackgroudColor valueForKey:kUIControlStateNormal].CGColor;
        self.previousTouchIndexLayer.foregroundColor = [self.indexColor valueForKey:kUIControlStateNormal].CGColor;
    }
    self.previousTouchIndexLayer = touchIndexLayer;
    
}

#pragma mark -- public method
-(void)resetSectionIndexsDisplay {
    if (self.previousTouchIndexLayer) {
        [CATransaction setDisableActions:YES];
        self.previousTouchIndexLayer.foregroundColor = [self.indexColor valueForKey:kUIControlStateNormal].CGColor;
        self.previousTouchIndexLayer.backgroundColor = [self.indexBackgroudColor valueForKey:kUIControlStateNormal].CGColor;
        self.selectString = nil;
        _selectIndex = HUGE;
    }
}

-(void)setIndexsColor:(UIColor *)color state:(UIControlState)state {
    [self setDictionary:self.indexColor color:color state:state];
    if (state == UIControlStateNormal) {
        _searchImageV.image = _imageWithTintColor(_searchImageV.image, color);
    }
}

-(void)setIndexsBackgroudColor:(UIColor *)color state:(UIControlState)state {
    [self setDictionary:self.indexBackgroudColor color:color state:state];
}

-(void)setDictionary:(NSMutableDictionary *)mDic color:(UIColor *)color state:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
            [mDic setValue:color forKey:kUIControlStateNormal];
            break;
        case UIControlStateSelected:
            [mDic setValue:color forKey:kUIControlStateSelected];
            break;
        default:
            break;
    }
}

#pragma mark -- setter && getter
-(void)setSectionIndexs:(NSArray<NSString *> *)sectionIndexs {
    _sectionIndexs = sectionIndexs;
    [self didInitializeSectionIndexs];
}

-(void)setSelectIndex:(NSUInteger)selectIndex {
    if (selectIndex >= self.mTextLayerAry.count || _selectIndex == selectIndex) return;
    _selectIndex = selectIndex;
    [self handleSectionIndexsDisplayWithTouchIndex:selectIndex];
}

-(void)setShowSearchIcon:(BOOL)showSearchIcon {
    _showSearchIcon = showSearchIcon;
    if (!showSearchIcon && self.searchImageV) {
        [_searchImageV removeFromSuperview];
    }
}

-(void)setShowIndicatorView:(BOOL)showIndicatorView {
    _showIndicatorView = showIndicatorView;
    if (!showIndicatorView && self.indicatorImgV) {
        [_indicatorImgV removeFromSuperview];
    }
}

-(NSMutableDictionary<NSString *,UIColor *> *)indexColor {
    if (!_indexColor) {
        _indexColor = [NSMutableDictionary dictionary];
    }
    return _indexColor;
}

-(NSMutableDictionary<NSString *,UIColor *> *)indexBackgroudColor {
    if (!_indexBackgroudColor) {
        _indexBackgroudColor = [NSMutableDictionary dictionary];
    }
    return _indexBackgroudColor;
}

-(UISelectionFeedbackGenerator *)feedbackGenerator {
    if (!_feedbackGenerator) {
        _feedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
        [_feedbackGenerator prepare];
    }
    return _feedbackGenerator;
}

-(NSMutableArray<_CJTextLayer *> *)mTextLayerAry {
    if (!_mTextLayerAry) {
        _mTextLayerAry = [NSMutableArray array];
    }
    return _mTextLayerAry;
}
@end



@implementation UITableView (CJSectionIndex)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _swizzleMethod([self class], @selector(layoutSubviews), @selector(cj_clayoutSubviews));
    });
}

-(void)cj_clayoutSubviews {
    
    [self cj_clayoutSubviews];
    CJTableViewIndex *tableViewIndex = self.cj_tableViewIndex;
    if (!tableViewIndex) return;
    tableViewIndex.frame = CGRectMake(CGRectGetWidth(self.frame) - 20, self.contentOffset.y, 20, CGRectGetHeight(self.frame));
    [self bringSubviewToFront:tableViewIndex];
}


static char kCj_tableViewIndex;
-(void)setCj_tableViewIndex:(CJTableViewIndex *)cj_tableViewIndex {
    CJTableViewIndex *tableViewIndex = self.cj_tableViewIndex;
    if (tableViewIndex) {
        [tableViewIndex removeFromSuperview];
    }
    
    if (cj_tableViewIndex) {
        self.showsVerticalScrollIndicator = NO;
        objc_setAssociatedObject(self, &kCj_tableViewIndex, cj_tableViewIndex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:cj_tableViewIndex];
    }
}

-(CJTableViewIndex *)cj_tableViewIndex {
    return objc_getAssociatedObject(self, &kCj_tableViewIndex);
}

@end
