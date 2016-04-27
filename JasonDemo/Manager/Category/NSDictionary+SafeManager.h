//
//  NSDictionary+SafeManager.h
//  launcher
//
//  Created by William Zhang on 15/7/27.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//  字典处理方法

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeManager)

- (NSString *)valueStringForKey:(NSString *)key;

- (NSNumber *)valueNumberForKey:(NSString *)key;
- (BOOL)valueBoolForKey:(NSString *)key;

- (NSArray *)valueArrayForKey:(NSString *)key;
- (NSMutableArray *)valueMutableArrayForKey:(NSString *)key;

- (NSDictionary *)valueDictonaryForKey:(NSString *)key;
- (NSMutableDictionary *)valueMutableDictionayForKey:(NSString *)key;

/** 服务器定义时间戳 / 1000 转换为时间 */
- (NSDate *)valueDateForKey:(NSString *)key;

- (NSString *)valueStringForKeyPath:(NSString *)keyPath;

- (NSNumber *)valueNumberForKeyPath:(NSString *)keyPath;
- (BOOL)valueBoolForKeyPath:(NSString *)keyPath;

- (NSArray *)valueArrayForKeyPath:(NSString *)keyPath;
- (NSMutableArray *)valueMutableArrayForKeyPath:(NSString *)keyPath;

- (NSDictionary *)valueDictonaryForKeyPath:(NSString *)keyPath;
- (NSMutableDictionary *)valueMutableDictionayForKeyPath:(NSString *)keyPath;

/** 服务器定义时间戳 / 1000 转换为时间 */
- (NSDate *)valueDateForKeyPath:(NSString *)keyPath;

@end
