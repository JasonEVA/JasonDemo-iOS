//
//  NSMutableArray+Manager.h
//  launcher
//
//  Created by William Zhang on 15/8/17.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Manager)

// 数组中的自定义对象按照某个属性排序(YES升序，NO降序)
- (void)sortDescriptorWithKey:(NSString *)key Ascending:(BOOL)mark;

@end
