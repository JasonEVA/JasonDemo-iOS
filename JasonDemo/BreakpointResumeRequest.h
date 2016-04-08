//
//  BreakpointResumeRequest.h
//  Reshape
//
//  Created by jasonwang on 15/12/10.
//  Copyright © 2015年 jasonwang. All rights reserved.
//  断点续传请求

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
//#import "UrlInterfaceDefine.h"

@class BreakpointResumeRequest;
@protocol BreakpointResumeRequestDelegate <NSObject>
// 成功和错误返回
@optional
// 成功
- (void)requestBreakpointResumeComplete:(BreakpointResumeRequest *)request;

// 失败
- (void)requestBreakpointResumeFail:(BreakpointResumeRequest *)request;

// 进度
- (void)requestBreakpointResumeWithRequest:(BreakpointResumeRequest *)request progress:(CGFloat)progress;
@end

@interface BreakpointResumeRequest : NSObject

@property (nonatomic, strong)  AFURLSessionManager  *sessionManager; // 下载任务
@property (nonatomic, strong)  NSString  *videoID; // <##>
@property (nonatomic, weak)         id<BreakpointResumeRequestDelegate> delegate;      //回调的委托

// 文件下载
- (NSURLSessionDownloadTask *)requestSessionDownloadFileDataWithDelegate:(id<BreakpointResumeRequestDelegate>)delegate URL:(NSString *)urlString savePath:(NSString *)savePath;

//- (AFHTTPRequestOperation *)requestOperationDownloadFileDataWithDelegate:(id<BreakpointResumeRequestDelegate>)delegate URL:(NSString *)urlString savePath:(NSString *)savePath;
@end
