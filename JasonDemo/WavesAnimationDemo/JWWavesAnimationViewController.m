//
//  JWWavesAnimationViewController.m
//  JasonDemo
//
//  Created by jasonwang on 2016/12/15.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "JWWavesAnimationViewController.h"
#import "JWWavesAnimationView.h"
#import <Masonry/Masonry.h>
@interface JWWavesAnimationViewController ()

@end

@implementation JWWavesAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    JWWavesAnimationView *waveView = [JWWavesAnimationView new];
    [waveView.layer setCornerRadius:50];
    [waveView setClipsToBounds:YES];

    [self.view addSubview:waveView];
    
    [waveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(@100);
    }];
    
    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
    
    [waveView setUp];
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
