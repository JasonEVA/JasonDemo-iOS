//
//  UIBarButtonItem+BackExtension.m
//  HMViewMgrDemo
//
//  Created by yinqaun on 16/3/30.
//  Copyright © 2016年 YinQ. All rights reserved.
//

#import "UIBarButtonItem+BackExtension.h"

@implementation UIBarButtonItem (BackExtension)

+ (UIBarButtonItem *)itemWithImageNamed:(NSString *)imageNamed targe:(id)targe action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    
    [button addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
