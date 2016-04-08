//
//  MessageAttachmentModel.h
//  Titans
//
//  Created by Remon Lv on 14-10-7.
//  Copyright (c) 2014年 Remon Lv. All rights reserved.
//  消息附件Model

#import <Foundation/Foundation.h>

@interface MessageAttachmentModel : NSObject

/// 文件名称
@property (nonatomic,copy) NSString  *fileName;
/// 文件的大小
@property (nonatomic,assign) NSInteger fileSize;
/// 文件原始URL
@property (nonatomic,copy) NSString  *fileUrl;
/// 缩略图URL
@property (nonatomic,copy) NSString  *thumbnail;

/// 缩略图宽高 如果有的话
@property (nonatomic, assign) double thumbnailWidth;
@property (nonatomic, assign) double thumbnailHeight;

/// 音频时长
@property (nonatomic, assign) NSInteger audioLength;             // 音频时长

/// 文件的尺寸大小显示 10M 8K ...
@property (nonatomic,copy) NSString *fileSizeString;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
