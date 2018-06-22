//
//  CJDownloaderManager.m
//  CommonProject
//
//  Created by 仁和Mac on 2017/2/2.
//  Copyright © 2018年 zhucj. All rights reserved.
//


#if DEBUG
#define CJLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define CJLog(format, ...)
#endif

#import "CJDownloaderManager.h"


static NSString *const kSessionConfigId = @"com.kSessionConfigId.cj";
@interface CJDownloaderManager()<NSURLSessionDownloadDelegate,NSURLSessionDelegate>

@property(nonatomic, strong) NSMutableArray<CJDownloadSource *> *downloadSources;
@property(nonatomic, copy)   CJDownloadCompletion completion;
@property(nonatomic, strong) NSString *kDefaultSavePath;

@end



@implementation CJDownloaderManager

+(instancetype)shareManager {
    static CJDownloaderManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CJDownloaderManager alloc] init];

    });
    return manager;
}


-(instancetype)init {
    self = [super init];
    if (!self) return nil;
 
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:kSessionConfigId];
    
    _session  = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    return self;
}


-(BOOL)setDownloadSavePath:(NSString *)savePath error:(NSError *__autoreleasing *)error {
    if (!savePath) {
        NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        savePath = [caches stringByAppendingPathComponent:@"CJDownloader"];
    }
    _kDefaultSavePath = savePath;
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:_kDefaultSavePath]) {
        *error = [[NSError alloc] initWithDomain:@"com.CJDownloadCreateSavePath.errorDomain"
                                            code:-101
                                        userInfo:@{NSLocalizedDescriptionKey:@"savePath is already exist"}];
        return NO;
    }
    
    return [manager createDirectoryAtPath:_kDefaultSavePath withIntermediateDirectories:YES attributes:nil error:error];
}


#pragma mark -- 下载

-(CJDownloadSource *)startDownloadWithResumeData:(NSData *)resumeData {
    CJDownloadSource *source = [CJDownloadSource new];
    source.downloadState     = CJDownloadStateDownloading;
    NSURLSessionDownloadTask *task = [_session downloadTaskWithResumeData:resumeData];
    source.task              = task;
    [task resume];
    return source;
}


-(CJDownloadSource *)startDownloadWithPath:(NSString *)path {
    return [self startDownloadWithPath:path fileName:nil];
}

-(CJDownloadSource *)startDownloadWithPath:(NSString *)path
                    fileName:(NSString *)fileName {
    
    fileName = fileName ?:[path lastPathComponent];

    if (!_kDefaultSavePath) {
        CJLog(@"you must invoke 'setDownloadSavePath:error:' first to setup savePath");
        return nil;
    }
    
    NSString *fullPath = [_kDefaultSavePath stringByAppendingPathComponent:fileName];
    BOOL isExist       = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
    if (isExist) {
        CJLog(@"文件已存在");
        return nil;
    }
    
    CJDownloadSource *isHaveSource = [self downloadSourceWithPath:path];
    if (isHaveSource) {
        CJLog(@"已在下载队列中");
        return nil;
    }
    
    NSString *downloadString  = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (downloadString.length == 0) {
        CJLog(@"下载地址有问题");
        return nil;
    }
    
    CJDownloadSource *source = [CJDownloadSource new];
    source.savePath = _kDefaultSavePath;
    source.fileName = fileName;
    source.path     = path;
    source.saveFullPath  = fullPath;
    NSURL *url = [NSURL URLWithString:downloadString];
    NSURLSessionDownloadTask *downloadTask = [_session downloadTaskWithURL:url];
    
    source.task          = downloadTask;
    source.downloadState = CJDownloadStateDownloading;
    [(NSMutableArray *)self.downloadSources addObject:source];
    [downloadTask resume];
    return source;
}



-(void)stopDownloadWithPath:(NSString *)path {
    CJDownloadSource *source = [self downloadSourceWithPath:path];
    if (source.downloadState == CJDownloadStateDownloading) {
        [source.task suspend];
        source.downloadState = CJDownloadStatePause;
    }
}

-(void)stopAllDownload {
    for (CJDownloadSource *source in self.downloadSources) {
        [self stopDownloadWithPath:source.path];
    }
}

-(void)continueDownloadWithPath:(NSString *)path {
    CJDownloadSource *source = [self downloadSourceWithPath:path];
    if (source.downloadState == CJDownloadStatePause) {
        [source.task resume];
        source.downloadState = CJDownloadStateDownloading;
    }
}

-(void)continueAllDownload {
    for (CJDownloadSource *source in self.downloadSources) {
        [self continueDownloadWithPath:source.path];
    }
}

-(void)cancelDownloadWithPath:(NSString *)path {
    CJDownloadSource *source = [self downloadSourceWithPath:path];
    if (source) {
        [source.task cancel];
        [(NSMutableArray *)self.downloadSources removeObject:source];
    }
}

-(void)cancelAllDownload {
    for (CJDownloadSource *source in self.downloadSources) {
        [self cancelDownloadWithPath:source.path];
    }
}

-(void)invalidDownloadWaitUntilCompleteTask:(BOOL)wait {
    if (!_session) return;
    if (wait) {
        [_session finishTasksAndInvalidate];
    }else {
        [_session invalidateAndCancel];
    }
    
}

-(CJDownloadSource *)downloadSourceWithPath:(NSString *)path {
    for (CJDownloadSource *source in self.downloadSources) {
        if ([source.path isEqualToString:path]) {
            return source;
        }
    }
    return nil;
}
#pragma mark --- urlSessionDownloadDelegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    CJDownloadSource *source = [self downloadSourceWithDownloadTask:downloadTask];
    source.totalBytesExpectedToWrite = totalBytesExpectedToWrite;
    CGFloat progress         = (1.0)*totalBytesWritten / totalBytesExpectedToWrite ;
    source.progress          = progress;
    if (source.downloadProgress) {
        source.downloadProgress(progress);
    }
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    CJDownloadSource *source = [self downloadSourceWithDownloadTask:downloadTask];
    NSURL *destinationUrl    = [NSURL fileURLWithPath:source.saveFullPath];
    
    NSError *error;
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:destinationUrl error:&error];
    if (error) {
        CJLog(@"move Item to URL error-%@",error);
        return;
    }
    
    [(NSMutableArray *)self.downloadSources removeObject:source];
    if (source.downloadCompletion) {
        source.downloadCompletion();
    }
    
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {

    if (error) {
        NSDictionary *errorDic = error.userInfo;
        
        
        // 如果是杀掉程序
        NSData * resumeData;
        if ([[errorDic objectForKey:NSURLErrorBackgroundTaskCancelledReasonKey] intValue] == 0) {
            resumeData  = [errorDic objectForKey:NSURLSessionDownloadTaskResumeData];

        }
        
        if (self.downLoadFailed) {
            self.downLoadFailed((NSURLSessionDownloadTask *)task, resumeData, error);
        }
    }
}   


#pragma mark --- sessionDelegate
-(void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
     CJLog(@"session销毁--------");
}

-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    if (self.backgroundCompletionHandler) {
        self.backgroundCompletionHandler();
    }
}

#pragma mark -- private
-(CJDownloadSource *)downloadSourceWithDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    NSString *path = downloadTask.currentRequest.URL.absoluteString;
    return [self downloadSourceWithPath:path];
}

#pragma mark -- setter & getter
-(NSMutableArray<CJDownloadSource *> *)downloadSources {
    if (!_downloadSources) {
        _downloadSources = [NSMutableArray array];
    }
    return _downloadSources;
}


-(void)setDownloadInBackgroud:(BOOL)downloadInBackgroud {
    _downloadInBackgroud = downloadInBackgroud;
    if (!downloadInBackgroud) {
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
}

-(void)setAllowsCellularAccess:(BOOL)allowsCellularAccess {
    _allowsCellularAccess = allowsCellularAccess;
    if (_session) {
        _session.configuration.allowsCellularAccess = allowsCellularAccess;
    }
}

-(void)dealloc {
    NSLog(@"释放了");
}

@end
