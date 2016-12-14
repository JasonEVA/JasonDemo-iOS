//
//  JWIterator.m
//  JasonDemo
//
//  Created by jasonwang on 2016/12/13.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "JWIterator.h"

@interface  JWIterator ()
@property (nonatomic, strong) NSMutableArray *tempArr;
@end

@implementation JWIterator


- (NSArray *)JWAllobject:(NSArray *)array {
    [self JWiterator:array];
    return self.tempArr;
}

- (void)JWiterator:(NSArray *)array {
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [self JWiterator:obj];
        }
        else {
            [self.tempArr addObject:obj];
        }
    }];
}


- (NSMutableArray *)tempArr {
    if (!_tempArr) {
        _tempArr = [NSMutableArray new];
    }
    return _tempArr;
}
@end
