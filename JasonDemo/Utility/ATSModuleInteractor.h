//
//  ATSModuleInteractor.h
//  ATSAppStructure
//
//  Created by Andrew Shen on 2017/2/15.
//  Copyright © 2017年 AndrewShen. All rights reserved.
//  界面跳转基类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ATSModuleInteractor : NSObject

@property (nonatomic, copy, readonly)  NSString  *navigatorName; // <##>

+ (instancetype)sharedInstance;

- (void)configBaseNavigatorClassName:(NSString *)baseNaviName;

// 普通push
- (void)pushToVC:(UIViewController *)VC;

- (void)presentToVC:(UIViewController *)VC animated:(BOOL)flag completion:(void (^)(void))completion;

// tabbar切换
- (void)showTabbarVCAtIndex:(NSUInteger)index;


@end
