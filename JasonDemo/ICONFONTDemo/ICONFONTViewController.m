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
@property (nonatomic, strong) UIButton *yesBtn;
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
    
    [self.view addSubview:self.yesBtn];
    
    [self.yesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(50);
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doSomething:) name:@"APPTerminate" object:nil];

    // Do any additional setup after loading the view.
}

#pragma mark -处理通知
-(void)doSomething:(NSNotification*)notification{
    NSLog(@"收到通知");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    // Dispose of any resources that can be recreated.
}

- (void)testProtocol {
    NSLog(@"调用我的protocolKit了");
}

- (UIButton *)yesBtn {
    if (!_yesBtn) {
        _yesBtn = [UIButton new];
        [_yesBtn setImage:[UIImage imageNamed:@"im_choose"] forState:UIControlStateNormal];
        [_yesBtn setImage:[UIImage imageNamed:@"im_choosed"] forState:UIControlStateSelected];
        [_yesBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        UILabel *lb = [UILabel new];
        [lb setText:@"是"];
        [_yesBtn addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_yesBtn.imageView.mas_right).offset(5);
            make.centerY.equalTo(_yesBtn.imageView);
        }];
    }
    return _yesBtn;
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
