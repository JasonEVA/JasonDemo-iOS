//
//  ViewController.m
//  JasonDemo
//
//  Created by jasonwang on 16/3/8.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "ViewController.h"
#import "CABasicAnimationViewController.h"
#import "PlayerViewController.h"
#import "IMMessageListViewController.h"
#import "ImagePickerVC.h"
#import "JWVisualEffectViewVC.h"
#import <MintmedicalDiseaseGuidelinesKit/MintmedicalDiseaseGuidelinesKit.h>
#import <MintmedicalDrugStore/MintmedicalDrugStore.h>
#import "TTTDemoViewController.h"
#import "WebViewDemoViewController.h"
#import "ICONFONTViewController.h"
#import "TwoTableViewViewController.h"
#import "NotificationViewController.h"
#import "FilpAnimationViewController.h"
#import "DesignModeViewController.h"
#import "JWIterator.h"
#import "NSObject+CalculatorManager.h"
#import "CaculatorMaker.h"
#import "JWWavesAnimationViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titelArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.navigationItem setTitle:@"Jason Demo"];
    self.titelArr = @[@"横向柱状图动画Demo",@"AVPlayer Demo",@"IM Demo",@"同时选择多张图片Demo",@"毛玻璃效果",@"MDGSDKTest",@"MDSSDKTest",@"TTTDemo",@"webViewDemo",@"IconFontDemo",@"左右联动tableView",@"推送Demo",@"翻转动画",@"设计模式Demo",@"波浪动画Demo"];
    
    //递归
    JWIterator *iteration = [JWIterator new];
    NSLog(@"%@",[iteration JWAllobject:@[@1,@[@4,@3],@6,@[@5,@[@1,@0]]]]);
    //计算器（链式编程）
    
    float result = [NSObject makCalulator:^(CaculatorMaker *make) {
        make.add(1).add(5).sub(4).muilt(2).divide(3);
    }];
    NSLog(@"%f",result);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    [cell.textLabel setText:self.titelArr[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id VC;
    if (indexPath.row == 0) {
        VC = [[CABasicAnimationViewController alloc]init];
    }
    else if (indexPath.row == 1) {
        VC = [[PlayerViewController alloc]init];
    }
    else if (indexPath.row == 2) {
        VC = [[IMMessageListViewController alloc] init];
    }
    else if (indexPath.row == 3) {
        VC = [[ImagePickerVC alloc] init];
    }
    else if (indexPath.row == 4) {
        VC = [[JWVisualEffectViewVC alloc] init];
    }
    else if (indexPath.row == 5) {
        VC = [[MDGDiseaseGuidelMainViewController alloc] init];
    }
    else if (indexPath.row == 6) {
        VC = [[MDSDrugStoreMainViewController alloc] init];
    }
    else if (indexPath.row == 7) {
        VC = [[TTTDemoViewController alloc] init];
    }
    else if (indexPath.row == 8) {
        VC = [[WebViewDemoViewController alloc] init];
    }
    else if (indexPath.row == 9) {
        VC = [[ICONFONTViewController alloc] init];
    }
    else if (indexPath.row == 10) {
        VC = [[TwoTableViewViewController alloc] init];
    }
    else if (indexPath.row == 11) {
        VC = [[NotificationViewController alloc] init];
    }
    else if (indexPath.row == 12) {
        VC = [[FilpAnimationViewController alloc] init];
    }
    else if (indexPath.row == 13) {
        VC = [[DesignModeViewController alloc] init];
    }
    else if (indexPath.row == 14) {
        VC = [[JWWavesAnimationViewController alloc] init];
    }
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
}
@end
