//
//  NSDate+String.m
//  launcher
//
//  Created by William Zhang on 15/8/13.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import "NSDate+String.h"
#import <DateTools/DateTools.h>
#import "UnifiedUserInfoManager.h"
//#import "MyDefine.h"

static NSDateFormatter *dateFormatter = nil;

@implementation NSDate (String)

- (NSString *)startToEndDate:(NSDate *)endDate {
    return [self startToEndDate:endDate wholeDay:NO];
}

- (NSString *)startToEndDate:(NSDate *)endDate wholeDay:(BOOL)isWholeDay {
    NSString *string = @"";
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    dateFormatter.locale = [[UnifiedUserInfoManager share] getLocaleIdentifier];
    
    NSString *startString, *endString;
    
    if (isWholeDay) {
        // 全天模式
        dateFormatter.dateFormat = @"MM/dd(EEEEE)";
        startString = [dateFormatter stringFromDate:self];
        endString   = [dateFormatter stringFromDate:endDate];
        if (self.year == endDate.year && self.month == endDate.month && self.day == endDate.day) {
            return startString;
        }
    }
    else {
        // 不是全天模式
        dateFormatter.dateFormat = @"MM/dd(EEEEE) HH:mm";
        startString = [dateFormatter stringFromDate:self];
        
        // 判断是不是start end是同一天,则改变
        if (self.day == endDate.day && self.year == endDate.year && self.month == endDate.month) {
            dateFormatter.dateFormat = @"HH:mm";
        }
        else if (self.year != endDate.year)
        {
            dateFormatter.dateFormat = @"yyyy/MM/dd(EEEEE) HH:mm";
            NSDate *today = [NSDate date];
            if (today.year != self.year)
            {
                startString = [dateFormatter stringFromDate:self];
            }
        }
        
        endString = [dateFormatter stringFromDate:endDate];
    }
    
    string = [NSString stringWithFormat:@"%@～%@", startString, endString];
    return string;
}

- (NSDate *)dateByCalculatorMinuteIntervalDidChange:(NSNumber *__autoreleasing *)didChange {
    return [self dateByCalculatorMinuteInterval:5 didChange:didChange];
}

- (NSDate *)dateByCalculatorMinuteInterval:(NSInteger)interval didChange:(NSNumber *__autoreleasing *)didChange{
    if (didChange) {
        *didChange = @NO;
    }
    
    NSInteger miniteInterval = self.minute % interval;
    if (!miniteInterval) {
        return self;
    }
    
    if (didChange) {
        *didChange = @YES;
    }
    
    NSInteger needAddMinite = interval - miniteInterval;
    NSDate *dateModified = [self dateByAddingMinutes:needAddMinite != interval ? needAddMinite : 0];
    
    return dateModified;
}

+ (NSDate *)dateByCalculatorMinuteIntervalDidChange:(NSNumber *__autoreleasing *)didChange {
    return [self dateByCalculatorMinuteInterval:5 didChange:didChange];
}

+ (NSDate *)dateByCalculatorMinuteInterval:(NSInteger)interval didChange:(NSNumber *__autoreleasing *)didChange {
    return [[NSDate date] dateByCalculatorMinuteInterval:interval didChange:didChange];
}

- (NSString *)dateFormate {
    return [self dateFormateWithWeekDay:NO];
}
- (NSString *)dateFormateWithWeekDay:(BOOL)showWeekDay {
    NSString *dateString = @"";
    
    NSDate *currentDate = [NSDate date];
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    dateFormatter.locale = [[UnifiedUserInfoManager share] getLocaleIdentifier];
    dateFormatter.dateFormat = @"(EEE)";
    NSString *weakDayString = [dateFormatter stringFromDate:self];
    if (!showWeekDay) {
        weakDayString = @"";
    }
    
    if (self.year == currentDate.year &&
        self.month == currentDate.month &&
        self.day == currentDate.day) {
        //dateString = [NSString stringWithFormat:@"%@%@ %02ld:%02ld",LOCAL(CALENDAR_SCHEDULEBYWEEK_TODAY), weakDayString,(long)self.hour, self.minute];
    } else {
        dateString = [NSString stringWithFormat:@"%ld/%ld%@ %02ld:%02ld",(long)self.month, self.day, weakDayString, self.hour, self.minute];
        if (self.year != currentDate.year) {
            dateString = [NSString stringWithFormat:@"%ld %@",(long)self.year, dateString];
        }
    }
    
    return dateString;
}

- (NSString *)getStringWithDateWholeDay:(BOOL)isWholeDay {
    return [self getStringWithDateWholeDay:isWholeDay showWeekDay:NO];
}

- (NSString *)getStringWithDateWholeDay:(BOOL)isWholeDay showWeekDay:(BOOL)showWeekDay {
    NSDate *today = [NSDate date];
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    dateFormatter.locale = [[UnifiedUserInfoManager share] getLocaleIdentifier];
    
    NSString *startString;
    NSString *dateFormat = @"";
    
    if (self.year != today.year) {
        dateFormat = [dateFormat stringByAppendingString:@"yyyy/MM/dd"];
    } else {
        dateFormat = [dateFormat stringByAppendingString:@"MM/dd"];
    }
    
    if (showWeekDay) {
        dateFormat = [dateFormat stringByAppendingString:@"(EEE)"];
    }
    
    if (!isWholeDay) {
        dateFormat = [dateFormat stringByAppendingString:@" HH:mm"];
    }
    
    dateFormatter.dateFormat = dateFormat;
    startString = [dateFormatter stringFromDate:self];
    return startString;
}

@end
