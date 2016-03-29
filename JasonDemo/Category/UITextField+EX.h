//
//  UITextField+EX.h
//  Shape
//
//  Created by jasonwang on 15/10/27.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (EX)
+ (UITextField *)setTxfData:(UITextField *)textField placeholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor textColor:(UIColor *)textColor delegate:(id)delegate keyboard:(UIKeyboardType)keyboard;
@end
