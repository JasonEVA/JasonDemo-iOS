//
//  UnifiedEggHuntManager.m
//  launcher
//
//  Created by williamzhang on 15/12/24.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

#import "UnifiedEggHuntManager.h"

static CGFloat const duration = 5.0;

@interface UnifiedEggHuntManager ()

@property (nonatomic, strong) NSDictionary *eggImageNames;
@property (nonatomic, assign) BOOL isAnimate;

@property (nonatomic, assign) CGFloat allDuration;

@end

@implementation UnifiedEggHuntManager

+ (id)share {
    static UnifiedEggHuntManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)reviewKeywordFrom:(NSString *)reviewString TargetView:(UIView *)targetView {
    
    NSArray *array = [[self share] reviewKeyword:reviewString];
    if (!array || [array count] == 0) {
        return;
    }
    
    if ([[self share] isAnimate]) {
        return;
    }
    
    NSInteger count = arc4random() % 10 + 1;
    
    for (NSInteger i = 0; i < count; i ++) {
        
        NSInteger index = arc4random() % [array count];
        
        NSString *imageName = array[index];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        
        [targetView addSubview:imageView];
        CGRect frame = imageView.frame;
        
        frame.origin.y = - CGRectGetHeight(frame);
        frame.origin.x = arc4random() % lround(CGRectGetWidth(targetView.frame) - 40) + 40;
        imageView.frame = frame;
        
        frame.origin.x = arc4random() % lround(CGRectGetWidth(targetView.frame) - 40) + 40;
        frame.origin.y = CGRectGetHeight(targetView.frame);
        
        [[self share] setAllDuration:[[self share] allDuration] + duration];
        [UIView animateWithDuration:duration animations:^{
            imageView.frame = frame;
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
            [imageView.layer removeAllAnimations];
            [[self share] setAllDuration:[[self share] allDuration] - duration];
        }];
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        shakeAnimation.fromValue = @(-0.2);
        shakeAnimation.toValue = @(0.2);
        shakeAnimation.duration = 0.4;
        shakeAnimation.autoreverses = YES;
        shakeAnimation.repeatCount = 100;
        [imageView.layer addAnimation:shakeAnimation forKey:@"shake"];
    }
}


- (NSArray *)reviewKeyword:(NSString *)keyword {
    NSString *string = [keyword lowercaseString];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return [self.eggImageNames objectForKey:string];
}

- (BOOL)isAnimate {
    if (self.allDuration > 30) {
        self.allDuration = 0;
    }
    
    if (self.allDuration < 0) {
        self.allDuration = 0;
    }
    
    return self.allDuration != 0;
}

#pragma mark - Initializer
- (NSDictionary *)eggImageNames {
    if (!_eggImageNames) {
        _eggImageNames = @{@"圣诞快乐":@[@"lu",@"oldman"],
                           @"merrychristmas":@[@"lu",@"oldman"],
                           @"驯鹿":@[@"lu"],
                           @"麋鹿":@[@"lu"],
                           @"圣诞老人":@[@"oldman"]
                           };
    }
    return _eggImageNames;
}

@end
