//
//  NSDictionary+SafeManager.h
//  PalmDoctorDR
//
//  Created by Lars Chen on 15/4/15.
//  Copyright (c) 2015年 jasonwang. All rights reserved.
//  字典的处理,参考Peter的写法

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeManager)

- (id)safeValueForKey:(NSString *)key;

@end
