//
//  JWView.m
//  JasonDemo
//
//  Created by jasonwang on 16/7/19.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "JWView.h"
#import <objc/runtime.h>
@implementation JWView //继承自UIView
+ (void)load { //load方法是所有继承NSObject类都拥有的类方法，可以直接理解为这个方法加载的灰常早灰常的早！！
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(willMoveToSuperview:); //View被加到父View的时候的回调
        SEL swizzledSelector = @selector(JWwillMoveToSuperview:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)JWwillMoveToSuperview:(UIView *)newSuperView {
    [self JWwillMoveToSuperview:newSuperView];
    //在这里写想要替换的内容
    NSLog(@"换方法成功");
}
@end
