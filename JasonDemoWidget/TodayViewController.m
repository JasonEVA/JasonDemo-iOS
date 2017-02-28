//
//  TodayViewController.m
//  JasonDemoWidget
//
//  Created by jasonwang on 2017/2/28.
//  Copyright © 2017年 jasonwang. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置weidget展示大小
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self openURLContainingAPP];
}

- (void)openURLContainingAPP{
    //通过extensionContext借助host app调起app
    [self.extensionContext openURL:[NSURL URLWithString:@"JasonDemo://TTT"] completionHandler:^(BOOL success) {
        NSLog(@"open url result:%d",success);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
