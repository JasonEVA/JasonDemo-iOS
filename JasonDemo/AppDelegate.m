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
    ViewController *VC = [[ViewController alloc] init];
    UINavigationController *navVC  =[[UINavigationController alloc] initWithRootViewController:VC];
    
    [self.window setRootViewController:navVC];
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
    [MessageManager setApplicationConfig:@{im_task_uid:@(IM_Applicaion_task),
                                           im_approval_uid:@(IM_Applicaion_approval),                                                              im_schedule_uid:@(IM_Applicaion_schedule)
                                           }];
    [MessageManager setAppName:@"launchr" appToken:@"verify-code" wsIP:@"ws://192.168.1.251:20000" httpIP:@"http://192.168.1.251:20001/launchr" testIP:@"192.168.1.249" loginType:nil];
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
@end
