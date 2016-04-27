//
//  NSDictionary+SafeManager.m
//  launcher
//
//  Created by William Zhang on 15/7/27.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import "NSDictionary+SafeManager.h"

@implementation NSDictionary (SafeManager)

- (NSString *)valueStringForKey:(NSString *)key {return [self valueStringForKeyPath:key];}
- (NSString *)valueStringForKeyPath:(NSString *)keyPath {
    return [self safeValueForKeyPath:keyPath originalClass:[NSString class]];
}

- (NSNumber *)valueNumberForKey:(NSString *)key {return [self valueNumberForKeyPath:key];}
- (NSNumber *)valueNumberForKeyPath:(NSString *)keyPath {
    return [self safeValueForKeyPath:keyPath originalClass:[NSNumber class]];
}

- (BOOL)valueBoolForKey:(NSString *)key { return [self valueBoolForKeyPath:key];}
- (BOOL)valueBoolForKeyPath:(NSString *)keyPath {
    return [[self valueNumberForKeyPath:keyPath] boolValue];
};

- (NSArray *)valueArrayForKey:(NSString *)key {return [self valueArrayForKeyPath:key];}
- (NSArray *)valueArrayForKeyPath:(NSString *)keyPath {
    return [self safeValueForKeyPath:keyPath originalClass:[NSArray class]];
}

- (NSMutableArray *)valueMutableArrayForKey:(NSString *)key {return  [self valueMutableArrayForKeyPath:key];}
- (NSMutableArray *)valueMutableArrayForKeyPath:(NSString *)keyPath {
    return [self safeValueForKeyPath:keyPath originalClass:[NSMutableArray class]];
}

- (NSDictionary *)valueDictonaryForKey:(NSString *)key {return [self valueDictonaryForKeyPath:key];}
- (NSDictionary *)valueDictonaryForKeyPath:(NSString *)keyPath {
    return [self safeValueForKeyPath:keyPath originalClass:[NSDictionary class]];
}

- (NSMutableDictionary *)valueMutableDictionayForKey:(NSString *)key {return [self valueMutableDictionayForKeyPath:key];}
- (NSMutableDictionary *)valueMutableDictionayForKeyPath:(NSString *)keyPath {
    return [self safeValueForKeyPath:keyPath originalClass:[NSMutableDictionary class]];
}

- (NSDate *)valueDateForKey:(NSString *)key {return [self valueDateForKeyPath:key];}
- (NSDate *)valueDateForKeyPath:(NSString *)keyPath {
    NSNumber *timeIntervalNumber = [self valueNumberForKeyPath:keyPath];
    long long timeInterval = [timeIntervalNumber longLongValue] / 1000;
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

/** /////////////////// 之后仅在.m中使用，不开放 ///////////////////////// */

- (id)safeValueForKey:(NSString *)key {
    return [self safeValueForKey:key originalClass:nil];
}

- (id)safeValueForKey:(NSString *)key originalClass:(Class)aClass {
    return [self safeValueForKeyPath:key originalClass:aClass];
}

- (id)safeValueForKeyPath:(NSString *)keyPath {
    return [self safeValueForKeyPath:keyPath originalClass:nil];
}

- (id)safeValueForKeyPath:(NSString *)keyPath originalClass:(Class)aClass {
    id value = [self valueForKeyPath:keyPath];
    if ([value isKindOfClass:[NSNull class]]) {
        value = nil;
    }
    
    if (value) {
        return value;
    }
    
    if (aClass == [NSString class]) {
        return @"";
    }
    
    if (aClass == [NSNumber class]) {
        return @0;
    }
    
    NSArray *array = @[@"NSArray",
                       @"NSMutaleArray",
                       @"NSDictionary",
                       @"NSMutableDictionary",
                       @"NSDate"];
    
    for (NSString *className in array) {
        Class bClass = NSClassFromString(className);
        if (aClass != bClass) {
            continue;
        }

        value = [[bClass alloc] init];
        break;
    }
    
    return value;
}

/** /////////////////// 之后仅在.m中使用，不开放 ///////////////////////// */

@end
