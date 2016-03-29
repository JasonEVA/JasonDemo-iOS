//
//  UITextField+EX.m
//  Shape
//
//  Created by jasonwang on 15/10/27.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import "UITextField+EX.h"

@implementation UITextField (EX)
+ (UITextField *)setTxfData:(UITextField *)textField placeholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor textColor:(UIColor *)textColor delegate:(id)delegate keyboard:(UIKeyboardType)keyboard{
    textField = [[UITextField alloc]init];
    [textField setPlaceholder:placeholder];
    [textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [textField setTextColor:textColor];
    [textField setDelegate:delegate];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textField setKeyboardType:keyboard];
    return textField;
}
@end
