//
//  TodayViewController.m
//  JasonDemoWidget
//
//  Created by jasonwang on 2017/2/28.
//  Copyright © 2017年 jasonwang. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TodayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置weidget展示大小
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000);
    [self.view addSubview:self.tableView];
    [self.tableView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1000)];

    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
    else {
        
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000);
        
    }else{
        
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"123"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setSeparatorInset:UIEdgeInsetsZero];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }

    }
    [cell.textLabel setText:@"通知栏提醒"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.rowHeight = 75;
    }
    return _tableView;
}
@end
