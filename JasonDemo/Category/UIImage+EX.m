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
@end
