//
//  BreakpointResumeRequest.m
//  Reshape
//
//  Created by jasonwang on 15/12/10.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import "BreakpointResumeRequest.h"

@interface BreakpointResumeRequest()<NSURLSessionDataDelegate>

@end
@implementation BreakpointResumeRequest

#pragma mark - Private Method

// 监听当前文件的下载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSProgress *progress = (NSProgress *)object;
    CGFloat progressValue = 1.0 * progress.completedUnitCount / progress.totalUnitCount;
    NSLog(@"%zd--%zd--%f",progress.completedUnitCount,progress.totalUnitCount,progressValue);
    //    [self.introView setCacheProgress:progressValue];
    if ([self.delegate respondsToSelector:@selector(requestBreakpointResumeWithRequest:progress:)]) {
        [self.delegate requestBreakpointResumeWithRequest:self progress:progressValue];
    }
}

// 已下载文件大小
- (long long)downloadedFileDataSizeWithSavePath:(NSString *)savePath {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager]; // default is not thread safe
    if ([fileManager fileExistsAtPath:savePath]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:savePath error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

- (void)breakpointResumeComplete {
    if ([self.delegate respondsToSelector:@selector(requestBreakpointResumeComplete:)]) {
        [self.delegate requestBreakpointResumeComplete:self];
    }

}

- (void)breakpointResumeFaild {
    if ([self.delegate respondsToSelector:@selector(requestBreakpointResumeFail:)]) {
        [self.delegate requestBreakpointResumeFail:self];
    }
    
}
#pragma mark - Interface Method
//- (NSURLSessionDownloadTask *)requestSessionDownloadFileDataWithDelegate:(id<BreakpointResumeRequestDelegate>)delegate URL:(NSString *)urlString savePath:(NSString *)savePath {
//
//    // 是否已下载
//    long long fileSize = [self downloadedFileDataSizeWithSavePath:savePath];
//
//    // 代理设置
//    self.delegate = delegate;
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] init];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    if (fileSize > 0) {
//        // 下载过则继续下载
//        [request setValue:[NSString stringWithFormat:@"bytes=%llu-",fileSize] forHTTPHeaderField:@"Range"];
//    }
//    NSProgress *progress = nil;
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        NSURL *filePathUrl = [NSURL fileURLWithPath:savePath];
//        return filePathUrl;
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error) {
//        if (!error) {
//            NSLog(@"文件下载完毕---%@",filePath);
//            [self breakpointResumeComplete];
//        } else {
//            NSLog(@"文件下载出错---%@",error.localizedDescription);
//        }
//    }];
//    NSLog(@"-------------->task %@",downloadTask);
//    // 监听下载进度
//    [progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:nil];
//    // 启动任务
//    [downloadTask resume];
//    self.sessionManager = manager;
//    return downloadTask;
//}

//- (AFHTTPRequestOperation *)requestOperationDownloadFileDataWithDelegate:(id<BreakpointResumeRequestDelegate>)delegate URL:(NSString *)urlString savePath:(NSString *)savePath;
//{
//    
//    // 是否已下载
//    long long fileSize = [self downloadedFileDataSizeWithSavePath:savePath];    // 代理设置
//    self.delegate = delegate;
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    if (fileSize > 0) {
//        // 下载过则继续下载
//        [request setValue:[NSString stringWithFormat:@"bytes=%llu-",fileSize] forHTTPHeaderField:@"Range"];
//    }
//    AFHTTPRequestOperation *manager = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [manager setOutputStream:[[NSOutputStream alloc] initWithURL:[NSURL fileURLWithPath:savePath] append:YES]];
//    
//    __weak typeof(self) weakSelf = self;
//    [manager setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        NSLog(@"%zd--%zd--%zd",bytesRead,totalBytesRead,totalBytesExpectedToRead);
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        if ([strongSelf.delegate respondsToSelector:@selector(requestBreakpointResumeWithRequest:progress:)]) {
//            [strongSelf.delegate requestBreakpointResumeWithRequest:self progress:(CGFloat)totalBytesRead / totalBytesExpectedToRead];
//        }
//        
//    }];
//    [manager start];
//    return manager;
//}

@end
