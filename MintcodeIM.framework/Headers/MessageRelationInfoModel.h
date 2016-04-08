//
//  MessageRelationInfoModel.h
//  MintcodeIM
//
//  Created by williamzhang on 16/3/22.
//  Copyright © 2016年 William Zhang. All rights reserved.
//  好友model

#import <Foundation/Foundation.h>

@interface MessageRelationInfoModel : NSObject

/// 数据库自增长Id
@property (nonatomic, assign) NSInteger sqlId;
/// 分组Id
@property (nonatomic, assign) long relationGroupId;
/// 好友Uid
@property (nonatomic, copy) NSString *relationName;
/// 好友备注名
@property (nonatomic, copy) NSString *remark;
/// 好友标签
@property (nonatomic, copy) NSString *tag;
/// 好友昵称   按照这个倒序排序
@property (nonatomic, copy) NSString *nickName;
/// 好友头像
@property (nonatomic, copy) NSString *relationAvatar;
/// 用户更新时间戳
@property (nonatomic, assign) long long relationModified;
/// app名称
@property (nonatomic, copy) NSString *appName;
/// 手机号码
@property (nonatomic,strong) NSString * mobile ;
/// 是否是好友
@property (nonatomic,assign) BOOL  relation ;

+ (MessageRelationInfoModel *)modelWithDict:(NSDictionary *)dict;

@end
