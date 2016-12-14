//
//  NSObject+CalculatorManager.m
//  JasonDemo
//
//  Created by jasonwang on 2016/12/14.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "NSObject+CalculatorManager.h"
#import "CaculatorMaker.h"
@implementation NSObject (CalculatorManager)

+ (float)makCalulator:(void (^)(CaculatorMaker *))caaulatorMaker {
    CaculatorMaker *mgr = [CaculatorMaker new];
    caaulatorMaker(mgr);
    return mgr.result;
}
@end
