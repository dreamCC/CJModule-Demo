//
//  CJAsset.h
//  CJModule
//
//  Created by 仁和Mac on 2018/9/14.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSUInteger, CJAssetType) {
    CJAssetTypeImage,
    CJAssetTypeVideo,
    CJAssetTypeAudio
};

typedef NS_ENUM(NSUInteger, CJAssetSubType) {
    CJAssetSubTypeUnkown,
    CJAssetSubTypeImage,
    CJAssetSubTypeLivePhoto,
    CJAssetSubTypeGIF
};

@interface CJAsset : NSObject

@property(nonatomic, strong, readonly) PHAsset *asset;

@property(nonatomic, assign, readonly) CJAssetType assetType;
@property(nonatomic, assign, readonly) CJAssetSubType assetSubType;

-(instancetype)initWithAsset:(PHAsset *)asset;

-(UIImage *)originalImage;

-(void)requestOriginalImageComplementhandle:(void(^)(UIImage *image, NSDictionary *info))complementhandle progressHandler:(PHAssetImageProgressHandler)progressHandler;

@end
