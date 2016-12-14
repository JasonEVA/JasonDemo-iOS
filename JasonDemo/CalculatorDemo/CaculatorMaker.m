//
//  CaculatorMaker.m
//  JasonDemo
//
//  Created by jasonwang on 2016/12/14.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

- (CaculatorMaker *(^)(float))add {
    return ^CaculatorMaker *(float value) {
        _result += value;
        return self;
    };
}

- (CaculatorMaker *(^)(float))sub {
    return ^CaculatorMaker *(float value) {
        _result -= value;
        return self;
    };
}
- (CaculatorMaker *(^)(float))muilt {
    return ^CaculatorMaker *(float value) {
        _result *= value;
        return self;
    };
}
- (CaculatorMaker *(^)(float))divide {
    return ^CaculatorMaker *(float value) {
        _result /= value;
        return self;
    };
}
@end
