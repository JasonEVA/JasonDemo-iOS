//
//  CaculatorMaker.h
//  JasonDemo
//
//  Created by jasonwang on 2016/12/14.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorMaker : NSObject
@property (nonatomic,assign) float result;

//加法
- (CaculatorMaker *(^)(float))add;
//减
- (CaculatorMaker *(^)(float))sub;
//乘
- (CaculatorMaker *(^)(float))muilt;
//除
- (CaculatorMaker *(^)(float))divide;

@end
