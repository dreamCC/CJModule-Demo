//
//  CJTextLayer.m
//  CJModule
//
//  Created by 仁和Mac on 2018/7/17.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJTextLayer.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "NSString+CJCategory.h"

@implementation CJTextLayer

-(void)drawInContext:(CGContextRef)ctx {

    CGRect stringRect = [(NSString *)self.string cj_stringRectFontSize:self.fontSize size:CGSizeZero];
    CGSize size = self.bounds.size;
    CGRect pathFrame = (CGRect){{floor(size.width - CGRectGetWidth(stringRect))/2,floor(size.height - CGRectGetHeight(stringRect))/2},stringRect.size};

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, pathFrame);
    NSMutableAttributedString *mAttString = [[NSMutableAttributedString alloc] initWithString:self.string];
    [mAttString addAttribute:NSForegroundColorAttributeName value:CFBridgingRelease(self.foregroundColor) range:NSMakeRange(0, mAttString.length)];
    [mAttString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.fontSize] range:NSMakeRange(0, mAttString.length)];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mAttString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, mAttString.length), path, NULL);
    CTFrameDraw(frame, ctx);
    
    CFRelease(path);
    CFRelease(framesetter);
    CFRelease(frame);

}



@end
