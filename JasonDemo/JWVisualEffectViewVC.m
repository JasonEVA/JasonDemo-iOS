//
//  JWVisualEffectViewVC.m
//  JasonDemo
//
//  Created by jasonwang on 16/7/25.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "JWVisualEffectViewVC.h"

@implementation JWVisualEffectViewVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"XXXXX"]];
    bgView.frame = self.view.frame;
    
    UIVisualEffectView *visView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight] ];
    visView.frame = self.view.frame;
    [self.view addSubview:bgView];
    [self.view addSubview:visView];
    
}
@end
