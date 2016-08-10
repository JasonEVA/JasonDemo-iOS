//
//  ViewController.m
//  test201685
//
//  Created by jasonwang on 16/8/5.
//  Copyright © 2016年 JasonWang. All rights reserved.
//

#import "ViewController.h"
#import <MintmedicalDrugStore/MDSDrugStoreMainViewController.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MDSDrugStoreMainViewController *vc = [MDSDrugStoreMainViewController new];
    [self addChildViewController:vc];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
