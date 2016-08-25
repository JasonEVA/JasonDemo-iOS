//
//  ICONFONTViewController.m
//  JasonDemo
//
//  Created by jasonwang on 16/8/25.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "ICONFONTViewController.h"
#import <Masonry/Masonry.h>
#import "JWIconImageView.h"
#import "UIImage+EX.h"

@interface ICONFONTViewController ()

@end

@implementation ICONFONTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *label = [[UIImageView alloc] initWithImage:[UIImage imageWithDefaultIcon:@"\U0000e603" size:60 color:[UIColor redColor]]];
    [self.view addSubview: label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
