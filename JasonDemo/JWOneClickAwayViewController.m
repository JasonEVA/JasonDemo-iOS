//
//  JWOneClickAwayViewController.m
//  JasonDemo
//
//  Created by jasonwang on 2017/4/7.
//  Copyright © 2017年 jasonwang. All rights reserved.
//

#import "JWOneClickAwayViewController.h"
#import "AZMetaBallCanvas.h"

@interface JWOneClickAwayViewController ()
@property (nonatomic, strong) AZMetaBallCanvas *azMetaBallView;
@property (nonatomic, strong) UIImageView *image;
@end

@implementation JWOneClickAwayViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.view.userInteractionEnabled = YES;

    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    [self.navigationItem setRightBarButtonItem:right];
    self.azMetaBallView = [[AZMetaBallCanvas alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    [self.azMetaBallView setBackgroundColor:[UIColor clearColor]];
    [self.azMetaBallView setUserInteractionEnabled:NO];
    [self.view addSubview:self.azMetaBallView];
    
    self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"9999"]];
    [self.image setFrame:CGRectMake(100, 300, 50, 20)];
    [self.azMetaBallView attach:self.image];

    [self.view addSubview:self.image];
    // Do any additional setup after loading the view.
}

- (void)refresh {
    if (self.image.hidden) {
        [self.image setHidden:NO];
    }
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
