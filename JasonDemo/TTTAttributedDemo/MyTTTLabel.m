//
//  MyTTTLabel.m
//  JasonDemo
//
//  Created by jasonwang on 16/8/11.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "MyTTTLabel.h"
#import <objc/runtime.h>

@implementation MyTTTLabel

//+ (void)load { //load方法是所有继承NSObject类都拥有的类方法，可以直接理解为这个方法加载的灰常早灰常的早！！
//    [super load];
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        
//        SEL originalSelector = @selector(drawBackground:inRect:context:); //TTTAttributedLabel 对应的处理高亮背景方法
//        SEL swizzledSelector = @selector(JWdrawBackground:inRect:context:); //替换的方法
//        
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        if (didAddMethod) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        }
//        else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}

- (void)drawBackground:(CTFrameRef)frame
                inRect:(CGRect)rect
               context:(CGContextRef)c
{
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    CGPoint origins[[lines count]];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    
    CFIndex lineIndex = 0;
    for (id line in lines) {
        CGFloat ascent = 0.0f, descent = 0.0f, leading = 0.0f;
        CGFloat width = (CGFloat)CTLineGetTypographicBounds((__bridge CTLineRef)line, &ascent, &descent, &leading) ;
        
        /**
         *  解决中英文数字字符混输状态下，高亮背景高度不同意问题
         *  因为TTT是一个字符一个字符画的背景，所以先将所有字符遍历，取出最大的高度和最小的Y，再交给TTT进行处理。
         *  这样画出来的高亮背景高度就会一致
         */
        CGFloat  myHeight = 0.0f;
        CGFloat  myY = 1000.0f;
        for (id glyphRun in (__bridge NSArray *)CTLineGetGlyphRuns((__bridge CTLineRef)line)) {
            NSDictionary *attributes = (__bridge NSDictionary *)CTRunGetAttributes((__bridge CTRunRef) glyphRun);
            UIEdgeInsets fillPadding = [[attributes objectForKey:kTTTBackgroundFillPaddingAttributeName] UIEdgeInsetsValue];
            CGRect runBounds = CGRectZero;
            CGFloat runAscent = 0.0f;
            CGFloat runDescent = 0.0f;
            runBounds.size.width = (CGFloat)CTRunGetTypographicBounds((__bridge CTRunRef)glyphRun, CFRangeMake(0, 0), &runAscent, &runDescent, NULL) + fillPadding.left + fillPadding.right;
            
            runBounds.origin.y = origins[lineIndex].y + rect.origin.y - fillPadding.bottom - rect.origin.y;
            runBounds.origin.y -= runDescent;
            
            //取较大高的作为整体高度
            myHeight = MAX((runAscent + runDescent + fillPadding.top + fillPadding.bottom), myHeight);
            
            //取较小的作为整体的Y
            myY = MIN(runBounds.origin.y, myY);
        }
        
        for (id glyphRun in (__bridge NSArray *)CTLineGetGlyphRuns((__bridge CTLineRef)line)) {
            NSDictionary *attributes = (__bridge NSDictionary *)CTRunGetAttributes((__bridge CTRunRef) glyphRun);
            CGColorRef strokeColor = (__bridge CGColorRef)[attributes objectForKey:kTTTBackgroundStrokeColorAttributeName];
            CGColorRef fillColor = (__bridge CGColorRef)[attributes objectForKey:kTTTBackgroundFillColorAttributeName];
            UIEdgeInsets fillPadding = [[attributes objectForKey:kTTTBackgroundFillPaddingAttributeName] UIEdgeInsetsValue];
            CGFloat cornerRadius = [[attributes objectForKey:kTTTBackgroundCornerRadiusAttributeName] floatValue];
            CGFloat lineWidth = [[attributes objectForKey:kTTTBackgroundLineWidthAttributeName] floatValue];
            
            if (strokeColor || fillColor) {
                CGRect runBounds = CGRectZero;
                CGFloat runAscent = 0.0f;
                CGFloat runDescent = 0.0f;
                
                runBounds.size.width = (CGFloat)CTRunGetTypographicBounds((__bridge CTRunRef)glyphRun, CFRangeMake(0, 0), &runAscent, &runDescent, NULL) + fillPadding.left + fillPadding.right;
                runBounds.size.height = myHeight;
                
                CGFloat xOffset = 0.0f;
                CFRange glyphRange = CTRunGetStringRange((__bridge CTRunRef)glyphRun);
                switch (CTRunGetStatus((__bridge CTRunRef)glyphRun)) {
                    case kCTRunStatusRightToLeft:
                        xOffset = CTLineGetOffsetForStringIndex((__bridge CTLineRef)line, glyphRange.location + glyphRange.length, NULL);
                        break;
                    default:
                        xOffset = CTLineGetOffsetForStringIndex((__bridge CTLineRef)line, glyphRange.location, NULL);
                        break;
                }
                
                runBounds.origin.x = origins[lineIndex].x + rect.origin.x + xOffset - fillPadding.left - rect.origin.x;
                runBounds.origin.y = myY;
                
                // Don't draw higlightedLinkBackground too far to the right
                if (CGRectGetWidth(runBounds) > width) {
                    runBounds.size.width = width;
                }
                
                CGPathRef path = [[UIBezierPath bezierPathWithRoundedRect:CGRectInset(UIEdgeInsetsInsetRect(runBounds, self.linkBackgroundEdgeInset), lineWidth, lineWidth) cornerRadius:cornerRadius] CGPath];
                
                CGContextSetLineJoin(c, kCGLineJoinRound);
                
                if (fillColor) {
                    CGContextSetFillColorWithColor(c, fillColor);
                    CGContextAddPath(c, path);
                    CGContextFillPath(c);
                }
                
                if (strokeColor) {
                    CGContextSetStrokeColorWithColor(c, strokeColor);
                    CGContextAddPath(c, path);
                    CGContextStrokePath(c);
                }
            }
        }
        
        lineIndex++;
    }
}

- (CGSize)intrinsicContentSize {
    CGSize originalSize = [super intrinsicContentSize];
    return CGSizeMake(originalSize.width + 10, originalSize.height + 10);
}

- (MyTTTLabel *(^)(id))nameBlock {
    return ^id(id name) {
        NSLog(name);
        return self;
    };
}

- (MyTTTLabel *(^)(id))ageBlock {
   return ^id(id age) {
        NSLog(age);
        return self;
    };
}

- (void)name {
    NSLog(@"JasonWang");
}

- (void)age {
    NSLog(@"18");
}

@end
