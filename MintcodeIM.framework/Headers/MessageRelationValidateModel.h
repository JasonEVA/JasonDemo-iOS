//
//  MessageRelationValidateModel.h
//  MintcodeIM
//
//  Created by williamzhang on 16/3/23.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, mt_relation_validateState) {
    mt_relation_validateState_default,
    mt_relation_validateState_agree = 2,
    mt_relation_validateState_reject,
    mt_relation_validateState_ignore
};

@interface MessageRelationValidateModel : NSObject

/// 唯一id，可以用作区分
@property (nonatomic, assign) NSInteger validateId;

@property (nonatomic, copy) NSString *appName;
/// 请求人员Uid
@property (nonatomic, copy) NSString *from;
/// 请求人员昵称
@property (nonatomic, copy) NSString *fromNickName;
/// 请求人员头像
@property (nonatomic, copy) NSString *fromAvatar;
/// 请求信息
@property (nonatomic, copy) NSString *content;
/// 请求创建时间
@property (nonatomic, assign) long long createDate;
/// 2:同意 3:拒绝 4:忽略
@property (nonatomic, assign) mt_relation_validateState validateState;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
