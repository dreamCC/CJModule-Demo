//
//  CJAsset.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/6/5.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJAsset.h"
#import "CJPhotoLibraryManager.h"

@interface CJAsset()

@property(nonatomic, strong, readwrite) PHAsset *asset;


@end

@implementation CJAsset

-(instancetype)initWithPHAsset:(PHAsset *)asset {
    if (self = [super init]) {
        self.asset = asset;
    }
    return self;
}


-(UIImage *)originalImage {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous  = YES;
    options.networkAccessAllowed = YES;
    __block UIImage *resultImage;
    [[CJPhotoLibraryManager sharePhotoLibraryManger].phCachingImageManager requestImageForAsset:self.asset
                                                                                     targetSize:PHImageManagerMaximumSize
                                                                                    contentMode:PHImageContentModeDefault
                                                                                        options:options
                                                                                  resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                                                      resultImage = result;
                                                                                  }];
    return resultImage;
}

-(UIImage *)thumbImageWithSize:(CGSize)size {
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous  = YES;
    options.networkAccessAllowed = YES;
    __block UIImage *resultImage;
    [[CJPhotoLibraryManager sharePhotoLibraryManger].phCachingImageManager requestImageForAsset:self.asset
                                                                                     targetSize:size
                                                                                    contentMode:PHImageContentModeAspectFit
                                                                                        options:options
                                                                                  resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                                                      resultImage = result;
                                                                                  }];
    return resultImage;
}

-(UIImage *)previewImage {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous  = YES;
    options.networkAccessAllowed = YES;
    __block UIImage *resultImage;
    [[CJPhotoLibraryManager sharePhotoLibraryManger].phCachingImageManager requestImageForAsset:self.asset
                                                                                     targetSize:[UIScreen mainScreen].bounds.size
                                                                                    contentMode:PHImageContentModeAspectFit
                                                                                        options:options
                                                                                  resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                                                      resultImage = result;
                                                                                  }];
    return resultImage;
}

@end
