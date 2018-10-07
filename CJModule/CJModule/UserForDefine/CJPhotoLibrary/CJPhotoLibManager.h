//
//  CJPhotoLibManager.h
//  CJModule
//
//  Created by 仁和Mac on 2018/9/14.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "CJAssetGroup.h"

typedef NS_ENUM(NSUInteger, CJAuthorizationStatus) {
    CJAuthorizationStatusAuthorized,
    CJAuthorizationStatusDenied,
    CJAuthorizationStatusNotDetermined,
};



@interface CJPhotoLibManager : NSObject

+(instancetype)shareInstance;

+(CJAuthorizationStatus)authorizationStatus;

+(void)requestAuthorization:(void(^)(CJAuthorizationStatus status))handle;

-(void)enumerateAllAlbumsUsingBlock:(void(^)(CJAssetGroup *assetGroup))handle;

-(PHCachingImageManager *)phCachingImageManager;
@end

@interface PHPhotoLibrary (AssetCollection)

+(NSArray<PHAssetCollection *> *)fetchAllAssetCollections;

+(NSArray<PHAssetCollection *> *)fetchSmartAssetCollections;

+(NSArray<PHAssetCollection *> *)fetchUserAssetCollections;

+(NSArray<PHAssetCollection *> *)fetchAssetCollectionsWithAssetCollectionType:(PHAssetCollectionType)collectionType
                                                       assetCollectionSubType:(PHAssetCollectionSubtype)collectionSubType;

@end


