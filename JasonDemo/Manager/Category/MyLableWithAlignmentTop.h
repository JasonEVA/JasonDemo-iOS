//
//  MyLableWithAlignmentTop.h
//  launcher
//
//  Created by jasonwang on 15/12/23.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  实现上对齐 下对齐 中对齐的自定义 UILabel

#import <UIKit/UIKit.h>
#import "MyLableWithAlignmentTop.h"

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface MyLableWithAlignmentTop : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
