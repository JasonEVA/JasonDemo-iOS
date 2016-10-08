//
//  MyTTTLabel.h
//  JasonDemo
//
//  Created by jasonwang on 16/8/11.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface MyTTTLabel : TTTAttributedLabel
- (MyTTTLabel *(^)(id))nameBlock;
- (MyTTTLabel *(^)(id))ageBlock;
@end
