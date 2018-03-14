//
//  JWRACViewModel.m
//  JasonDemo
//
//  Created by 王喆 on 2017/12/14.
//  Copyright © 2017年 jasonwang. All rights reserved.
//

#import "JWRACViewModel.h"
#import "ATSModuleInteractor.h"
#import "JWRACTwoViewController.h"

@interface JWRACViewModel()

@property (nonatomic, strong, readwrite)  RACCommand  *nextCommand; // <##>

@end

@implementation JWRACViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_bind];
    }
    return self;
}

- (void)p_bind {
    RACSignal *enableSingal = [RACSignal combineLatest:@[RACObserve(self, name),RACObserve(self, IDNum),RACObserve(self, bankNum),RACObserve(self, phone)] reduce:^(NSString *name,NSString *ID,NSString *bank,NSString *phone){
        return @(name.length > 0 && ID.length >= 15 && bank.length > 15 && phone.length >= 11);
    }];
    
    self.nextCommand = [[RACCommand alloc] initWithEnabled:enableSingal signalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"点击成功");
            JWRACTwoViewController *VC = [JWRACTwoViewController new];
            VC.subject = [RACSubject subject];
            [VC.subject subscribeNext:^(id x) {
                NSLog(@"%@",x);
            }];
            [[ATSModuleInteractor sharedInstance] pushToVC:VC];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}

@end
