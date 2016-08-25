//
//  UIImage+EX.m
//  Shape
//
//  Created by jasonwang on 15/10/26.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import "UIImage+EX.h"

@implementation UIImage (EX)

+ (UIImage *)imageScaleFromImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 * 创建纯色的图片，用来做背景
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *ColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ColorImg;

}

// 屏幕截图
+ (UIImage *)imageScreenshotFromView:(UIView *)view {
    UILabel *lb = [[UILabel alloc] init];
    // Draw a view’s contents into an image context
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[view layer] renderInContext:context];
    [lb.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

// 向图片添加logo水印
+ (UIImage *)imageAddWatermarkToImage:(UIImage *)sourceImage maskImage:(UIImage *)maskImage {
    UIGraphicsBeginImageContext(sourceImage.size);
    [sourceImage drawInRect:CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height)];
    
    [maskImage drawInRect:CGRectMake(0,0,maskImage.size.width,maskImage.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
    
}

/** 设置圆形图片(放到分类中使用) */
- (UIImage *)cutCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 500);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//设置默认字体图标
+ (UIImage *)imageWithDefaultIcon:(NSString *)iconCode size:(CGFloat)size color:(UIColor *)color {
    //@"IconFont"为字体名，可在demo.html中找到，如<title>IconFont</title>
    return [[self class] imageWithIcon:iconCode inFont:@"IconFont" size:size color:color];
}

//设置字体图标
+ (UIImage *)imageWithIcon:(NSString *)iconCode inFont:(NSString *)fontName size:(CGFloat)size color:(UIColor *)color {
    CGSize imageSize = CGSizeMake(size, size);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [[UIScreen mainScreen] scale]);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size + 150, size)];
    label.font = [UIFont fontWithName:fontName size:size];
    label.text = iconCode;
    if(color){
        label.textColor = color;
    }
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    return retImage;
}

@end
