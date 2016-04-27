//
//  NSString+Unified.h
//  launcher
//
//  Created by William Zhang on 15/8/20.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//  UnifiedUserInfoManager 使用

#import <Foundation/Foundation.h>

@interface NSString (Unified)

+ (NSString *)getSelector:(SEL)selector;
+ (NSString *)setSelector:(SEL)selector;

/**
 * 首字母变大写
 */
- (NSString *)firstLetterUpper;
/**
 * 首字母变小写
 */
- (NSString *)firstLetterLower;

@end
