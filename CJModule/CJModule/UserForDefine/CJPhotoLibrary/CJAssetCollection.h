//
//  CJAssetCollection.h
//  CommonProject
//
//  Created by 仁和Mac on 2018/6/4.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Photos/Photos.h>

@interface CJAssetCollection : NSObject

@property(nonatomic, strong, readonly) PHAssetCollection *assetCollection;

@property(nonatomic, strong, readonly) PHFetchResult<PHAsset *> *fetchResult;


/**
 通过名字来获取CJAssetCollection

 @param collectionName 相册名字
 @return CJAssetCollection
 */
+(instancetype)assetCollectionWithName:(NSString *)collectionName;


/**
 通过PHAssetCollection来初始化

 @param assetCollection PHAssetCollection
 @return CJAssetCollection
 */
-(instancetype)initWithAssetCollection:(PHAssetCollection *)assetCollection;


/**
 相册名字

 @return 名字
 */
-(NSString *)name;


/**
 相册里面有多少个照片

 @return 照片数
 */
-(NSInteger)numberOfAsset;


/**
 相册的封面图片

 @param size size
 @return image
 */
-(UIImage *)posterImageWithSize:(CGSize)size;
@end
