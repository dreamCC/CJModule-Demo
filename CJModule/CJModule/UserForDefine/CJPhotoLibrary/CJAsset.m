//
//  CJAsset.m
//  CJModule
//
//  Created by 仁和Mac on 2018/9/14.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJAsset.h"
#import "CJPhotoLibManager.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface CJAsset()

@property(nonatomic, strong, readwrite) PHAsset *asset;
@property(nonatomic, assign, readwrite) CJAssetType assetType;
@property(nonatomic, assign, readwrite) CJAssetSubType assetSubType;

@end

@implementation CJAsset

-(instancetype)initWithAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        self.asset = asset;
    }
    return self;
}



-(UIImage *)originalImage {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    __block UIImage *originalImage;
    [[CJPhotoLibManager shareInstance].phCachingImageManager requestImageForAsset:self.asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        originalImage = result;
    }];
    return originalImage;
    
}

-(void)requestOriginalImageComplementhandle:(void(^)(UIImage *image, NSDictionary *info))complementhandle progressHandler:(PHAssetImageProgressHandler)progressHandler {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.progressHandler = progressHandler;
    [[CJPhotoLibManager shareInstance].phCachingImageManager requestImageForAsset:self.asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        complementhandle(result, info);
    }];
}

-(void)setAsset:(PHAsset *)asset {
    _asset = asset;
 
    switch (asset.mediaType) {
        case PHAssetMediaTypeImage:
        {
            self.assetType = CJAssetTypeImage;
            if ([[asset valueForKey:@"_uniformTypeIdentifier"] isEqualToString:CFBridgingRelease(kUTTypeGIF)]) {
                self.assetSubType = CJAssetSubTypeGIF;
            }else {
                if (@available(iOS 9.1,*)) {
                    if (asset.mediaSubtypes & PHAssetMediaSubtypePhotoLive) {
                        self.assetSubType = CJAssetSubTypeLivePhoto;
                    }else {
                        self.assetSubType = CJAssetSubTypeImage;
                    }
                }else {
                    self.assetSubType = CJAssetSubTypeImage;
                }
            }
        }
            break;
        case PHAssetMediaTypeVideo:
            self.assetType = CJAssetTypeVideo;
            break;
        case PHAssetMediaTypeAudio:
            self.assetType = CJAssetTypeAudio;
            break;
        default:
            break;
    }
}

@end
