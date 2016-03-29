//
//  NSString+Manager.m
//  BeautyView
//
//  Created by Remon Lv on 14-5-20.
//  Copyright (c) 2014年 Remon Lv. All rights reserved.
//

#import "NSString+Manager.h"
//#import "MyDefine.h"

@implementation NSString (Manager)

// 根据 ‘\n’ 符号剥离字符串
+ (NSArray *)peelStringWithLineBreak:(NSString *)string
{
    NSMutableArray *arr_result = [NSMutableArray array];
    NSRange range = [string rangeOfString:@"\n"];
    // 没有分行符就直接返回数组
    if (range.length == 0)
    {
        [arr_result addObject:string];
        return arr_result;
    }
    // 至少有一个分行符就进入循环筛选
    while (1)
    {
        NSString *str_peel = [string substringToIndex:range.location];
        [arr_result addObject:str_peel];
        // 判断是否到达边界
        if (range.location + range.length >= string.length - 2)
        {
            return arr_result;
        }
        string = [string substringFromIndex:range.location + range.length];
        range = [string rangeOfString:@"\n"];
        // 最后一个分行符了
        if (range.length == 0)
        {
            [arr_result addObject:string];
            return arr_result;
        }
    }
}
// 转换成合理的单位
+ (NSString *)changeFileUnitFrom:(double)value
{
    NSString *unit = @"B";
    if (value > 1024)
    {
        value /= 1024;
        unit = @"K";
    }
    if (value > 1024)
    {
        value /= 1024;
        unit = @"M";
    }
    if (value > 1024)
    {
        value /= 1024;
        unit = @"G";
    }
    return [NSString stringWithFormat:@"%.1f%@",value,unit];
}

// 生成当前时间戳的字符串
+ (NSString *)convertCurrentDateTimeToString
{
    return [NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]];
}

// SQLite插入特殊字符转义
+ (NSString *)convertSpecialCharInString:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]] || string == nil)
    {
        return @"";
    }
    else
    {
        NSString *oldString = string;
        NSMutableString *newString = [NSMutableString string];
        
        NSString *str_tmp;
        
        NSRange range = [oldString rangeOfString:@"'"];
        while (range.location != NSNotFound)
        {
            str_tmp = [oldString substringToIndex:range.location];
            [newString appendString:str_tmp];
            [newString appendString:@"''"];
            oldString = [oldString substringFromIndex:range.location + 1];
            range = [oldString rangeOfString:@"'"];
        }
        [newString appendString:oldString];
        
        return newString;
    }
}

/*
 * URL 编码，把 NSString 中的特殊字符转义掉
 */
+ (NSString *)encodeURLWithStringEncodingUTF8:(NSString *)string
{
    NSString *newString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), kCFStringEncodingUTF8));
    if (newString) {
        return newString;
    }
    return @"";
}

+ (NSString *)removeBlankInString:(NSString *)oldString OnlyMarginal:(BOOL)onlyMarginal
{
    NSString *strNew = @"";
    if (oldString != nil)
    {
        if (onlyMarginal)
        {
            strNew = [oldString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        }
        else
        {
            strNew = [oldString stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
    }
    return strNew;
}

+ (BOOL)checkValuableWithString:(NSString *)string
{
    if (string != nil)
    {
        if (string.length > 0)
        {
            NSString *stringResult = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (stringResult.length > 0)
            {
                return YES;
            }
        }
    }
    return NO;
}

/**
 *  判断是否是Http网络路径
 *
 *  @param string 输入路径
 *
 *  @return 是Http网络路径就返回YES
 */
- (BOOL)checkHttpUrlWithString
{
    if (self != nil)
    {
        if ([self hasPrefix:@"http://"])
        {
            return YES;
        }
    }
    return NO;
}

/**
 *  计算NSString所需要得Frame
 *
 *  @param size     约定Size
 *  @param font     Fone
 *  @param multiRow 是否是多行
 *
 *  @return Rect
 */
- (CGSize)getBoundingRectWithSize:(CGSize)size Font:(UIFont *)font IsForMultiRow:(BOOL)multiRow
{
    CGSize sizeResult;
    
    if (!multiRow)      // 单行
    {
        sizeResult = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    }
    else                     // 多行
    {
        CGRect rectResult = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        sizeResult = rectResult.size;
    }
    
    return sizeResult;
}

/**
 *  是否包含一个字符串
 *
 *  @param aString 关键字（连续的）
 *
 *  @return 结果
 */
- (BOOL)isContainsString:(NSString *)aString
{
    if ([self respondsToSelector:@selector(containsString:)])
    {
        return [self containsString:aString];
    }
    else
    {
        NSRange rangeResult = [self rangeOfString:aString];
        return rangeResult.length > 0;
    }
}
/**
 *  拼接文件路径
 *
 *  @param string 文件相对路径
 *
 *  @return 完整路径
 */
+ (NSURL *)fullURLWithFileString:(NSString *)fileString
{
    NSString *fullString;
    if ([fileString hasPrefix:@"http"]) {
        fullString = fileString;
    } else {
        //fullString = [NSString stringWithFormat:@"%@%@",kURLAddress,fileString];
    }
    NSURL *url = [NSURL URLWithString:fullString];
    return url;
}
@end
