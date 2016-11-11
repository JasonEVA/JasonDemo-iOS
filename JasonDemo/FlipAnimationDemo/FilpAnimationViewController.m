//
//  FilpAnimationViewController.m
//  JasonDemo
//
//  Created by jasonwang on 2016/11/11.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "FilpAnimationViewController.h"

@interface FilpAnimationViewController ()
{
    UIView *fistView;
    UIView *secondView;
    BOOL isFirst;
}
@end

@implementation FilpAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *flipButton=[[UIBarButtonItem alloc]
                                 initWithTitle:@"翻转"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(flip:)];
    self.navigationItem.rightBarButtonItem=flipButton;
    
    
    fistView=[[UIView alloc] initWithFrame:CGRectMake(0, 60, 320, 320)];
    fistView.tag=100;
    fistView.backgroundColor=[UIColor redColor];
    [self.view addSubview:fistView];
    
    secondView=[[UIView alloc] initWithFrame:CGRectMake(0, 60, 320, 320)];
    secondView.tag=101;
    secondView.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:secondView];
}


-(void)flip:(id)sender{
    isFirst ^= 1;
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:isFirst? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    
    
    //这里时查找视图里的子视图（这种情况查找，可能时因为父视图里面不只两个视图）
    NSInteger fist= [[self.view subviews] indexOfObject:[self.view viewWithTag:100]];
    NSInteger seconde= [[self.view subviews] indexOfObject:[self.view viewWithTag:101]];
    
    [self.view exchangeSubviewAtIndex:fist withSubviewAtIndex:seconde];
    
    //当父视图里面只有两个视图的时候，可以直接使用下面这段.
    
    //[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    
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
