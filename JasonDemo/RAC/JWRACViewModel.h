//
//  JWRACViewModel.h
//  JasonDemo
//
//  Created by 王喆 on 2017/12/14.
//  Copyright © 2017年 jasonwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface JWRACViewModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *IDNum;
@property (nonatomic, copy) NSString *bankNum;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, strong, readonly)  RACCommand  *nextCommand; // <##>

@end
