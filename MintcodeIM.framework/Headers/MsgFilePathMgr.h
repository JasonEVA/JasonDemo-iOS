//
//  MsgFilePathMgr.h
//  PalmDoctorDR
//
//  Created by Remon Lv on 15/5/12.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//  消息专用文件、路径管理

#import <Foundation/Foundation.h>

typedef enum
{
    extension_wav,
    extension_amr
} Extension_audio;       // 音频类型

@interface MsgFilePathMgr : NSObject

/// 单例
+ (MsgFilePathMgr *)share;
//- (void)destroyMyself;

/// 取出对应模块的路径名称
- (NSString *)getSqlPath;

// 获取消息数据文件夹名
- (NSString *)getMessageDirNamePathWithUid:(NSString *)uid;

// 得到视频路径
- (NSString *)newFileWithType:(NSString *)type sessionPreset:(NSString *)sessionPreset uid:(NSString *)uid;
/**
 *  得到音频路径
 *
 *  @param dirName   文件夹名
 *  @param fileName  文件名
 *  @param extension 格式标记
 *
 *  @return 音频路径
 */
- (NSString *)getMessageDirFilePathWithFileName:(NSString *)fileName extension:(Extension_audio)extension uid:(NSString *)uid;

/***************以下方法为进出数据库的方法*************/
/** 剥离沙盒全路径 留下Documents以后的相对路径
 */
- (NSString *)getRelativePathWithAllPath:(NSString *)allPath;

/** 拼接沙盒全路径 拼接Documents以后的相对路径
 */
- (NSString *)getAllPathWithRelativePath:(NSString *)relativePath;

/**批量删除某人或者群组的文件资源目录
 */
- (void)clearAllFileForMessageWithUid:(NSString *)uid;

@end
