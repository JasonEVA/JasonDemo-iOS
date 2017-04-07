//
//  UINavigationBar+JWGradient.m
//  HMClient
//
//  Created by jasonwang on 2017/4/5.
//  Copyright © 2017年 YinQ. All rights reserved.
//

#import "UINavigationBar+JWGradient.h"
#import <objc/runtime.h>
#import "UIColor+HexExtension.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation UINavigationBar (JWGradient)
static char overlayKey;
static char gradientLayerKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAGradientLayer *)gradientLayer
{
    return objc_getAssociatedObject(self, &gradientLayerKey);
}

- (void)setGradientLayer:(CAGradientLayer *)gradientLayer
{
    objc_setAssociatedObject(self, &gradientLayerKey, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)jw_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)jw_setBackgroundViewLayerWithAlpha:(CGFloat)alpha {
    if (!self.gradientLayer) {
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.locations = @[@0.1, @1.0];
        self.gradientLayer.startPoint = CGPointMake(0, 1.0);
        self.gradientLayer.endPoint = CGPointMake(1.0, 0);
        self.gradientLayer.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 142);
    }
    self.gradientLayer.colors = @[(__bridge id)[[UIColor colorWithHexString:@"3cd395" alpha:alpha] CGColor], (__bridge id)[[UIColor colorWithHexString:@"31c9ba" alpha:alpha] CGColor]];
    [self.overlay.layer addSublayer:self.gradientLayer];
    [self.overlay setClipsToBounds:YES];
}

- (void)jw_removeOverSubLayer {
    [self.gradientLayer removeFromSuperlayer];
    self.gradientLayer = nil;
}

- (void)jw_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)jw_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
        }
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
            obj.alpha = alpha;
        }
    }];
}

- (void)jw_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
