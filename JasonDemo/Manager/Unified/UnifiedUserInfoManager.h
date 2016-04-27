//
//  UnifiedUserInfoManager.h
//  launcher
//
//  Created by William Zhang on 15/7/30.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//  用户信息管理

#import <UIKit/UIKit.h>
//#import "MyDefine.h"

typedef NS_ENUM(NSUInteger, InputHabitMode) {
    kInputHabitNone = 0,
    /** 换行 */
    kInputHabitLineBreak,
    /** 发送 */
    kInputHabitSend
};

@class ContactPersonDetailInformationModel;

@interface UnifiedUserInfoManager : NSObject

/** 切换公司时临时存放的companyCode，在进行网络请求后直接nil */
@property (nonatomic, copy) NSString *companyCodeCached;

// 单例
+ (UnifiedUserInfoManager *)share;

// 存入整个用户信息Model
- (void)saveUserInfoWithContactPersonDetailInformationModel:(ContactPersonDetailInformationModel *)model;
// 删除用户信息
- (void)removeUserInfo;

/** 登录界面时用到的登录账号(存入不加密,取出可选是否加密) */
- (NSString *)getAccountWithEncrypt:(BOOL)mark;
/** 登录界面时用到的登录账号 */
- (void)saveAccount:(NSString *)name;

/** 登录密码，mark 加密 */
- (NSString *)getPasswordWithEncrypt:(BOOL)mark;
- (void)savePassword:(NSString *)password;
// 比较密码
- (BOOL)comparePassword:(NSString *)newPassword;

/** Remote Notification Token
 */
- (NSString *)getRemoteNotifyToken;
- (void)saveRemoteNotifyToken:(NSString *)remoteToken;

/**
 *  获取引导图数组
 *
 *  @return 数组内存放UIImage
 */
- (NSArray *)getGuideImages;

#pragma mark - Version Control

/**
 *  比较本地plist文档与info.plist文档中版本是否一致
 用于判断是否更新
 *
 *  @param isSubVer 是否是子版本
 例如：V2.6主版本 与 V2.6.150210子版本 的区别
 *
 *  @return 是否一致
 */
- (BOOL)isNewVersionIsSubVersion:(BOOL)isSubVer;
- (void)saveVersion:(NSString *)version IsSubVer:(BOOL)isSubVer;
// 当前系统版本
- (NSString *)getCurrentVersionIsSubVer:(BOOL)isSubVer;
- (NSString *)getCurrentVersionName;
- (NSString *)getLastVersionIsSubVer:(BOOL)isSubVer;

#pragma mark - 语言切换
/**
 *  存取用户设置的语言
 *
 *  @return 系统语言选择枚举
 */
//- (void)saveLanguageUserSetting:(LanguageEnum)language;
//- (LanguageEnum)getLanguageUserSetting;
/**
 *  为了BaseRequest操作
 *
 *  @return 中文返回zh-cn，日文返回ja-jp
 */
- (NSString *)getLanguageIdentifier;
/** 获取本地化 */
- (NSLocale *)getLocaleIdentifier;

// 判断是否是跟随系统
- (BOOL)isFollowSystemLanguage;
// 不跟随系统直接取出自定义国际化的value
- (NSString *)getCustomLocalizedValueWithKey:(NSString *)strKey;

/** 用户所属企业名字 */
@property (nonatomic, copy) NSString *companyName;
/** 用户所属企业编码 */
@property (nonatomic, copy) NSString *companyShowID;
/** 用户所属企业域名 */
@property (nonatomic, copy) NSString *companyCode;

@property (nonatomic, copy) NSString *userShowID;
/** 登录帐号 (这个参数可以废了，和userShowID是一样的，请使用userShowID) */
@property (nonatomic, copy) NSString *loginName DEPRECATED_ATTRIBUTE;
/** 真实名字 */
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *authToken;


#pragma mark - 输入习惯设置
/** 输入习惯 */
@property (nonatomic, assign) InputHabitMode inputHabit;

#pragma mark - 设置自定义提示方式
- (NSInteger)getPlaySystemKindType;
- (void)setPlaySystemKindType:(NSInteger)type;

@end
