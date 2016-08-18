//
//  UILabel+EX.h
//  Shape
//
//  Created by jasonwang on 15/10/21.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"
#import "UIFont+EX.h"
@interface UILabel (EX)

+ (UILabel *)setLabel:(UILabel *)label text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color;
@property (nonatomic, copy) NSString *JWName;
@end
