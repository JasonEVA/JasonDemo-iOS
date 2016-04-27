//
//  UnifiedLoginManager.m
//  launcher
//
//  Created by William Zhang on 15/7/30.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//  用户信息管理

#import "UnifiedLoginManager.h"
//#import <MagicalRecord/CoreData+MagicalRecord.h>
//#import "SettingModel.h"

static NSString *const tableName = @"usersInfo";

@implementation UnifiedLoginManager

// 单例
+ (UnifiedLoginManager *)share {
    static UnifiedLoginManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *strPath = [NSString stringWithFormat:@"%@.sqlite",tableName];
        //[MagicalRecord setupCoreDataStackWithStoreNamed:strPath];
    }
    return self;
}

- (void)insertData:(SettingModel *)model {
 //   SettingModel *settingModel = [self findDataModelWithLoginName:model.loginName];
//
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//        if (settingModel)
//        {
//            // 已存在，更新
//            SettingModel *settingModelTmp = [settingModel MR_inContext:localContext];
//            settingModelTmp.graphicPassword = model.graphicPassword;
//            settingModelTmp.headPicture = model.headPicture;
//            settingModelTmp.isLogin = model.isLogin;
//        }
//        else
//        {
//            SettingModel *settingModelTmp = [SettingModel MR_createInContext:localContext];
//            settingModelTmp.loginName = model.loginName;
//            settingModelTmp.graphicPassword = model.graphicPassword;
//            settingModelTmp.headPicture = model.headPicture;
//            settingModelTmp.isLogin = model.isLogin;
//        }
//    }];
}

//- (SettingModel *)findDataModelWithLoginName:(NSString *)loginName
//{
//    return [[SettingModel MR_findByAttribute:@"loginName" withValue:loginName] firstObject];
//}

@end
