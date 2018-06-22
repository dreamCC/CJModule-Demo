//
//  CJDownloadSource.h
//  CommonProject
//
//  Created by 仁和Mac on 2017/2/2.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJDownloadState) {
    CJDownloadStateDownloading,
    CJDownloadStatePause
};

typedef void(^CJDownloadCompletion)(void);
typedef void(^CJDownloadProgress)(CGFloat progress);

@interface CJDownloadSource : NSObject<NSCoding>

/// 下载task
@property(nonatomic, strong) NSURLSessionDownloadTask *task;

/// 保存路径
@property(nonatomic, strong) NSString *savePath;

/// 文件名
@property(nonatomic, strong) NSString *fileName;

/// 保存全路径
@property(nonatomic, strong) NSString *saveFullPath;

/// 下载路径
@property(nonatomic, strong) NSString *path;

/// 文件长度
@property (nonatomic, assign) int64_t totalBytesExpectedToWrite;

/// 暂停data
@property(nonatomic, strong) NSData *resumeData;

/// 状态
@property (nonatomic, assign) CJDownloadState downloadState;

/// 下载进度
@property (nonatomic, assign) CGFloat progress;

/// 下载进度回调
@property(nonatomic, copy) CJDownloadProgress downloadProgress;

/// 下载完成回调
@property(nonatomic, copy) CJDownloadCompletion downloadCompletion;

@end
