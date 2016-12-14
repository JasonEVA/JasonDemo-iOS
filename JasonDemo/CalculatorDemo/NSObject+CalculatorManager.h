//
//  NSObject+CalculatorManager.h
//  JasonDemo
//
//  Created by jasonwang on 2016/12/14.
//  Copyright © 2016年 jasonwang. All rights reserved.
//  计算器管理器（链式编程思想）

#import <Foundation/Foundation.h>

@class CaculatorMaker;
@interface NSObject (CalculatorManager)
//计算

+ (float)makCalulator:(void(^)(CaculatorMaker *make)) caaulatorMaker;

@end
