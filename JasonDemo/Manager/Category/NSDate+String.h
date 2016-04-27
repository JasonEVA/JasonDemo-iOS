//
//  NSDate+String.h
//  launcher
//
//  Created by William Zhang on 15/8/13.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (String)

/**
 *  生成时间格式（所有时间）
 *
 *  @param endDate 截至时间
 *
 *  @return string  8/10（月）13:00～8/11（月）15:00
 */
- (NSString *)startToEndDate:(NSDate *)endDate;

/**
 *  生成时间格式（全天模式）
 *
 *  @param endDate    截至时间
 *  @param isWholeDay 是否是全天
 *
 *  @return string 8/10（月）～8/11（月）
 */
- (NSString *)startToEndDate:(NSDate *)endDate wholeDay:(BOOL)isWholeDay;

/**
 *  根据时间间隔计算比当前大的时间（时间间隔默认5）
 *
 *  @param didChange 是否有改变
 *
 *  @return NSDate (8:12 return 8:15)
 */
- (NSDate *)dateByCalculatorMinuteIntervalDidChange:(NSNumber **)didChange;

/**
 *  根据时间间隔计算比当前大的时间
 *
 *  @param interval  时间间隔
 *  @param didChange 是否有改变
 *
 *  @return NSDate （8:12 return 8:15 间隔为5）
 */
- (NSDate *)dateByCalculatorMinuteInterval:(NSInteger)interval didChange:(NSNumber **)didChange;

+ (NSDate *)dateByCalculatorMinuteIntervalDidChange:(NSNumber **)didChange;
+ (NSDate *)dateByCalculatorMinuteInterval:(NSInteger)interval didChange:(NSNumber **)didChange;

/**
 *  时间格式
 *
 *  @return 今日 12:30 。。 8/26 12:30
 */
- (NSString *)dateFormate;

/**
 *  时间格式
 *
 *  @param showWeekDay 是否显示星期几
 *
 *  @return 今日(一) 12:30 。。 8/26(二) 12:30
 */
- (NSString *)dateFormateWithWeekDay:(BOOL)showWeekDay;
/**
 *  时间格式
 *
 *  @param isWholeDay
 *
 *  @return 8/11
 */
- (NSString *)getStringWithDateWholeDay:(BOOL)isWholeDay;
- (NSString *)getStringWithDateWholeDay:(BOOL)isWholeDay showWeekDay:(BOOL)showWeekDay;
@end
