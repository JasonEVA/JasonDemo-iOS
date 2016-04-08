//
//  IMConfigure.h
//  MintcodeIM
//
//  Created by williamzhang on 16/3/10.
//  Copyright © 2016年 William Zhang. All rights reserved.
//  IM配置

#import <UIKit/UIKit.h>

extern NSString * const IM_SDK_Version;
extern NSString * const IM_iOS_system_name;

FOUNDATION_EXPORT NSString *IM_iOS_device_type();
FOUNDATION_EXPORT NSString *IM_iOS_device_version();

extern NSString *const MTSocketConnectingNotification; // IM socket连接中
extern NSString *const MTSocketConnectSuccessedNotification; // IM socket连接成功
extern NSString *const MTSocketConnectFailedNotification; // IM socket连接失败

/**
 *  设备被登出
 *  
    object 为原因
 
 *  notification.object = @"用户会话已登录新设备";
 */
extern NSString *const MTLogoutNotification; // 设备被登出

extern NSString *const MTRelationSessionName; // 好友关系分组sessionName