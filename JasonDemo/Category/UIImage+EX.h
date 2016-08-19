//
//  UIImage+EX.h
//  Shape
//
//  Created by jasonwang on 15/10/26.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EX)


+ (UIImage *)imageScaleFromImage:(UIImage *)image toSize:(CGSize)size;

/**
 * 创建纯色的图片，用来做背景
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 * 屏幕截图
 */
+ (UIImage *)imageScreenshotFromView:(UIView *)view;

/**
 *  想图片添加水印
 *
 *  @param sourceImage 需要加水印的图片
 *  @param maskImage   水印图片
 *
 *  @return 添加好的图片
 */
+ (UIImage *)imageAddWatermarkToImage:(UIImage *)sourceImage maskImage:(UIImage *)maskImage;
/** 设置圆形图片(放到分类中使用) */

- (UIImage *)cutCircleImage;
@end
