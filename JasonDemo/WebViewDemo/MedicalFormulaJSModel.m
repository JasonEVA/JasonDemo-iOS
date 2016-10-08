//
//  MedicalFormulaJSModel.m
//  MintmedicalSDK
//
//  Created by jasonwang on 16/8/16.
//  Copyright © 2016年 JasonWang. All rights reserved.
//

#import "MedicalFormulaJSModel.h"

@implementation MedicalFormulaJSModel

- (void)getToolName:(NSString *)title{
    if ([self.delegate respondsToSelector:@selector(MedicalFormulaJSModelDelegateCallBack_titel:)]) {
        [self.delegate MedicalFormulaJSModelDelegateCallBack_titel:title];
    }
}

- (void)goToPrescribeWithUserId:(NSString *)userId :(NSString *)healthyId {
    NSLog(@"%@,%@",userId,healthyId);
}

@end
