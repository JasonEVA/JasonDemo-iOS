//
//  UserProfileModel.h
//  MintcodeIMFramework
//
//  Created by Andrew Shen on 15/6/11.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//  用户信息model

#import <Foundation/Foundation.h>
#import "IMEnum.h"

@interface UserProfileModel : NSObject

/// 用户资料时间戳
@property (nonatomic, assign) long long modified;
/// 用户昵称
@property (nonatomic, strong) NSString  *nickName;
/// 用户头像
@property (nonatomic, strong) NSString  *avatar;
/// 用户类型
@property (nonatomic, strong) NSString  *type;
/** 用户名(唯一showID) */
@property (nonatomic, strong)  NSString  *userName;
/// 群成员
@property (nonatomic, strong) NSMutableArray *memberList;
/// 群组成员JSON 类型
@property (nonatomic, strong) NSString *memberJasonString;
/// 群组标签，若为群组则可以有标签
@property (nonatomic, strong) NSString *tag;
/** 消息接受模式(0：正常状态，1：接受只显示数字，2：接受不显示数字--预留) */
@property (nonatomic, assign) userProfileReceiveMode receiveMode;

// 群Model通过昵称获得他自己的uid
- (NSString *)getGroupMemberUserNameWithNickName:(NSString *)nickName;

/** 利用memberList更新memberJasonString */
- (void)updateMemberJsonString;

@end
