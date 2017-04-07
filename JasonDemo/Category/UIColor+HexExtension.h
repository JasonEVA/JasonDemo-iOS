//
//  UIColor+HexExtension.h
//  HakimHospitalRegister
//
//  Created by YinQ on 15/1/12.
//  Copyright (c) 2015年 YinQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexExtension)

+ (id) colorWithHexString:(NSString*) hexColor;
+ (id)colorWithHexString:(NSString*)hexColor alpha:(CGFloat)alpha;
@end
