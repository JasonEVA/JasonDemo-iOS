//
//  MessageRelationGroupModel.h
//  MintcodeIM
//
//  Created by williamzhang on 16/3/22.
//  Copyright © 2016年 William Zhang. All rights reserved.
//  好友分组Model

#import <Foundation/Foundation.h>

@interface MessageRelationGroupModel : NSObject

/// 数据库自增长Id
@property (nonatomic, assign) NSInteger sqlId;
/// 分组Id
@property (nonatomic, assign) long relationGroupId;
/// 分组名称
@property (nonatomic, copy) NSString *relationGroupName;
/// 创建时间
@property (nonatomic, assign) long long createDate;
/// app名称
@property (nonatomic, copy) NSString *appName;
// 分组成员列表
@property (nonatomic, strong) NSMutableArray * relationList ;

+ (MessageRelationGroupModel *)modelWithDict:(NSDictionary *)dict;

@end
