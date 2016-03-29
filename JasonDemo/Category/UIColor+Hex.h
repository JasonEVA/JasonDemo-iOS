//
//  UIColor+Hex.h
//  launcher
//
//  Created by William Zhang on 15/7/24.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)


+ (UIColor *)colorWithR:(NSInteger)r g:(NSInteger)g b:(NSInteger)b;
+ (UIColor *)colorWithR:(NSInteger)r g:(NSInteger)g b:(NSInteger)b alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHex:(NSInteger)hexValue;
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

+ (UIColor *)colorWithW:(NSInteger)w;
+ (UIColor *)colorWithW:(NSInteger)w alpha:(CGFloat)alpha;


#pragma mark - Color Standerd
/**
 *  遮罩颜色
 *
 *
 */
+ (UIColor *)colorMaskBlack;

/**
 *  图片默认背景颜色
 *
 *
 */
+ (UIColor *)themeImageBackgroundColor;
/**LineColor**/
+ (UIColor *)lightGaryline_ebe9e6;

/**ThemeColor**/
+ (UIColor *)themeOrange_ff5d2b;

/// 乳白色
+ (UIColor *)themeBackground_f3f0eb;

/// 导航栏白色
+ (UIColor *)themeWhite_ffffff;

/**
 *  大部分主标题文字，以及navi页面标题
 */
+ (UIColor *)colorLightBlack_2e2e2e;

/**
 *  页面正文文字颜色
 */
+ (UIColor *)colorGray_525252;

/*********我的训练文字颜色**********/
/**
 *  我的训练，页面强调的数据文字
 */
+ (UIColor *)colorMyDarkGray_5a5a5a;

/**
 *  我的训练标题
 */
+ (UIColor *)colorMyLightGray_959595;

@end
