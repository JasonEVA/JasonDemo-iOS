//
//  AppDelegate.m
//  JasonDemo
//
//  Created by jasonwang on 16/3/8.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <MintcodeIM/MintcodeIM.h>
#import <UserNotifications/UserNotifications.h>
#import "TTTDemoViewController.h"
#import "HMPersonSpaceNavigationController.h"
#import "JWNavAnimationViewController.h"

NSString *const im_task_uid     = @"PWP16jQLLjFEZXLe@APP";
NSString *const im_approval_uid = @"ADWpPoQw85ULjnQk@APP";
NSString *const im_schedule_uid = @"l6b3YdE9LzTnmrl7@APP";
// 数值在10001-19999之间
typedef NS_ENUM(NSUInteger, IM_Applicaion_Type) {
    IM_Applicaion_task = 10001,
    IM_Applicaion_approval,
    IM_Applicaion_schedule,
};
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    ViewController *VC = [[ViewController alloc] init];
    UINavigationController *navVC  =[[UINavigationController alloc] initWithRootViewController:VC];
    [navVC.tabBarItem setTitle:@"主页"];

    JWNavAnimationViewController *meVC = [JWNavAnimationViewController new];

    HMPersonSpaceNavigationController *meNav = [[HMPersonSpaceNavigationController alloc] initWithRootViewController:meVC];
    [meNav.tabBarItem setTitle:@"我的"];
    [tabVC setViewControllers:@[navVC,meNav]];
    
    [self.window setRootViewController:tabVC];

    //  第一步 设置 mask 蒙版 和动画
    CALayer *maskLayer = [CALayer layer];
    [maskLayer setFrame:CGRectMake(0, 0, 200, 120)];
    maskLayer.contents = (id)[UIImage imageNamed:@"111111"].CGImage;
    tabVC.view.layer.mask = maskLayer;
    maskLayer.position = tabVC.view.center;
    CAKeyframeAnimation *transAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    transAnimation.duration = 1;
    transAnimation.beginTime = CACurrentMediaTime() + 1;
    CGRect firstBounds = tabVC.view.layer.mask.bounds;
    CGRect secondBounds = CGRectMake(0, 0, 400, 240);
    CGRect finalBounds = CGRectMake(0, 0, 20000, 20000);

    [transAnimation setValues:@[[NSValue valueWithCGRect:firstBounds],[NSValue valueWithCGRect:secondBounds],[NSValue valueWithCGRect:finalBounds]]];
    
    transAnimation.keyTimes = @[@0,@0.5,@1];
    transAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    transAnimation.removedOnCompletion = NO;
    transAnimation.fillMode = kCAFillModeForwards;
    
    [tabVC.view.layer.mask addAnimation:transAnimation forKey:@"maskAnimation"];
     // 第二步 设置 NavigationController的view的形变动画
    CAKeyframeAnimation *viewTransAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];

    viewTransAnimation.duration = 0.6;
    viewTransAnimation.keyTimes = @[@0,@0.5,@1];
    viewTransAnimation.beginTime = CACurrentMediaTime() + 1.1;
    [viewTransAnimation setValues:@[[NSValue valueWithCATransform3D:CATransform3DIdentity],[NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.1, 1.1, 1)],[NSValue valueWithCATransform3D:CATransform3DIdentity]]];
    
    [tabVC.view.layer addAnimation:viewTransAnimation forKey:@"viewAnimation"];
    tabVC.view.layer.transform = CATransform3DIdentity;
    //  第三步 添加白色遮罩
    UIView *whiteView = [[UIView alloc] initWithFrame:tabVC.view.bounds];
    [whiteView setBackgroundColor:[UIColor whiteColor]];
    [tabVC.view addSubview:whiteView];
    
    [UIView animateWithDuration:0.1 delay:1.35 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        whiteView.alpha = 0;
    } completion:^(BOOL finished) {
        [whiteView removeFromSuperview];
        tabVC.view.layer.mask = nil;
    }];
    
    
    
    
    [self IMDemoNeedMethod];
    
    //注册本地通知
    UNUserNotificationCenter *notificat = [UNUserNotificationCenter currentNotificationCenter];
    notificat.delegate = self;
    
    [notificat requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
    }];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"APPTerminate" object:self];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)IMDemoNeedMethod
{
//    [MessageManager setApplicationConfig:@{im_task_uid:@(IM_Applicaion_task),
//                                           im_approval_uid:@(IM_Applicaion_approval),                                                              im_schedule_uid:@(IM_Applicaion_schedule)
//                                           }];
//    [MessageManager setAppName:@"launchr" appToken:@"verify-code" wsIP:@"ws://192.168.1.251:20000" httpIP:@"http://192.168.1.251:20001/launchr" testIP:@"192.168.1.249" loginType:nil];
    // loginType 可以使用bundle id来作为区分，用于给服务器绑定推送证书，无填nil
    // 消息推送注册
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound|UIUserNotificationTypeAlert|UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge];
    }


}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:nil];
    
    //通过通知中心发送通知
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    NSLog(@"点我干嘛");
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"TTT"])
    {
        TTTDemoViewController *VC = [[TTTDemoViewController alloc] init];
        [(UINavigationController *)self.window.rootViewController pushViewController:VC animated:YES];
    }
    return YES;
}
@end
