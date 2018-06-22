//
//  CJDownloaderManager.h
//  CommonProject
//
//  Created by 仁和Mac on 2017/2/2.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CJDownloadSource.h"

typedef void(^CJBackgoundCompletionHandler)(void);
typedef void(^CJDownloadFailed)(NSURLSessionDownloadTask *task, NSData *resumeData, NSError *error);

@interface CJDownloaderManager : NSObject

/// 统一session
@property(nonatomic, strong) NSURLSession *session;

/// 所有的下载数据源
@property(nonatomic, strong, readonly) NSArray<CJDownloadSource *> *downloadSources;

/// 是否允许流量下载。默认YES
@property(nonatomic, assign) BOOL allowsCellularAccess;

/// 后台下载，默认是YES。
@property(nonatomic, assign) BOOL downloadInBackgroud;



/*
 如果后台下载，必须在application:handleEventsForBackgroundURLSession:completionHandler: 方法中赋值。不然下面这个block不会执行。
 如下：
-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    [CJDownloaderManager shareManager].completionHandler = completionHandler;
}
 */
@property(nonatomic, copy) CJBackgoundCompletionHandler backgroundCompletionHandler;


/// 下载失败回调。
@property(nonatomic, copy) CJDownloadFailed downLoadFailed;


/// 初始化-单利
+(instancetype)shareManager;


/**
 设置下载保存

 @param savePath 保存路径,默认在caches的CJDownLoad文件夹下面。如果有iCloud云备份，默认在document下面。
 @param error 错误信息
 @return 是否设置成功
 */
-(BOOL)setDownloadSavePath:(NSString *)savePath error:(NSError **)error;



-(CJDownloadSource *)startDownloadWithResumeData:(NSData *)resumeData;
/**
 开始下载

 @param path 路径。默认文件名
 @return 返回下载信息
 */
-(CJDownloadSource *)startDownloadWithPath:(NSString *)path;

/**
 开始下载

 @param path 下载路径
 @param fileName 文件名字，如果传nil，则会将路径后缀作为名字
 */
-(CJDownloadSource *)startDownloadWithPath:(NSString *)path
                    fileName:(NSString *)fileName;


/**
 停止下载

 @param path 下载路径
 */
-(void)stopDownloadWithPath:(NSString *)path;


/**
 停止所有下载
 */
-(void)stopAllDownload;


/**
 继续下载

 @param path 下载路径
 */
-(void)continueDownloadWithPath:(NSString *)path;


/**
 继续所有下载
 */
-(void)continueAllDownload;



/**
 取消下载

 @param path 下载路径
 */
-(void)cancelDownloadWithPath:(NSString *)path;



/**
 取消全部下载
 */
-(void)cancelAllDownload;


/**
 销毁下载session
 */
-(void)invalidDownloadWaitUntilCompleteTask:(BOOL)wait;


/**
 通过path，获取path对应的下载源

 @param path 路径
 @return 下载对象信息
 */
-(CJDownloadSource *)downloadSourceWithPath:(NSString *)path;
@end
