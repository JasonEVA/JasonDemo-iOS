//
//  UILabel+EX.m
//  Shape
//
//  Created by jasonwang on 15/10/21.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import "UILabel+EX.h"
#import <objc/runtime.h>

static const void *JWNameKey = @"JWNameKeyss";

@implementation UILabel (EX)
+ (UILabel *)setLabel:(UILabel *)label text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color {
    label = [[UILabel alloc] init];
    [label setTextColor:color];
    [label setText:text];
    [label setFont:font];
    [label setTextAlignment:NSTextAlignmentLeft];
    return label;
}

- (NSString *)JWName {
    return objc_getAssociatedObject(self, JWNameKey);
}

- (void)setJWName:(NSString *)JWName {
    objc_setAssociatedObject(self, JWNameKey, JWName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
