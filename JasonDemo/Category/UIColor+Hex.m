//
//  UIColor+Hex.m
//  launcher
//
//  Created by William Zhang on 15/7/24.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)


+ (UIColor *)colorWithR:(NSInteger)r g:(NSInteger)g b:(NSInteger)b {
    return [UIColor colorWithR:r g:g b:b alpha:1.0];
}

+ (UIColor *)colorWithR:(NSInteger)r g:(NSInteger)g b:(NSInteger)b alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:r / 255.0
                           green:g / 255.0
                            blue:b / 255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}
+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alphaValue];
}

+ (UIColor *)colorWithW:(NSInteger)w {
    return [UIColor colorWithW:w alpha:1.0];
}

+ (UIColor *)colorWithW:(NSInteger)w alpha:(CGFloat)alpha {
    return [UIColor colorWithWhite:w / 255.0 alpha:alpha];
}

/**
 *  遮罩颜色
 *
 *
 */
+ (UIColor *)colorMaskBlack {
    return [[UIColor blackColor] colorWithAlphaComponent:0.4];
}

/**LineColor**/
+ (UIColor *)lightGaryline_ebe9e6 {
    return [self colorWithHex:0xebe9e6];
}

/**ThemeColor**/
+ (UIColor *)themeOrange_ff5d2b {
    return [self colorWithHex:0xff5d2b];
}
+ (UIColor *)themeBackground_f3f0eb {
    return [self colorWithHex:0xf3f0eb];
}
+ (UIColor *)themeWhite_ffffff {
    return [self colorWithHex:0xffffff];
}

+ (UIColor *)themeImageBackgroundColor {
    return [self colorWithHex:0xcccccc];
}

/**
 *  大部分主标题文字，以及navi页面标题
 */
+ (UIColor *)colorLightBlack_2e2e2e {
    return [self colorWithHex:0x2e2e2e];
}

/**
 *  页面正文文字颜色
 */
+ (UIColor *)colorGray_525252 {
    return [self colorWithHex:0x525252];
}

/*********我的训练文字颜色**********/
/**
 *  我的训练，页面强调的数据文字
 */
+ (UIColor *)colorMyDarkGray_5a5a5a {
    return [self colorWithHex:0x5a5a5a];
}


/**
 *  我的训练标题
 */
+ (UIColor *)colorMyLightGray_959595 {
    return [self colorWithHex:0x959595];
}


@end
