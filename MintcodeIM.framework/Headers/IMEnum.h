//
//  IMEnum.h
//  launcher
//
//  Created by Andrew Shen on 15/9/24.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

#ifndef IMEnum_h
#define IMEnum_h

#define MintcodeIMDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

typedef NS_ENUM(NSInteger, Msg_type) {
    /*****************************曼信消息*****************************/
    msg_usefulMsgMin  = 0,         // 在此之后都是需要显示的消息格式

    msg_personal_text = 1,
    msg_personal_voice,
    msg_personal_image,
    msg_personal_video,            // 视频
    msg_personal_file,             // 文件类型
    msg_personal_alert,            // 系统消息
    msg_personal_mergeMessage,
    
    msg_personal_reSend,           // 重发撤回 (此条只当指令，不显示)
    
    /*****************************应用区*****************************/
    msg_personal_event = 10000,     // 应用类型

    msg_usefulMsgMax = 20000,       // 在此之前都是需要显示的消息格式
    
    /*****************************曼信操作消息*****************************/
    msg_manager_login = 30000,           // socket通道打开后的首次登录用
    msg_manager_loginIn,                 // login成功的返回
    msg_manager_loginOut,                // login失败的返回
    msg_manager_loginKeep,               // 发送心跳/心跳回执公用
    msg_manager_rev,                     // 消息发送成功回执
    msg_personal_modified,               // 用户信息状态
    
    msg_other_timeStamp = 80000,         // 显示时间间隔
};

typedef NS_ENUM(NSInteger,Msg_status)
{
    // 发送
    status_sending = 0,
    status_send_failed,
    status_send_success,
    status_send_waiting, // 上传附件
    // 接收
    status_receiving = 10,
    status_receive_failed,
    status_receive_success,
};       // 信息状态

/// 用户屏蔽会话
typedef NS_ENUM(NSUInteger, userProfileReceiveMode) {
    
    kUserProfileReceiveNormal = 0,
    /** 接受只显示数字 */
    kUserProfileReceiveAccept,
    /** 接受不显示数字 */
    kUserProfileReceiveNoDisturb
};

#endif /* IMEnum_h */
