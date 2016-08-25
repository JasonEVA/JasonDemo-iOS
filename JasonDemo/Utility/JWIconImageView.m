//
//  JWIconImageView.m
//  JasonDemo
//
//  Created by jasonwang on 16/8/25.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "JWIconImageView.h"

@implementation JWIconImageView

- (instancetype)initWithIconName:(NSString *)iconName iconColor:(UIColor *)iconColor iconSize:(CGFloat)iconSize {
    if (self = [super init]) {
        //@"IconFont"为字体名，可在demo.html中找到，如<title>IconFont</title>
        [self setFont:[UIFont fontWithName:@"IconFont" size:iconSize]];
        [self setText:iconName];
        [self setTextColor:iconColor];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
