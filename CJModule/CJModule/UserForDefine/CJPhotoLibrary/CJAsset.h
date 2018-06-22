//
//  CJAsset.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/6/5.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>


@interface CJAsset : NSObject

@property(nonatomic, strong, readonly) PHAsset *asset;


/**
 初始化

 @param asset PHAsset
 @return CJAsset
 */
-(instancetype)initWithPHAsset:(PHAsset *)asset;


/**
 原始图片

 @return image
 */
-(UIImage *)originalImage;


/**
 缩略图

 @param size 尺寸，和实际返回的尺寸是有区别的。
 @return image
 */
-(UIImage *)thumbImageWithSize:(CGSize)size;


/**
 预览图

 @return image
 */
-(UIImage *)previewImage;
@end
