//
//  NSDictionary+SafeManager.m
//  PalmDoctorDR
//
//  Created by Lars Chen on 15/4/15.
//  Copyright (c) 2015年 jasonwang. All rights reserved.
//

#import "NSDictionary+SafeManager.h"

@implementation NSDictionary (SafeManager)

- (id)safeValueForKey:(NSString *)key{
    id value = [self valueForKey:key];
    if([value isKindOfClass:[NSNull class]] || value == NULL){
        value = nil;
    }
    return value;
}

@end
