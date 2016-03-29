//
//  CABasicAnimationViewController.m
//  JasonDemo
//
//  Created by jasonwang on 16/3/8.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "CABasicAnimationViewController.h"

@interface CABasicAnimationViewController ()
//创建全局属性的ShapeLayer
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer1;
@property (nonatomic, strong) CAShapeLayer *shapeLayer2;
@end

@implementation CABasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(200, 500, 50, 44)];
    [button setTitle:@"开始" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)click
{
    [self.view.layer removeAllAnimations];
    [self.shapeLayer removeFromSuperlayer];
    [self.shapeLayer1 removeFromSuperlayer];
    [self.shapeLayer2 removeFromSuperlayer];
    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    //self.shapeLayer.frame = self.view.frame;//设置shapeLayer的尺寸和位置
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 30.0f;
    self.shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    
    //创建出贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath moveToPoint:CGPointMake(20, 200)];
    [circlePath addLineToPoint:CGPointMake(200, 200)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.view.layer addSublayer:self.shapeLayer];
    // Do any additional setup after loading the view.
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0f;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue = @(1);
    [self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];

    //创建出CAShapeLayer
    self.shapeLayer2 = [CAShapeLayer layer];
    //self.shapeLayer2.frame = CGRectMake(199, 200, 1, 50);//设置shapeLayer的尺寸和位置
    
    //设置线条的宽度和颜色
    self.shapeLayer2.lineWidth = 1.0f;
    self.shapeLayer2.strokeColor = [UIColor greenColor].CGColor;
    
    //创建出贝塞尔曲线
    UIBezierPath *circlePath2 = [UIBezierPath bezierPath];
    [circlePath2 moveToPoint:CGPointMake(199, 200)];
    [circlePath2 addLineToPoint:CGPointMake(199, 250)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer2.path = circlePath2.CGPath;
    
    //添加并显示
    
    
    CABasicAnimation *pathAnimation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    pathAnimation1.duration = 1.0f;
    pathAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(-179, 0)];
    pathAnimation1.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    [self.view.layer addSublayer:self.shapeLayer2];
    [self.shapeLayer2 addAnimation:pathAnimation1 forKey:@"strokeEndAnimation1"];
    
    [self performSelector:@selector(drewRed) withObject:nil afterDelay:1.0];

}

- (void)drewRed {
    //创建出CAShapeLayer
    self.shapeLayer1 = [CAShapeLayer layer];
    //self.shapeLayer.frame = self.view.frame;//设置shapeLayer的尺寸和位置
    
    //设置线条的宽度和颜色
    self.shapeLayer1.lineWidth = 30.0f;
    self.shapeLayer1.strokeColor = [UIColor redColor].CGColor;
    
    //创建出贝塞尔曲线
    UIBezierPath *circlePath1 = [UIBezierPath bezierPath];
    [circlePath1 moveToPoint:CGPointMake(201, 200)];
    [circlePath1 addLineToPoint:CGPointMake(300, 200)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer1.path = circlePath1.CGPath;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0f;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue = @(1);

    //添加并显示
    [self.view.layer addSublayer:self.shapeLayer1];
    [self.shapeLayer1 addAnimation:pathAnimation forKey:@"strokeEndAnimation"];

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
