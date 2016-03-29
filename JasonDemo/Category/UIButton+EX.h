//
//  UIButton+EX.h
//  Shape
//
//  Created by jasonwang on 15/10/27.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EX)
+ (UIButton *)setBntData:(UIButton *)button backColor:(UIColor *)backColor backImage:(UIImage *)backImage title:(NSString *)title titleColorNormal:(UIColor *)titleColorNormal titleColorSelect:(UIColor *)titleColorSelect font:(UIFont *)font tag:(NSInteger)tag isSelect:(BOOL)isSelect;

@end
