//
//  JWRACTwoViewController.m
//  JasonDemo
//
//  Created by 王喆 on 2017/12/22.
//  Copyright © 2017年 jasonwang. All rights reserved.
//

#import "JWRACTwoViewController.h"

@interface JWRACTwoViewController ()

@end

@implementation JWRACTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 350, 100, 55)];
    [self.view addSubview:btn];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.subject) {
            [self.subject sendNext:@"返回值"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    NSArray *numbers = @[@1,@2,@3,@4,@5];
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    NSDictionary *dict = @{@"name":@"Jason",@"age":@"24"};
    [dict.rac_sequence.signal subscribeNext:^(id x) {
        RACTupleUnpack(NSString *key,NSString *value) = x;
        NSLog(@"%@ %@",key,value);
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
