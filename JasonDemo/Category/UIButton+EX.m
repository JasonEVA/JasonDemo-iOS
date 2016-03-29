//
//  UIButton+EX.m
//  Shape
//
//  Created by jasonwang on 15/10/27.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import "UIButton+EX.h"

@implementation UIButton (EX)

+ (UIButton *)setBntData:(UIButton *)button backColor:(UIColor *)backColor backImage:(UIImage *)backImage title:(NSString *)title titleColorNormal:(UIColor *)titleColorNormal titleColorSelect:(UIColor *)titleColorSelect font:(UIFont *)font tag:(NSInteger)tag isSelect:(BOOL)isSelect
{
    button = [[UIButton alloc]init];
    [button setBackgroundColor:backColor];
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColorNormal forState:UIControlStateNormal];
    [button setTitleColor:titleColorSelect forState:UIControlStateSelected];
    button.titleLabel.font = font;
    [button setTag:tag];
    
    [button setSelected:isSelect];
    
    return button;
}
@end
