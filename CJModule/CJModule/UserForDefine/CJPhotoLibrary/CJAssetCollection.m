//
//  CJAssetCollection.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/6/4.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJAssetCollection.h"
#import "CJPhotoLibraryManager.h"

@interface CJAssetCollection()

@property(nonatomic, strong, readwrite) PHAssetCollection *assetCollection;
@property(nonatomic, strong, readwrite) PHFetchResult<PHAsset *> *fetchResult;


@end

@implementation CJAssetCollection

+(instancetype)assetCollectionWithName:(NSString *)collectionName {
    PHAssetCollection *assetCollection = nil;
    PHFetchResult *result = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:nil];
    for (PHAssetCollection *collection in result) {
        if ([assetCollection.localizedTitle isEqualToString:collectionName]) {
            assetCollection = collection;
        }
    }
    return [[self alloc] initWithAssetCollection:assetCollection];
}

-(instancetype)initWithAssetCollection:(PHAssetCollection *)assetCollection {
    if (self = [super init]) {
        self.assetCollection  = assetCollection;
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        self.fetchResult      = result;
    }
    return self;
}

-(NSString *)name {
    return self.assetCollection.localizedTitle;
}

-(NSInteger)numberOfAsset {
    return self.fetchResult.count;
}

-(UIImage *)posterImageWithSize:(CGSize)size {
    if (self.fetchResult.count == 0) {
        return nil;
    };
    
    __block UIImage *resultImage;
    CGFloat scale = [UIScreen mainScreen].scale;
    PHImageRequestOptions *imageReqOptions = [[PHImageRequestOptions alloc] init];
    imageReqOptions.synchronous = YES;
    imageReqOptions.networkAccessAllowed = YES;
    PHCachingImageManager *manager = [[CJPhotoLibraryManager sharePhotoLibraryManger] phCachingImageManager];
    // 第二个参数尺寸，是像素尺寸pixel， 而不是point。
    [manager requestImageForAsset:self.fetchResult.lastObject
                       targetSize:CGSizeMake(size.width*scale, size.height*scale)
                      contentMode:PHImageContentModeAspectFit
                          options:imageReqOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                              resultImage = result;
                          }];
    return resultImage;
    
}

@end
