//
//  CJMarqueeLabel.m
//  CJModule
//
//  Created by 仁和Mac on 2017/6/23.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJMarqueeLabel.h"

@interface CJMarqueeLabel ()

@property(nonatomic, assign, readwrite) BOOL cj_autoPlay;

@property(nonatomic, strong) CADisplayLink *displayLink;

@property(nonatomic, assign) NSUInteger drawCount;

@property(nonatomic, assign) CGFloat offsetX;

@property(nonatomic, assign) CGSize marqueelSize;

@end

@implementation CJMarqueeLabel

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.lineBreakMode = NSLineBreakByClipping;
        self.clipsToBounds = YES;
        
        [self didInitialize];
    }
    return self;
}

-(void)didInitialize {
    self.cj_pauseTimeInterval = 2.5f;
    self.cj_spacesForHeaderToTrail = 40.f;
    self.cj_speed = .5f;
    
    self.offsetX   = 0;
    self.drawCount = 1;
}

-(void)didMoveToWindow {
    [super didMoveToWindow];
    [self manageDisplayLinkStartOrPause];
}

-(void)drawTextInRect:(CGRect)rect {
    
    if (![self shouldStartMarqueel]) {
        [super drawTextInRect:rect];
        return;
    }
    
    for (int i = 0; i < self.drawCount; i++) {
        CGRect drawRect = CGRectMake(_offsetX + i*_marqueelSize.width, (rect.size.height - _marqueelSize.height)*0.5, _marqueelSize.width, rect.size.height);
        [self.attributedText drawInRect:drawRect];
    }
}

-(void)handleDidplayLink:(CADisplayLink *)displayLink {
    
    self.offsetX -= self.cj_speed;
    if (fabs(self.offsetX) >= self.marqueelSize.width) {
        self.offsetX = 0;
        _displayLink.paused = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_cj_pauseTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.displayLink.paused = NO;
        });
    }
    [self setNeedsDisplay];
}

-(void)manageDisplayLinkStartOrPause {
    CGSize size = [self sizeThatFits:CGSizeZero];
    self.marqueelSize = size;
    
    if (self.window && [self shouldStartMarqueel]) {
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }else {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

-(NSUInteger)drawCount {
    if ([self shouldStartMarqueel]) {
        return 2;
    }else {
        return 1;
    }
}

-(BOOL)shouldStartMarqueel {
    self.cj_autoPlay = self.frame.size.width < self.marqueelSize.width - _cj_spacesForHeaderToTrail;
    return self.cj_autoPlay;
}

-(void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self manageDisplayLinkStartOrPause];
}

-(void)setText:(NSString *)text {
    [super setText:text];
    [self manageDisplayLinkStartOrPause];
}



-(CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDidplayLink:)];
    }
    return _displayLink;
}


@end
