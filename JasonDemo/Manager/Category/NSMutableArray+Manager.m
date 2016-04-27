//
//  NSMutableArray+Manager.m
//  launcher
//
//  Created by William Zhang on 15/8/17.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import "NSMutableArray+Manager.h"

@implementation NSMutableArray (Manager)

// 数组中的自定义对象按照某个属性排序(YES升序，NO降序)
- (void)sortDescriptorWithKey:(NSString *)key Ascending:(BOOL)mark
{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:mark];
    [self sortUsingDescriptors:[NSArray arrayWithObject:sort]];
}

@end
