//
//  UnifiedLoginManager.h
//  launcher
//
//  Created by William Zhang on 15/7/30.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//  登陆时数据管理

#import <Foundation/Foundation.h>

@class SettingModel;

@interface UnifiedLoginManager : NSObject

+ (UnifiedLoginManager *)share;

- (void)insertData:(SettingModel *)model;

/** 查找 */
- (SettingModel *)findDataModelWithLoginName:(NSString *)loginName;

@end
