//
//  CJAssetGroup.h
//  CJModule
//
//  Created by 仁和Mac on 2018/9/14.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "CJAsset.h"

typedef NS_ENUM(NSUInteger, CJAlbumContentType) {
    CJAlbumContentTypeAll,
    CJAlbumContentTypeImage,
    CJAlbumContentTypeVideo,
    CJAlbumContentTypeAudio
};

@interface CJAssetGroup : NSObject

@property(nonatomic, strong, readonly) PHAssetCollection *assetCollection;
@property(nonatomic, strong, readonly) PHFetchResult<PHAsset *> *fetchResult;



-(instancetype)initWithAssetCollection:(PHAssetCollection *)assetCollection;

-(instancetype)initWithAssetCollection:(PHAssetCollection *)assetCollection options:(PHFetchOptions *)options;

-(NSUInteger)numbersOfAsset;

-(UIImage *)posterImageTargetSize:(CGSize)targetSize;

-(void)enumerateAssetsUsingBlock:(void(^)(CJAsset *asset))handle;


@end
