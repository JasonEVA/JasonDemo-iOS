//
//  NSString+Manager.h
//  BeautyView
//
//  Created by Remon Lv on 14-5-20.
//  Copyright (c) 2014年 Remon Lv. All rights reserved.
//  NSString的自定义扩展方法

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Manager)

/**
 * 根据 ‘\n’ 符号剥离字符串
 */
+ (NSArray *)peelStringWithLineBreak:(NSString *)string;

// 文件位数转换成合理的单位(B/K/M/G)
+ (NSString *)changeFileUnitFrom:(double)value;

// 生成当前时间戳的字符串
+ (NSString *)convertCurrentDateTimeToString;

// SQLite插入特殊字符转义
+ (NSString *)convertSpecialCharInString:(NSString *)oldString;

/**
 * URL 编码，把 NSString 中的特殊字符转义掉
 */
+ (NSString *)encodeURLWithStringEncodingUTF8:(NSString *)stringToEncode;

/**
 *  去处字符串中的空格
 *
 *  @param oldString    待处理字符串
 *  @param onlyMarginal YES：只去除字符串首尾的空格，NO:去除所有的空格
 *
 *  @return 新字符串
 */
+ (NSString *)removeBlankInString:(NSString *)oldString OnlyMarginal:(BOOL)onlyMarginal;

/**
 *  检查长度不为0且不全是空白
 *
 *  @param string 检测字符串
 *
 *  @return YES代表有意义
 */
+ (BOOL)checkValuableWithString:(NSString *)string;

/**
 *  判断是否是Http网络路径
 *
 *  @param string 输入路径
 *
 *  @return 是Http网络路径就返回YES
 */
- (BOOL)checkHttpUrlWithString;

/**
 *  计算NSString所需要得Frame
    单行文本返回所需宽度
    多行文本返回所需
 *
 *  @param size     约定Size
 *  @param font     Fone
 *  @param multiRow 是否是多行
 *
 *  @return Rect
 */
- (CGSize)getBoundingRectWithSize:(CGSize)size Font:(UIFont *)font IsForMultiRow:(BOOL)multiRow;

/**
 *  是否包含一个字符串
 *
 *  @param aString 关键字（连续的）
 *
 *  @return 结果
 */
- (BOOL)isContainsString:(NSString *)aString;
/**
 *  拼接文件路径
 *
 *  @param string 文件相对路径
 *
 *  @return 完整路径
 */
+ (NSURL *)fullURLWithFileString:(NSString *)fileString;

@end
