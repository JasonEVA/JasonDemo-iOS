//
//  UIColor+HexExtension.m
//  HakimHospitalRegister
//
//  Created by YinQ on 15/1/12.
//  Copyright (c) 2015年 YinQuan. All rights reserved.
//

#import "UIColor+HexExtension.h"

@implementation UIColor (HexExtension)

+ (id) colorWithHexString:(NSString*) hexColor
{
    return  [self colorWithHexString:hexColor alpha:1.0f];
}

+ (id)colorWithHexString:(NSString*)hexColor alpha:(CGFloat)alpha {
    
    unsigned int red,green,blue;
    NSRange range;
    
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    UIColor* retColor = [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:alpha];
    return retColor;
}
@end
