//
//  TTTDemoViewController.m
//  JasonDemo
//
//  Created by jasonwang on 16/8/10.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "TTTDemoViewController.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>
@interface TTTDemoViewController ()

@end

@implementation TTTDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    TTTAttributedLabel *tttLb = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(20, 100, 400, 80)];
    [tttLb setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:tttLb];
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:@"萨克斯决定dddd，但是jkdsnks。" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                                                                                         NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [mutableAttributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                                 NSForegroundColorAttributeName:(__bridge id)[UIColor yellowColor].CGColor,
                                                                 (NSString *)kTTTBackgroundFillColorAttributeName:(__bridge id)[UIColor blueColor].CGColor,
                                                                 (NSString *)kTTTBackgroundCornerRadiusAttributeName:@2} range:NSMakeRange(0, 20)];
    [tttLb setAttributedText:mutableAttributedString];
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
