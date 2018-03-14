//
//  ATSModuleInteractor.m
//  ATSAppStructure
//
//  Created by Andrew Shen on 2017/2/15.
//  Copyright © 2017年 AndrewShen. All rights reserved.
//

#import "ATSModuleInteractor.h"

@interface ATSModuleInteractor ()
@property (nonatomic, copy, readwrite)  NSString  *navigatorName; // <##>

@end

@implementation ATSModuleInteractor

+ (instancetype)sharedInstance {
    static ATSModuleInteractor *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ATSModuleInteractor alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Interface





#pragma mark - Private
- (void)configBaseNavigatorClassName:(NSString *)baseNaviName {
    self.navigatorName = baseNaviName;
}

- (void)pushToVC:(UIViewController *)VC {
    VC.hidesBottomBarWhenPushed = YES;
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(p_pushOrPresentToVC:) withObject:VC afterDelay:0.01];
}

- (void)presentToVC:(UIViewController *)VC animated:(BOOL)flag completion:(void (^)(void))completion {
    UIViewController *originVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    [originVC presentViewController:VC animated:flag completion:completion];
}

// tabbar切换
- (void)showTabbarVCAtIndex:(NSUInteger)index {
    UIViewController *originVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    UINavigationController *navi = [self p_topNavigationControllerFromVC:originVC];
    if (navi) {
        if (navi.presentingViewController) {
            [navi.presentingViewController dismissViewControllerAnimated:NO completion:nil];
            if ([navi.presentingViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *presentingNavi = (UINavigationController *)navi.presentingViewController;
                [presentingNavi popToRootViewControllerAnimated:NO];
            }
        }
        else {
            [navi popToRootViewControllerAnimated:NO];
        }
    }
    if ([originVC isKindOfClass:[UITabBarController class]]) {
        ((UITabBarController *)originVC).selectedIndex = index;
    }
}

#pragma mark - Private
- (UINavigationController *)p_topNavigationControllerFromVC:(UIViewController *)VC {
    if ([VC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *controller = (UITabBarController *)VC;
        UIViewController *selectVC = controller.selectedViewController;
        [VC setHidesBottomBarWhenPushed:YES];
        return [self p_topNavigationControllerFromVC:selectVC];
    }
    else if ([VC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)VC;
        UIViewController *topVC = navi.topViewController;
        if (!topVC.presentedViewController) {
            return navi;
        }
        else {
            return [self p_topNavigationControllerFromVC:topVC.presentedViewController];
        }
    }
    else if ([VC isKindOfClass:[UIViewController class]]) {
        if (!VC.presentedViewController) {
            return nil;
        }
        else {
            return [self p_topNavigationControllerFromVC:VC.presentedViewController];
        }
    }
    return nil;
}

- (void)p_pushOrPresentToVC:(UIViewController *)targetVC {
    UIViewController *originVC = [UIApplication sharedApplication].delegate.window.rootViewController;

    UINavigationController *navi = [self p_topNavigationControllerFromVC:originVC];
    if (navi) {
        [navi pushViewController:targetVC animated:YES];
    }
    else {
        if (!self.navigatorName) {
            navi = [[UINavigationController alloc] initWithRootViewController:targetVC];
        }
        else {
            Class className = NSClassFromString(self.navigatorName);
            navi = [[className alloc] initWithRootViewController:targetVC];
        }
        UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(p_closePresentedControllerCompletion:)];
        NSMutableArray *items = [NSMutableArray arrayWithArray:targetVC.navigationItem.leftBarButtonItems];
        [items insertObject:close atIndex:0];
        [targetVC.navigationItem setLeftBarButtonItems:items];
        [originVC presentViewController:navi animated:YES completion:nil];
    }
}

- (void)p_closePresentedControllerCompletion: (void (^)(void))completion {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootViewController dismissViewControllerAnimated:YES completion:completion];
}

@end
