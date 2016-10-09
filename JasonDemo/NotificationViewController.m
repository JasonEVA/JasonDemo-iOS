//
//  NotificationViewController.m
//  JasonDemo
//
//  Created by jasonwang on 2016/10/9.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "JWVisualEffectViewVC.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:@"发送通知" forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor redColor]];
    
    btn.frame = CGRectMake(100, 100, 100, 50);
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(setUpNotification) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi)name:@"tongzhi" object:nil];

    
    
       // Do any additional setup after loading the view.
}

- (void)setUpNotification {
    UNMutableNotificationContent *notContent = [UNMutableNotificationContent new];
    notContent.badge = @108;
    notContent.title = @"jasonwang";
    notContent.subtitle = @"很好看";
    notContent.body = @"看看大图啊";
    
    NSString * pathImage =  [[NSBundle mainBundle] pathForResource:@"123456"ofType:@"png"];
    // 通知附带其他东西 这是给了个图片  根据上边的路径
    notContent.attachments = @[ [UNNotificationAttachment attachmentWithIdentifier:@"ShowImage" URL:[NSURL fileURLWithPath:pathImage] options:nil error:nil]];
    
    UNTimeIntervalNotificationTrigger *tigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.5 repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"push" content:notContent trigger:tigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"发出通知了");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tongzhi {
    [self.navigationController popViewControllerAnimated:YES];
    JWVisualEffectViewVC *VC = [JWVisualEffectViewVC new];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
