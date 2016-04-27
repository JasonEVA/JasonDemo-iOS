//
//  UIImage+Manager.h
//  launcher
//
//  Created by William Zhang on 15/7/24.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Manager)


/** 获取纯背景色背景（CGSizeMake(1, 1)） */
+ (UIImage *)imageColor:(UIColor *)color;
/** 获取纯背景色背景（CGSizeMake(1, 1)） */
+ (UIImage *)imageColor:(UIColor *)color cornerRadius:(CGFloat)radius;
/**
 *  获取纯背景色背景
 *
 *  @param color 背景色
 *  @param size  背景大小(传入CGSizeZero返回（1，1）)
 *
 *  @return 纯色背景
 */
+ (UIImage *)imageColor:(UIColor *)color size:(CGSize)size;
/**
 *  获取纯颜色背景
 *
 *  @param color  背景色
 *  @param size   背景大小（传入CGSizeZero返回（1，1））
 *  @param radius 边缘角度
 *
 *  @return 纯色背景
 */
+ (UIImage *)imageColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius;

/** 压缩图片 */
+ (UIImage *)compressImage:(UIImage *)image ScaledToSize:(CGSize)newSize;

/** 按图片中心点等比例裁剪 */
- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
