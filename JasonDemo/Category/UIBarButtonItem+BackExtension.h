//
//  UIBarButtonItem+BackExtension.h
//  HMViewMgrDemo
//
//  Created by yinqaun on 16/3/30.
//  Copyright © 2016年 YinQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BackExtension)

+ (UIBarButtonItem *)itemWithImageNamed:(NSString *)imageNamed targe:(id)targe action:(SEL)action;

@end
