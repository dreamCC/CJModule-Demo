//
//  UIImage+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/6.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "UIImage+CJCategory.h"
#import "CJDefines.h"

@implementation UIImage (CJCategory)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CJSwizzleMethod([self class], @selector(description), @selector(cj_description));
    });
}

-(NSString *)cj_description {
    return  [NSString stringWithFormat:@"%@ scale:%f",[self cj_description],self.scale];
}

// 通过颜色，生成图片
+(UIImage *)cj_imageWithColor:(UIColor *)color {
    return [self cj_imageWithColor:color size:CGSizeMake(1, 1)];
}

+(UIImage *)cj_imageWithColor:(UIColor *)color size:(CGSize)size {
    return [self cj_imageWithColor:color size:size corner:0.f];
}

+(UIImage *)cj_imageWithColor:(UIColor *)color size:(CGSize)size corner:(CGFloat)corner {
    if (size.width <=0 || size.height <= 0) {
        return nil;
    }
    CGRect imgRect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ref, color.CGColor);
    if (corner) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:imgRect cornerRadius:corner];
        [path fill];
        [path addClip];
    }else {
        CGContextFillRect(ref, imgRect);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+(UIImage *)cj_imageWithView:(UIView *)view {
    if (!view) return nil;
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ref];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)cj_imageWithView:(UIView *)view afterScreenUpdates:(BOOL)afterScreenUpdates {
    if (!view) return nil;
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    [view drawViewHierarchyInRect:(CGRect){CGPointZero,view.frame.size} afterScreenUpdates:afterScreenUpdates];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(CGSize)cj_pixelSize {
    return CGSizeMake(self.size.width*self.scale, self.size.height*self.scale);
}

-(UIImage *)cj_grayImage {
    CGFloat pixel_w = self.cj_pixelSize.width;
    CGFloat pixel_h = self.cj_pixelSize.height;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, pixel_w, pixel_h, 8, 0, colorSpaceRef, kCGImageAlphaOnly);
    if(!ctx) return nil;
    CGContextDrawImage(ctx, (CGRect){CGPointZero,self.cj_pixelSize}, self.CGImage);
    CGImageRef newImage = CGBitmapContextCreateImage(ctx);
    UIImage *newImg = [UIImage imageWithCGImage:newImage scale:self.scale orientation:self.imageOrientation];
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(newImage);
    CGContextRelease(ctx);
    return newImg;
}


-(UIImage *)cj_imageWithAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:(CGRect){CGPointZero,self.size} blendMode:kCGBlendModeNormal alpha:alpha];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}

// 改变图片tintColor
-(UIImage *)cj_imageWithTintColor:(UIColor *)tintColor {
    return [self cj_imageWithTintColor:tintColor blendModes:@[@(kCGBlendModeDestinationIn),@(kCGBlendModeOverlay)]];
}

-(UIImage *)cj_imageWithTintColor:(UIColor *)tintColor blendModes:(NSArray *)blendModes {
    if (blendModes.count == 0) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [tintColor setFill];
    UIRectFill((CGRect){CGPointZero,self.size});
    for (NSNumber *blendMode in blendModes) {
        [self drawAtPoint:CGPointZero blendMode:blendMode.intValue alpha:1.0f];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


-(UIImage *)cj_imageWithAboveImage:(UIImage *)aboveImage point:(CGPoint)point{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:(CGRect){CGPointZero,self.size}];
    [aboveImage drawAtPoint:point];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}

-(UIImage *)cj_imageWithCornerRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    [arcPath addClip];
    [self drawInRect:rect];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}


-(UIImage *)cj_imageWithCornerRadius:(CGFloat)cornerRadius boardWide:(CGFloat)boardWide boardColor:(UIColor *)boardColor {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    [arcPath addClip];
    [arcPath setLineWidth:boardWide];
    [boardColor set];
    [arcPath stroke];
    CGRect imgRect = CGRectMake(boardWide, boardWide, self.size.width - 2*boardWide, self.size.height - 2*boardWide);
    [self drawInRect:imgRect];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}

@end
