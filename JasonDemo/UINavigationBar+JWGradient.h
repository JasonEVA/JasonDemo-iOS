//
//  UINavigationBar+JWGradient.h
//  HMClient
//
//  Created by jasonwang on 2017/4/5.
//  Copyright © 2017年 YinQ. All rights reserved.
//  控制UINavigationBar 颜色渐变

#import <UIKit/UIKit.h>

@interface UINavigationBar (JWGradient)
- (void)jw_setBackgroundColor:(UIColor *)backgroundColor;
- (void)jw_setElementsAlpha:(CGFloat)alpha;
- (void)jw_setTranslationY:(CGFloat)translationY;
- (void)jw_reset;
// 设置渐变色
- (void)jw_setBackgroundViewLayerWithAlpha:(CGFloat)alpha;
- (void)jw_removeOverSubLayer;
@end
