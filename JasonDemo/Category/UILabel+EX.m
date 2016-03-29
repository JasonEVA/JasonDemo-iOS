//
//  UILabel+EX.m
//  Shape
//
//  Created by jasonwang on 15/10/21.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import "UILabel+EX.h"

@implementation UILabel (EX)
+ (UILabel *)setLabel:(UILabel *)label text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color {
    label = [[UILabel alloc] init];
    [label setTextColor:color];
    [label setText:text];
    [label setFont:font];
    [label setTextAlignment:NSTextAlignmentLeft];
    return label;
}

@end
