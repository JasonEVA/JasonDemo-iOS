//
//  BottomLineButton.m
//
//
//  Created by jasonwang on 16/7/27.
//  Copyright © 2016年 JasonWang. All rights reserved.
//

#import "BottomLineButton.h"
#import <Masonry/Masonry.h>

@interface BottomLineButton()
@end

@implementation BottomLineButton

- (instancetype)init {
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _bottomLine = [UIView new];
        [self addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@2);
        }];
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
