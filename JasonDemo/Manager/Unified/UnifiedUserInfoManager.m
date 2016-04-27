//
//  UnifiedUserInfoManager.m
//  launcher
//
//  Created by William Zhang on 15/7/30.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import "UnifiedUserInfoManager.h"
//#import "ContactPersonDetailInformationModel.h"
#import "NSString+Manager.h"
#import "NSString+Unified.h"
#import "NSData+AES256.h"

@interface UnifiedUserInfoManager ()

@end

static NSUserDefaults *userDefault = nil;

@implementation UnifiedUserInfoManager

+ (UnifiedUserInfoManager *)share {
    static UnifiedUserInfoManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        userDefault = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)saveUserInfoWithContactPersonDetailInformationModel:(ContactPersonDetailInformationModel *)model {
    if (!model) {
        return;
    }
    
//    self.companyShowID = model.c_show_id;
//    self.userShowID = model.show_id;
//    self.loginName = model.u_name;
//    self.userName = model.u_true_name;
}

// 删除用户信息
- (void)removeUserInfo {
//    [userDefault removeObjectForKey:lDefaults_account];
}

// 登录用户名
//- (NSString *)getAccountWithEncrypt:(BOOL)mark {
//    if (mark) {
//        return [NSData AES256EncryptWithPlainText:[userDefault objectForKey:lDefaults_account] withKey:KindUser];
//    }
    
  //  return [userDefault objectForKey:lDefaults_account];
//}

- (void)saveAccount:(NSString *)name {
    // 去空格，除首字母外全小写
    name = [NSString removeBlankInString:name OnlyMarginal:NO];
    name = [name lowercaseString];
    name = [name firstLetterUpper];
    
    //[userDefault setObject:name forKey:lDefaults_account];
    [userDefault synchronize];
}

// 登录密码
//- (NSString *)getPasswordWithEncrypt:(BOOL)mark {
//    if (mark) {
//        return [userDefault objectForKey:lDefaults_userpassword];
//    }
//   
//    NSString *strTemp = [userDefault objectForKey:lDefaults_userpassword];
//    return [NSData AES256DecryptWithCiphertext:strTemp withKey:KindUser];
//}

- (void)savePassword:(NSString *)password {
//    [userDefault setObject:[NSData AES256EncryptWithPlainText:password withKey:KindUser] forKey:lDefaults_userpassword];
    [userDefault synchronize];
}

// 比较密码
- (BOOL)comparePassword:(NSString *)newPassword {
    return [[NSData AES256EncryptWithPlainText:newPassword withKey:KindUser] isEqualToString:[self getPasswordWithEncrypt:YES]];
}

// Remote Notification Token
- (NSString *)getRemoteNotifyToken
{
    NSString *remoteToken = @"";
//    if ([userDefault objectForKey:lDefaults_remotetoken] != nil)
//    {
//        remoteToken = [userDefault objectForKey:lDefaults_remotetoken];
//    }
    return remoteToken;
}

- (void)saveRemoteNotifyToken:(NSString *)remoteToken
{
    // 写入
    //[userDefault setObject:remoteToken forKey:lDefaults_remotetoken];
    // 更新配置
    [userDefault synchronize];
}

/**
 *  获取引导图数组
 *
 *  @return 数组内存放UIImage
 */
- (NSArray *)getGuideImages
{
    NSString *strName = [self getPartialImageName];
    
    NSMutableArray *arrImg = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 1; i <= 3; i++)
    {
        NSString *strImg = [NSString stringWithFormat:@"guide%ld_%@",(long)i, strName];
        UIImage *imgGuide = [UIImage imageNamed:strImg];
        [arrImg addObject:imgGuide];
    }
    return arrImg;
}

#pragma mark - Private Method

/**
 *  获取不同设备对应的图片名称中的局部用于拼接
 *
 *  @return 局部名称
 */
- (NSString *)getPartialImageName
{
    NSString *strName = @"";
//    if (IOS_DEVICE_4)
//    {
//        strName = @"640960";
//    }
//    else if (IOS_DEVICE_5)
//    {
//        strName = @"6401136";
//    }
//    else if (IOS_DEVICE_6)
//    {
//        strName = @"7501334";
//    }
//    else if (IOS_DEVICE_6Plus)
//    {
//        strName = @"12422208";
//    }
    return strName;
}

//- (BOOL)isNewVersionIsSubVersion:(BOOL)isSubVer
//{
//    BOOL result;
//    // 上次版本
//   // NSString *lastVersion = [userDefault stringForKey:isSubVer ? lDefaults_varsub : lDefaults_varmain];
//    
//    // 项目info.plist中版本
//    NSString *infoVersion = [self getCurrentVersionIsSubVer:isSubVer];
//    
//    // 判断是否有内容
//    if (lastVersion)
//    {
//        result = [lastVersion isEqualToString:infoVersion];
//        if (!result)
//        {
//            // 写入新版本号
//            [self saveVersion:infoVersion IsSubVer:isSubVer];
//            return YES;
//        }
//        
//        return NO;
//    }
//    
//    // 第一次就写入版本号
//    [self saveVersion:infoVersion IsSubVer:isSubVer];
//    return YES;
//}

- (void)saveVersion:(NSString *)version IsSubVer:(BOOL)isSubVer
{
   //efault setObject:version forKey:(isSubVer ? lDefaults_varsub : lDefaults_varmain)];
    [userDefault synchronize];
}

- (NSString *)getCurrentVersionIsSubVer:(BOOL)isSubVer
{
    // 这个可以打印出所有信息
   // PRINT_STRING([[NSBundle mainBundle] infoDictionary]);
    
    NSString *key = isSubVer ? (NSString *)kCFBundleVersionKey : @"CFBundleShortVersionString";
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
}

- (NSString *)getCurrentVersionName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}
//
//- (NSString *)getLastVersionIsSubVer:(BOOL)isSubVer
//{
//    return [userDefault objectForKey:(isSubVer ? lDefaults_varsub : lDefaults_varmain)];
//}

#pragma mark - Locale 国际化
//+ (NSDictionary *) languageDictionary {
//    return @{@(language_chinese):@"zh-Hans",
//             @(language_english):@"zh-Hans",//@"en",
//             @(language_japanese):@"ja"};
//}
//- (BOOL)isFollowSystemLanguage
//{
//    LanguageEnum currLanguage = [self getLanguageUserSetting];
//    return (currLanguage == language_system);
//}
//
//- (NSString *)getCustomLocalizedValueWithKey:(NSString *)strKey
//{
//    LanguageEnum lang = [self getLanguageUserSetting];
//    NSString *strName = @"";
//    if (lang != language_system) {
//        strName = [[UnifiedUserInfoManager languageDictionary] objectForKey:@(lang)];
//    }
//    
//    NSString *strPath = [[NSBundle mainBundle] pathForResource:strName ofType:@"lproj"];
//    NSBundle *bundle = [NSBundle bundleWithPath:strPath];
//    NSString *strValue = [bundle localizedStringForKey:strKey value:@"" table:nil];
//    return strValue;
//}

//- (NSLocale *)getLocaleIdentifier {
//    LanguageEnum lang = [self getLanguageUserSetting];
//    NSLocale *locale;
//    switch (lang) {
//        case language_chinese:
//        case language_english:
//        case language_japanese:
//            locale = [NSLocale localeWithLocaleIdentifier:[[UnifiedUserInfoManager languageDictionary] objectForKey:@(lang)]];
//            break;
//        default:
//            locale = [NSLocale currentLocale];
//            // 搜索不到中文，就都默认日文
//            NSRange range = [locale.localeIdentifier rangeOfString:@"zh"];
//            if (range.location == NSNotFound) {
//                locale = [NSLocale localeWithLocaleIdentifier:@"ja"];
//            }
//            break;
//    }
//    
//    return locale;
//}

//- (LanguageEnum)getLanguageUserSetting
//{
//    NSNumber *numberLan = [userDefault objectForKey:lDefaults_language];
//    if (numberLan) {
//        return [numberLan integerValue];
//    }
//
//    return language_system;
//}

- (NSString *)getLanguageIdentifier {
    NSLocale *locale = [self getLocaleIdentifier];
    
    if ([locale.localeIdentifier isEqualToString:@"ja"]) {
        return @"ja-jp";
    }
    return @"zh-zn";
}

//- (void)saveLanguageUserSetting:(LanguageEnum)language
//{
//    [userDefault setObject:@(language) forKey:lDefaults_language];
//    [userDefault synchronize];
//}

#pragma mark - Launchr 需求
- (NSString *)companyName {
    return [userDefault objectForKey:[NSString getSelector:_cmd]] ? :@"";
}

- (NSString *)companyCode {
    return [userDefault objectForKey:[NSString getSelector:_cmd]] ? :@"";
}

- (NSString *)companyShowID {
    return [userDefault objectForKey:[NSString getSelector:_cmd]] ? :@"";
}

- (NSString *)loginName {
    return [userDefault objectForKey:[NSString getSelector:_cmd]] ? :@"";
}

- (NSString *)userName {
    return [userDefault objectForKey:[NSString getSelector:_cmd]] ? :@"";
}

- (NSString *)authToken {
    return [userDefault objectForKey:[NSString getSelector:_cmd]] ? :@"";
}

- (NSString *)userShowID {
    return [userDefault objectForKey:[NSString getSelector:_cmd]] ? :@"";
}

- (void)setCompanyName:(NSString *)companyName {
    [userDefault setObject:companyName forKey:[NSString setSelector:_cmd]];
    [userDefault synchronize];
}

- (void)setCompanyCode:(NSString *)companyCode {
    [userDefault setObject:companyCode forKey:[NSString setSelector:_cmd]];
    [userDefault synchronize];
}

- (void)setCompanyShowID:(NSString *)companyShowID {
    [userDefault setObject:companyShowID forKey:[NSString setSelector:_cmd]];
    [userDefault synchronize];
}

- (void)setLoginName:(NSString *)loginName {
    [userDefault setObject:loginName forKey:[NSString setSelector:_cmd]];
    [userDefault synchronize];
}

- (void)setUserName:(NSString *)userName {
    [userDefault setObject:userName forKey:[NSString setSelector:_cmd]];
    [userDefault synchronize];
}

- (void)setAuthToken:(NSString *)authToken {
    [userDefault setObject:authToken forKey:[NSString setSelector:_cmd]];
    [userDefault synchronize];
}

- (void)setUserShowID:(NSString *)userShowID {
    [userDefault setObject:userShowID forKey:[NSString setSelector:_cmd]];
    [userDefault synchronize];
}

#pragma mark - 输入习惯
- (InputHabitMode)inputHabit {
    InputHabitMode inputHabit = (InputHabitMode)[userDefault integerForKey:[NSString getSelector:_cmd]];
    if (inputHabit != kInputHabitNone) {
        return inputHabit;
    }
    
    NSString *language = [self getLanguageIdentifier];
    if ([language isEqualToString:@"ja-jp"]) {
        return kInputHabitLineBreak;
    }
    
    return kInputHabitSend;
}

- (void)setInputHabit:(InputHabitMode)inputHabit {
    [userDefault setInteger:inputHabit forKey:[NSString setSelector:_cmd]];
    [userDefault synchronize];
}

- (NSInteger)getPlaySystemKindType
{
    NSString * string = [userDefault objectForKey:[NSString stringWithFormat:@"PlaySystemKindType_%@",[self userShowID]]] ? :@"3";
    return [string integerValue];
}
- (void)setPlaySystemKindType:(NSInteger)type
{
    NSString * string = [NSString stringWithFormat:@"%ld",(long)type];
    [userDefault setObject:string forKey:[NSString stringWithFormat:@"PlaySystemKindType_%@",[self userShowID]]];
    [userDefault synchronize];
}

@end
