//
//  TTTDemoViewController.m
//  JasonDemo
//
//  Created by jasonwang on 16/8/10.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "TTTDemoViewController.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import "MyTTTLabel.h"
#import "UIImage+EX.h"

@interface TTTDemoViewController ()

@end

@implementation TTTDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 100, 44)];
    [but setUserInteractionEnabled:NO];
    [but setBackgroundImage:[[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(1, 1)] cutCircleImage] forState:UIControlStateNormal];
    [self.view addSubview:but];
    
    MyTTTLabel *tttLb = [[MyTTTLabel alloc] initWithFrame:CGRectMake(20, 100, 300, 80)];
    tttLb.nameBlock(@"Jason").ageBlock(@"18");
    [tttLb setNumberOfLines:0];
    [tttLb setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:tttLb];
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:@"梵蒂冈的风格1\n，萨克斯决定dddd，但是jkdsnks。的范德萨发电风扇的的发送到发大幅度水电费水电费水电费第三方水电费水电费第三方第三方是电风扇的法撒旦是安抚啊" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                                                                                         NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [mutableAttributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                                 NSForegroundColorAttributeName:(__bridge id)[UIColor yellowColor].CGColor,
                                                                 (NSString *)kTTTBackgroundFillColorAttributeName:(__bridge id)[UIColor blueColor].CGColor,
                                                                 (NSString *)kTTTBackgroundCornerRadiusAttributeName:@2} range:NSMakeRange(0, 20)];
    [tttLb setAttributedText:mutableAttributedString];
    NSArray *arr = [self getLinesArrayOfStringInLabel:tttLb];
    NSLog(@"%@",arr);
    
    //假设这是一个网络获取的URL
    NSString *path = @"http://www.yxzoo.com/uploads/allimg/160803/1-160P3113351.jpg";
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
    //调用获取图片扩展名
    NSString *string = [self contentTypeForImageData:data];
    //输出结果为 jpeg
    NSLog(@"%@",string);
    // Do any additional setup after loading the view.
}

//这部分代码不但能够求出一个label中文字行数，更厉害的是能够求出每一行的内容是什么
- (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label{
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        //NSLog(@"''''''''''''''''''%@",lineString);
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//通过图片Data数据第一个字节 来获取图片扩展名
- (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
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
