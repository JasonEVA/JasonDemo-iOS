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

/**
 *  通过设置自定义字体来实现图标显示
 *  参考教程：http://www.iconfont.cn/help/iconuse.html
 *
 *  @param iconCode 图标对应文本值（Unicode 字符）
 
 这里有两个地方注意下：
 创建 UIFont 使用的是字体名，而不是文件名；
 文本值为 8 位的 Unicode 字符，我们可以打开 demo.html 查找每个图标所对应的 HTML 实体 Unicode 码，比如：
 
 "店" 对应的 HTML 实体 Unicode 码为：
 
 0x3439
 
 转换后Unicode 字符为
 
 \U00003439
 
 就是将 0x 替换为 \U 中间用 0 填补满长度为 8 个字符
 
 *  @param fontName 字体名（可在demo.html中找到，如<title>IconFont</title>）
 *  @param size     图标大小
 *  @param color    图标颜色
 *
 *  @return UIImage
 */
+ (UIImage*)imageWithIcon:(NSString*)iconCode inFont:(NSString*)fontName size:(CGFloat)size color:(UIColor*)color;


/**
 *  默认主题字体设置图标
 *
 *  @param iconCode 图标对应文本值（Unicode 字符）
 *  @param size     图标大小
 *  @param color    图标颜色
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithDefaultIcon:(NSString *)iconCode size:(CGFloat)size color:(UIColor *)color;

@end
