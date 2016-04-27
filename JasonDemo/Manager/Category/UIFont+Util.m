//
//  UIFont+Util.m
//  launcher
//
//  Created by williamzhang on 15/11/24.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

#import "UIFont+Util.h"

@implementation UIFont (Util)

+ (UIFont *)font_30 { return [self fontWithSize:15];}
+ (UIFont *)font_28 { return [self fontWithSize:14];}
+ (UIFont *)font_26 { return [self fontWithSize:13];}
+ (UIFont *)font_24 { return [self fontWithSize:12];}
+ (UIFont *)font_22 { return [self fontWithSize:11];}
+ (UIFont *)font_20 { return [self fontWithSize:10];}
+ (UIFont *)fontWithSize:(CGFloat)size {
    return [UIFont systemFontOfSize:size];
}

@end
