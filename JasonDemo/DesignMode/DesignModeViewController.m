//
//  DesignModeViewController.m
//  JasonDemo
//
//  Created by jasonwang on 2016/12/8.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "DesignModeViewController.h"
#import "JWWatchModel.h"

@interface DesignModeViewController ()
@property (nonatomic, strong) JWWatchModel *JWModel;
@end

@implementation DesignModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.JWModel = [JWWatchModel new];
    
    [self.JWModel addObserver:self forKeyPath:@"JWName" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:@"你考了几分"];
    UIBarButtonItem *changeBtn = [[UIBarButtonItem alloc] initWithTitle:@"戳我啊" style:UIBarButtonItemStylePlain target:self action:@selector(changeClick)];
    [self.navigationItem setRightBarButtonItem:changeBtn];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.JWModel removeObserver:self forKeyPath:@"JWName"];
}

- (void)changeClick {
    self.JWModel.JWName = [NSString stringWithFormat:@"Jason考了%u分",arc4random() % 100];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"JWName"]) {
        UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:(__bridge NSString *)context message:[self dictionaryToJson:change] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alterVC addAction:action];
        [self presentViewController:alterVC animated:YES completion:nil];
        NSLog(@"%@",change);
    }
}

//字典转字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
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
