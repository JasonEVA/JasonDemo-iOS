//
//  RowButtonGroup.m
//  Shape
//
//  Created by jasonwang on 15/10/21.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import "RowButtonGroup.h"
#import <Masonry/Masonry.h>

@interface RowButtonGroup()

@property (nonatomic, strong)  NSMutableArray  *arrayBtn; // <##>
@end
@implementation RowButtonGroup

- (instancetype)initWithTitles:(NSArray *)arrayTitles tags:(NSArray *)arrayTags normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor font:(UIFont *)font {
    self = [super init];
    if (self) {
        // btn 个数
        NSInteger btnCount = arrayTitles.count;
        self.arrayBtn = [NSMutableArray arrayWithCapacity:btnCount];
        UIButton *btnLast;
        for (NSInteger i = 0; i < btnCount; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:arrayTitles[i] forState:UIControlStateNormal];
            [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
            [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            NSNumber *tag = arrayTags[i];
            [btn setTag:tag.integerValue];
            [btn.titleLabel setFont:font];
            if (i == 0) {
                [btn setSelected:YES];
                self.selectedBtn = btn;
                
            }
            [self addSubview:btn];
            [self.arrayBtn addObject:btn];

            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.top.equalTo(self);
                make.width.equalTo(self).multipliedBy(1.0 / btnCount);
                if (btnLast) {
                    make.left.equalTo(btnLast.mas_right);
                } else {
                    make.left.equalTo(self);
                }
                
            }];
            btnLast = btn;
            
        }
    }
    return self;
}

- (void)setBtnSelectedWithTag:(NSInteger)tag {
    UIButton *currentBtn = self.arrayBtn[tag];
    if (self.selectedBtn.tag != currentBtn.tag) {
        [self.selectedBtn setSelected:NO];
        [currentBtn setSelected:YES];
        self.selectedBtn = currentBtn;
        
        if ([self.delegate respondsToSelector:@selector(RowButtonGroupDelegateCallBack_btnClickedWithTag:)]) {
            [self.delegate RowButtonGroupDelegateCallBack_btnClickedWithTag:self.selectedBtn.tag];
        }
    }

}

- (void)btnClicked:(UIButton *)sender {
    if (self.selectedBtn.tag != sender.tag) {
        [self setBtnSelectedWithTag:sender.tag];
    }
}
@end
