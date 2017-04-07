//
//  HMPersonSpaceNavigationController.m
//  HMClient
//
//  Created by jasonwang on 2017/4/6.
//  Copyright © 2017年 YinQ. All rights reserved.
//

#import "HMPersonSpaceNavigationController.h"
#import "UIBarButtonItem+BackExtension.h"
#import "UINavigationBar+JWGradient.h"

@interface HMPersonSpaceNavigationController ()

@end

@implementation HMPersonSpaceNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{   //拦截所有push进来的子控制器
    UIColor * color = [UIColor cyanColor];
    [self.navigationBar jw_setBackgroundColor:[color colorWithAlphaComponent:1]];

    if(self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNamed:@"back.png" targe:self action:@selector(backUp)];
        
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)backUp
{
    [self popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
