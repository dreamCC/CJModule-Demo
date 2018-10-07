//
//  CJPhotoLibManager.m
//  CJModule
//
//  Created by 仁和Mac on 2018/9/14.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJPhotoLibManager.h"

@interface CJPhotoLibManager()

@end

static CJPhotoLibManager *manager;
@implementation CJPhotoLibManager {
    PHCachingImageManager *_phCachingImageManager;
}

+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
     
    });
    return manager;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

+(CJAuthorizationStatus)authorizationStatus {
    return [self changePHAuthorizationStatusToCJAuthorizationStatus:[PHPhotoLibrary authorizationStatus]];
}

+(void)requestAuthorization:(void (^)(CJAuthorizationStatus))handle {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        CJAuthorizationStatus authorizedStatus = [self changePHAuthorizationStatusToCJAuthorizationStatus:status];
        handle(authorizedStatus);
    }];
}

+(CJAuthorizationStatus)changePHAuthorizationStatusToCJAuthorizationStatus:(PHAuthorizationStatus)ph_status {
    CJAuthorizationStatus authorized;
    switch (ph_status) {
        case PHAuthorizationStatusAuthorized:
            authorized = CJAuthorizationStatusAuthorized;
            break;
        case PHAuthorizationStatusDenied:
            authorized = CJAuthorizationStatusDenied;
            break;
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusNotDetermined:
            authorized = CJAuthorizationStatusNotDetermined;
            break;
        default:
            break;
    }
    return authorized;
}

-(void)enumerateAllAlbumsUsingBlock:(void (^)(CJAssetGroup *))handle {
    NSArray<PHAssetCollection *> *collections = [PHPhotoLibrary fetchAllAssetCollections];
    for (PHAssetCollection *assetCollection in collections) {
        CJAssetGroup *group = [[CJAssetGroup alloc] initWithAssetCollection:assetCollection];
        if (handle) {
            handle(group);
        }
    }
    if (handle) {
        handle(nil);
    }
}

-(PHCachingImageManager *)phCachingImageManager {
    if (!_phCachingImageManager) {
        _phCachingImageManager = [[PHCachingImageManager alloc] init];
    }
    return _phCachingImageManager;
}

@end

@implementation PHPhotoLibrary (AssetCollection)

+(PHFetchOptions *)creatAssetFetchOptionWithContentType:(CJAlbumContentType)contentType {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];;
    switch (contentType) {
        case CJAlbumContentTypeImage:
            options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i",PHAssetMediaTypeImage];
            break;
        case CJAlbumContentTypeAudio:
            options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i",PHAssetMediaTypeAudio];
            break;
        case CJAlbumContentTypeVideo:
            options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i",PHAssetMediaTypeVideo];
            break;
        default:
            break;
    }
    return options;
}

+(NSArray<PHAssetCollection *> *)fetchAllAssetCollections {
    NSMutableArray<PHAssetCollection *> *tempArray;
    [tempArray addObjectsFromArray:[self fetchSmartAssetCollections]];
    [tempArray addObjectsFromArray:[self fetchUserAssetCollections]];
    return tempArray.copy;
}


+(NSArray<PHAssetCollection *> *)fetchSmartAssetCollections {
    return [self fetchAssetCollectionsWithAssetCollectionType:PHAssetCollectionTypeSmartAlbum assetCollectionSubType:PHAssetCollectionSubtypeAny];
}

+(NSArray<PHAssetCollection *> *)fetchUserAssetCollections {
    
    return [self fetchAssetCollectionsWithAssetCollectionType:PHAssetCollectionTypeAlbum assetCollectionSubType:PHAssetCollectionSubtypeAny];
}

+(NSArray<PHAssetCollection *> *)fetchAssetCollectionsWithAssetCollectionType:(PHAssetCollectionType)collectionType assetCollectionSubType:(PHAssetCollectionSubtype)collectionSubType {
    NSMutableArray<PHAssetCollection *> *tempArray;
    PHFetchResult<PHAssetCollection *> *smartResult = [PHAssetCollection fetchAssetCollectionsWithType:collectionType subtype:collectionSubType options:nil];
    [smartResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.localizedTitle) {
            if (obj.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                [tempArray insertObject:obj atIndex:0];
            }else {
                [tempArray addObject:obj];
            }
        }
    }];
    return tempArray.copy;
}

@end








