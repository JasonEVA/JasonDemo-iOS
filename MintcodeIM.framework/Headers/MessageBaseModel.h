//
//  MessageBaseModel.h
//  Titans
//
//  Created by Remon Lv on 14-9-1.
//  Copyright (c) 2014年 Remon Lv. All rights reserved.
//  消息基类

#import <Foundation/Foundation.h>
#import "MessageAttachmentModel.h"
#import "MessageAppModel.h"
#import "IMEnum.h"

@interface MessageBaseModel : NSObject

/// 数据库中自增长Id
@property (nonatomic)        NSInteger _sqlId;
/// 发送者Uid
@property (nonatomic,strong) NSString *_fromLoginName;
/// 接收者Uid
@property (nonatomic,strong) NSString *_toLoginName;
/// 目标会话Uid
@property (nonatomic,strong) NSString *_target;
/**
 *  存放聊天数据,文本
 *
 *  图片：{\"thumbnailWidth\":400,\"fileName\":\"1457656327425origin.jpg\",\"fileUrl\":\"\\/QVfiqyb\",\"thumbnailHeight\":300,\"thumbnail\":\"\\/QVfiqya\",\"fileSize\":228097}
 *  会解析到attachModel中
 */
@property (nonatomic,strong) NSString *_content;
/// 本地缩略图路径，若为语音则存储本地Amr格式路径
@property (nonatomic,strong) NSString *_nativeThumbnailUrl;
/// 本地原始图路径，若为语音则存储本地WAV路径（语音使用WAV播放）
@property (nonatomic,strong) NSString *_nativeOriginalUrl;
/// 附件显示文件名
@property (nonatomic,strong) NSString *_fileName;
/// 附件待显示大小
@property (nonatomic,strong) NSString *_fileSize;
/**
 *  更多额外信息 (会话名称，发送者姓名，发送者Uid。。。)
 
    {\"atUsers\":[],\"userName\":\"RO6KLB52lQIolAdr\",\"nickName\":\"Jessica Jing\",\"sessionName\":\"Mintcode Group\"}
 */
@property (nonatomic,strong) NSString *_info;
/// 本地时间戳
@property (nonatomic,assign) long long _clientMsgId;
/// 服务器生成msgId
@property (nonatomic,assign) long long _msgId;
/// 待显示的时间时间戳
@property (nonatomic,assign) long long _createDate;
/// 消息类型
@property (nonatomic,assign) Msg_type  _type;
/// 用户资料时间戳
@property (nonatomic,assign) long long _modified;
/// 是否已读 接收YES,发送NO
@property (nonatomic,assign) BOOL       _markReaded;
/// 是否为接受消息
@property (nonatomic,assign) BOOL       _markFromReceive;
/// 接受发送状态
@property (nonatomic,assign) Msg_status _markStatus;
/// 资料完整性
@property (nonatomic) BOOL       _markCompleted;
/// 是否标记为中点
@property (nonatomic) BOOL       _markImportant;    // 重点

// 消息类型model。针对不同的消息类型，从content中解析
/// 附件Model，从content众解析，图片、语音、文件...
@property (nonatomic,strong) MessageAttachmentModel *attachModel;
/// 应用Model
@property (nonatomic,strong) MessageAppModel        *appModel;      // App消息封装成Model

/**
 *  判断_type属性是否为 msg_personal_event到msg_usefulMsgMax之间(不包含2者)
 *
 *  作为显示类型的判断
 *
 *  @return 是否为event事件
 */
- (BOOL)isEventType;

/// 为时间间隔做初始化
- (instancetype)initWithTimeStamp:(long long)timeStamp;

/**
 *  新的StringType和原来的枚举Msg_type之间转换
 */
+ (Msg_type)getMsgTypeFromString:(NSString *)strType;
+ (NSString *)getStringFromMsgType:(Msg_type)msgType;

/**
 *  判断文件资源是否已经下载到位
 *
 *  @return YES/NO
 */
- (BOOL)isFileDownloaded;

/**
 *  获得昵称
 */
- (NSString *)getNickName;

/**
 *  从info获得UserName 群聊消息知道发送者的uid
 */
- (NSString *)getUserName;

/**
 *  获得已读msgId
 */
- (long long)getMsgId;

/** 从info中提取atUser */
- (NSArray *)atUser;

/** 从content中提取新的baseModel */
- (MessageBaseModel *)getContentBaseModel;

@end
