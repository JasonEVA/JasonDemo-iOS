//
//  MessageAppModel.h
//  launcher
//
//  Created by Andrew Shen on 15/10/9.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  消息应用总model like messageBaseModel

#import <Foundation/Foundation.h>
#import "IMEnum.h"

@interface MessageAppModel : NSObject

/// 应用消息类型
@property (nonatomic, assign)  Msg_type eventType;
/// 消息标题
@property (nonatomic, strong)  NSString *msgTitle;
/// 消息内容
@property (nonatomic, strong)  NSString *msgContent;
/// 消息发送人名字
@property (nonatomic, strong)  NSString *msgFrom;
/// 消息发送人id
@property (nonatomic, strong)  NSString *msgFromID;
/// 消息所对应的应用appID
@property (nonatomic, strong)  NSString *msgAppShowID;
/// 消息类型 0=系统消息,1=业务消息
@property (nonatomic, assign)  NSInteger msgType;
/// 消息应用事件类型(评论、会议、事件。。。) 与服务器协商统一
@property (nonatomic, strong)  NSString *msgAppType;
/// 消息是否已读,0=否,1=是
@property (nonatomic, assign)  NSInteger msgReadStatus;
/// 消息是否已处理,0=否,1=是
@property (nonatomic, assign)  NSInteger msgHandleStatus;
/// 相关联项目的详细信息,直接jsonstring存储
@property (nonatomic, strong)  NSString *msgInfo;
/// 系统事件的Id
@property (nonatomic, strong)  NSString *msgRMShowID;
/// 消息翻译类别(若需要，与服务端协商统一)
@property (nonatomic, strong)  NSString *msgTransType;
/// 时间
@property (nonatomic, assign)  long long msgRemark;

/**
 *  应用的详情字典，若有标题，请让服务器统一使用title
 */
@property (nonatomic, strong) NSDictionary *applicationDetailDictionary;

/// 根据type获取showId
+ (NSString *)getShowIDfromAppType:(Msg_type)msgType;

/// 是否是系统消息
- (BOOL)isAppSystemMessage;

@end
