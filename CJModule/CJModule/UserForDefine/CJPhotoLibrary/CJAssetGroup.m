//
//  CJAssetGroup.m
//  CJModule
//
//  Created by 仁和Mac on 2018/9/14.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJAssetGroup.h"
#import "CJPhotoLibManager.h"

@interface CJAssetGroup()

@property(nonatomic, strong, readwrite) PHAssetCollection *assetCollection;
@property(nonatomic, strong, readwrite) PHFetchResult<PHAsset *> *fetchResult;

@end

@implementation CJAssetGroup

-(instancetype)initWithAssetCollection:(PHAssetCollection *)assetCollection {
    return [self initWithAssetCollection:assetCollection options:nil];
}

-(instancetype)initWithAssetCollection:(PHAssetCollection *)assetCollection options:(PHFetchOptions *)options {
    self = [super init];
    if (self) {
        self.assetCollection = assetCollection;
        self.fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
    }
    return self;
}

-(NSUInteger)numbersOfAsset {
    return self.fetchResult.count;
}

-(UIImage *)posterImageTargetSize:(CGSize)targetSize {
    if (self.fetchResult.count <= 0) return nil;
    __block UIImage *resultImage;
    PHAsset *asset = self.fetchResult.firstObject;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    [[CJPhotoLibManager shareInstance].phCachingImageManager requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        resultImage = result;
    }];
    return resultImage;
}

-(void)enumerateAssetsUsingBlock:(void (^)(CJAsset *))handle {
    if (self.fetchResult.count == 0) {
        if (handle) {
            handle(nil);
        }
    }
    
    for (int i = 0; i< self.fetchResult.count; i++) {
        PHAsset *asset = self.fetchResult[i];
        CJAsset *cj_asset = [[CJAsset alloc] initWithAsset:asset];
        handle(cj_asset);
    }
    handle(nil);
    
}


@end
